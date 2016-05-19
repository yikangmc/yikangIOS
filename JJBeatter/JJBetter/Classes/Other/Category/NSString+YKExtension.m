//
//  NSString+YKExtension.m
//  deals
//
//  Created by 李洋 on 5/31/15.
//  Copyright (c) 2015 yikang. All rights reserved.
//

#import "NSString+YKExtension.h"
#import "CommonCrypto/CommonDigest.h"
#import "NSData+YKExtension.h"

@implementation NSString (YKExtension)

- (NSString *)aes256_encrypt:(NSString *)key {
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];

    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    //对数据进行加密
    NSData *result = [data aes256_encrypt:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

- (NSString *)aes256_decrypt:(NSString *)key {
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [data aes256_decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSDictionary *)jsonStringToDictionary {
    if (self == nil)    return nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}

- (NSArray *)jsonStringToArray {
    if (self == nil)    return nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return arr;
}


- (BOOL)match:(NSString *)pattern {
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return results.count > 0;
}

- (BOOL)isPhoneNumber {
    return [self match:@"^1[34578]\\d{9}$"];
}



@end

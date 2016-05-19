//
//  NSDictionary+YkExtension.m
//  YouthFountain
//
//  Created by 李洋 on 15/7/25.
//  Copyright (c) 2015年 yikang. All rights reserved.
//

#import "NSDictionary+YkExtension.h"

@implementation NSDictionary (YkExtension)

- (NSString*)dictionaryToJson {
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end

//
//  NSData+YKExtension.h
//  
//
//  Created by 李洋 on 15/7/24.
//  Copyright (c) 2015年 yikang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YKExtension)

/**
 *  对NSData进行加密
 *
 *  @param key 自定义的加密的key
 *
 *  @return 返回加密后的NSData
 */
- (NSData *)aes256_encrypt:(NSString *)key;

/**
 *  对NSData进行解密
 *
 *  @param key 自定义的解密的key
 *
 *  @return 返回解密后的NSData
 */
- (NSData *)aes256_decrypt:(NSString *)key;

@end

//
//  NSString+YKExtension.h
//  deals
//
//  Created by 李洋 on 5/31/15.
//  Copyright (c) 2015 yikang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YKExtension)
/**
 *  对NSString进行加密
 *
 *  @param key 自定义的加密key
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)aes256_encrypt:(NSString *)key;

/**
 *  对NSString进行解密
 *
 *  @param key 自定义的解密key
 *
 *  @return 返回解密后的字符串
 */
- (NSString *)aes256_decrypt:(NSString *)key;

/**
 * @brief 把格式化的JSON格式的字符串转换成字典
 *
 * @return 返回字典
 */
- (NSDictionary *)jsonStringToDictionary;

/**
 * @brief 把格式化的JSON格式的字符串转换成数组
 *
 * @return 返回字典
 */
- (NSArray *)jsonStringToArray;

/**
 *  判断是不是大陆的手机号
 *
 *  @return 是不是大陆手机号
 */
- (BOOL)isPhoneNumber;



@end

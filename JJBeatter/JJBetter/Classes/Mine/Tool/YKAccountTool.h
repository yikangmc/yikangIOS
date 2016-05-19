//
//  YKAccountTool.h
//
//  Created by 李洋 on 15/11/17.
//  Copyright © 2015年 yikang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YKAccount;

@interface YKAccountTool : NSObject
/** 存储账号信息 */
+ (void)saveAccount:(YKAccount *)account;
/** 取出存储的账号信息 */
+(YKAccount *)account;




@end

//
//  YKAccountTool.m
//
//  Created by 李洋 on 15/11/17.
//  Copyright © 2015年 yikang. All rights reserved.
//

#import "YKAccountTool.h"
#import "YKAccount.h"

#define YKAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation YKAccountTool
/** 存储账号信息 */
+ (void)saveAccount:(YKAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:YKAccountFile];
}

/** 取出存储的账号信息 */
+(YKAccount *)account {
    YKAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:YKAccountFile];
    return account;
}




@end

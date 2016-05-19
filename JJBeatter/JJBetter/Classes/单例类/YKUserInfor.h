//
//  YKUserInfor.h
//  JJBetter
//
//  Created by yikang on 16/4/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ABOUTUSERBLOCK)(BOOL isSuccess);

@interface YKUserInfor : NSObject

/** 测试用户是否存在 */
+(void)teseUserExistWithUserName:(NSString *)userName
                       withBlock:(ABOUTUSERBLOCK)isSuccessBlock;




@end

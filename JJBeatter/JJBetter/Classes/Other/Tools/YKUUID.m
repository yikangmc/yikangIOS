//
//  UUID.m
//
//  Created by 李洋 on 15/8/20.
//  Copyright (c) 2015年 yikang. All rights reserved.
//

#import "YKUUID.h"
#import <Foundation/Foundation.h>
#import "SSKeychain.h"

@implementation YKUUID

static NSString *UUID = @"UUID";

+ (NSString *)getUUID
{
    NSString *strUUID = [SSKeychain passwordForService:ServiceForKeychain account:UUID];
    
    //首次执行该方法时，uuid为空
    if (!strUUID) {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        [SSKeychain setPassword:strUUID forService:ServiceForKeychain account:UUID];
    }
    return strUUID;
}




@end


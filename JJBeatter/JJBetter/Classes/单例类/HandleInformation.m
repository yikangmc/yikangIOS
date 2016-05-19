//
//  HandleInformation.m
//  JJBetter
//
//  Created by yikang on 16/4/2.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "HandleInformation.h"
#import "YKAccount.h"

static HandleInformation *handle = nil;

@implementation HandleInformation

//初始化方法
+(instancetype)sharedDataHandle
{
    return [[self alloc] init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (handle == nil) {
            handle = [super allocWithZone:zone];
            
        }
    });
    return handle;
}


#pragma mark  请求个人信息
-(void)getMyInforWithBlock:(RELOADBLOCK)isSuccessBlock
{
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"paramData"] = @"";
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
    paramDic[@"machineCode"] = [YKUUID getUUID];
    NSString *urlStr = [NSString stringWithFormat:@"%@00-17-10", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            
            
            self.MyInformationDic = [NSDictionary dictionaryWithDictionary:json[@"data"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                isSuccessBlock(@"加载个人信息成功");
            });
//            // 获取个人信息
//            YKAccount *model = [[YKAccount alloc] init];
//            [model setValuesForKeysWithDictionary:json[@"data"]];
//            
//            if (model.userName.length) {
//
//                
//            }
        }
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            isSuccessBlock(@"网络故障");
        });
        
    }];
    
}


@end

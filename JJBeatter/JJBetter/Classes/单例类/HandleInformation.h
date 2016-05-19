//
//  HandleInformation.h
//  JJBetter
//
//  Created by yikang on 16/4/2.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RELOADBLOCK)(NSString *isSuccess);

@interface HandleInformation : NSObject

@property (nonatomic,strong)NSDictionary *MyInformationDic;

//初始化单例
+(instancetype)sharedDataHandle;

#pragma mark  请求个人信息
-(void)getMyInforWithBlock:(RELOADBLOCK)isSuccessBlock;




@end

//
//  YKCodeVC.h
//  JJBetter
//
//  Created by yikang on 16/4/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKBaseVC.h"

@interface YKCodeVC : YKBaseVC

// 传值手机号码
@property (nonatomic,copy)NSString *phoneNumber;
// 是否是发送验证码
@property (nonatomic,assign)BOOL isSend;


@end

//
//  YKShowSelectLabelVC.h
//  JJBetter
//
//  Created by yikang on 16/4/27.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKBaseVC.h"

// 传值选择的标签
typedef void (^passSelectLabelBlock)(NSArray *passSelectLabelArr);

@interface YKShowSelectLabelVC : YKBaseVC


@property (nonatomic,copy)passSelectLabelBlock block;

// 传值选择的标签
-(void)passSelectLabelBlockWith:(passSelectLabelBlock)block;



@end

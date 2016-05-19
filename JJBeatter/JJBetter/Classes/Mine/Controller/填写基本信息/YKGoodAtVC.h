//
//  YKGoodAtVC.h
//  JJBetter
//
//  Created by yikang on 16/4/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKBaseVC.h"

@interface YKGoodAtVC : YKBaseVC

// 存放解析出来的擅长model数组
@property (nonatomic,strong)NSArray *allGoodAtArr;
// 存放解析出来的擅长title数组
@property (nonatomic,strong)NSArray *allGoodAtTitleArr;

@property (nonatomic,copy)NSString *promptStr;  // 提示字符串


@end

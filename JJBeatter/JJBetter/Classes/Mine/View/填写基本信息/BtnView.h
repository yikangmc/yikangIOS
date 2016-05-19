//
//  YKGoodAtVC.h
//  JJBetter
//
//  Created by yikang on 16/4/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BtnView : NSObject

/** 行数 */
@property (nonatomic,assign)int number;

//添加一个类方法
-(UIView *)creatBtnWithArray:(NSArray *)dataArr;



@end

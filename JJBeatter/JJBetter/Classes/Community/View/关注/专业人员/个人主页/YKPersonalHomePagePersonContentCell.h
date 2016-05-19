//
//  YKPersonalHomePagePersonContentCell.h
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKPersonalHomePagePersonContentCell : UITableViewCell


@property (nonatomic,strong)UILabel *introduceLabel;

/** 计算个人简介高度 */
+(CGFloat)heightForIntroduceLabel:(NSString *)introduceLabel;



@end

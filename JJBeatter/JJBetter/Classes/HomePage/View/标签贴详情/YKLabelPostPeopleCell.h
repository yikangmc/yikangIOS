//
//  YKLabelPostPeopleCell.h
//  JJBetter
//
//  Created by yikang on 16/4/26.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKLabelPostPeopleCell : UITableViewCell

@property (nonatomic,strong)UILabel *getYesLabel;  // 获支持数

// 添加一个方法(添加头像)
-(void)creatImageViewWithArray:(NSArray *)dataArr;



@end

//
//  YKMyPatientCell.h
//  JJBetter
//
//  Created by yikang on 16/4/4.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKMyPatientModel;

@interface YKMyPatientCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

// 赋值
-(void)setCellWithPatientModel:(YKMyPatientModel *)model;


@end

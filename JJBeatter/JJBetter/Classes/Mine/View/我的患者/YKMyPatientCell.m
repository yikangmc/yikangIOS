//
//  YKMyPatientCell.m
//  JJBetter
//
//  Created by yikang on 16/4/4.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyPatientCell.h"
#import "YKMyPatientModel.h"

@implementation YKMyPatientCell

// 赋值
-(void)setCellWithPatientModel:(YKMyPatientModel *)model
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"myPatient"]];
    self.timeLabel.text = [NSString stringWithFormat:@"注册时间：%@",model.createTime];
    self.userNameLabel.text = [NSString stringWithFormat:@"用户名：%@",model.name];
    self.phoneLabel.text = [NSString stringWithFormat:@"注册手机：%@",model.name];
    
}




- (void)awakeFromNib {
    self.headImageView.layer.cornerRadius = 25;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

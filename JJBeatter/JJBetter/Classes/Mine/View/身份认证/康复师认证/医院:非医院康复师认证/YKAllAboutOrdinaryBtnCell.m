//
//  YKAllAboutOrdinaryBtnCell.m
//  JJBetter
//
//  Created by yikang on 16/5/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKAllAboutOrdinaryBtnCell.h"

@implementation YKAllAboutOrdinaryBtnCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allViews];
    }
    return self;
}


-(void)allViews
{
    self.contentView.backgroundColor = YKGlobalBg;
    
    self.applyCertifiedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.applyCertifiedBtn setBackgroundImage:[UIImage imageNamed:@"globalButtonbg"] forState:UIControlStateNormal];
    [self.applyCertifiedBtn setTitle:@"申请认证" forState:UIControlStateNormal];
    self.applyCertifiedBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.applyCertifiedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.applyCertifiedBtn];
    [self.applyCertifiedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(25 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-25 * WScale);
        make.height.mas_equalTo(35 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"佳佳康复将在您提交认证后的3~7个工作日内给您答复";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = YKb2b2b2;
    label.font = [UIFont systemFontOfSize:12 * WScale];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.applyCertifiedBtn.mas_bottom).offset(9 * WScale);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(345 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}







@end

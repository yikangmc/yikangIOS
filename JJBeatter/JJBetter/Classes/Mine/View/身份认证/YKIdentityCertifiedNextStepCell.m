//
//  YKIdentityCertifiedNextStepCell.m
//  JJBetter
//
//  Created by yikang on 16/5/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKIdentityCertifiedNextStepCell.h"

@implementation YKIdentityCertifiedNextStepCell


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
    
    self.nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextStepBtn setBackgroundImage:[UIImage imageNamed:@"globalButtonbg"] forState:UIControlStateNormal];
    [self.nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextStepBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.nextStepBtn];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(25 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-25 * WScale);
        make.height.mas_equalTo(35 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(90 * WScale);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"选择职业主体后，无法随意编辑，变更时需要通过佳佳康复后台审核，请慎重";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = YKb2b2b2;
    label.font = [UIFont systemFontOfSize:12 * WScale];
    label.numberOfLines = 0;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nextStepBtn.mas_bottom).offset(9 * WScale);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(265 * WScale);
        make.height.mas_equalTo(30 * WScale);
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

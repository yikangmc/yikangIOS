//
//  YKIdentityCertifiedCell.m
//  JJBetter
//
//  Created by yikang on 16/5/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKIdentityCertifiedCell.h"
#import "YKTwoChangeOneView.h"

@implementation YKIdentityCertifiedCell


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
    
    UIView * white = [[UIView alloc] init];
    [self.contentView addSubview:white];
    [white mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(39 * WScale);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"个人主体认证";
    label.textColor = YK656565;
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [white addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(white.mas_centerY);
        make.left.mas_equalTo(white.mas_left).offset(15 * WScale);
    }];
    
    
    self.certifiedMoreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.certifiedMoreBtn setTitle:@"认证说明" forState:UIControlStateNormal];
    self.certifiedMoreBtn.titleLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self.certifiedMoreBtn setTitleColor:YK0faadd forState:UIControlStateNormal];
    [white addSubview:self.certifiedMoreBtn];
    [self.certifiedMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(white.mas_right).offset(-15 * WScale);
        make.centerY.mas_equalTo(white.mas_centerY);
        make.height.mas_equalTo(white.mas_height);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.top.mas_equalTo(white.mas_bottom);
        make.height.mas_equalTo(1 * WScale);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenW / 3 - 1 * WScale);
        make.width.mas_equalTo(1 * WScale);
        make.top.mas_equalTo(line.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenW * 2 / 3 - 1 * WScale);
        make.width.mas_equalTo(1 * WScale);
        make.top.mas_equalTo(line.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    
    // 布局
    self.centerTwoChangeOneView = [[YKTwoChangeOneView alloc] init];
    [self.centerTwoChangeOneView.customBtn setBackgroundImage:[UIImage imageNamed:@"身份认证中"] forState:UIControlStateNormal];
    self.centerTwoChangeOneView.customNameLabel.text = @"我是中医师";
    [self.contentView addSubview:self.centerTwoChangeOneView];
    [self.centerTwoChangeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenW / 3);
        make.width.mas_equalTo(ScreenW / 3 - 1 * WScale);
        make.height.mas_equalTo(150 * WScale);
    }];
    
    self.leftTwoChangeOneView = [[YKTwoChangeOneView alloc] init];
    [self.leftTwoChangeOneView.customBtn setBackgroundImage:[UIImage imageNamed:@"身份认证康"] forState:UIControlStateNormal];
    self.leftTwoChangeOneView.customNameLabel.text = @"我是康复师";
    [self.contentView addSubview:self.leftTwoChangeOneView];
    [self.leftTwoChangeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(ScreenW / 3 - 1 * WScale);
        make.height.mas_equalTo(150 * WScale);
    }];
    
    self.rightTwoChangeOneView = [[YKTwoChangeOneView alloc] init];
    [self.rightTwoChangeOneView.customBtn setBackgroundImage:[UIImage imageNamed:@"身份认证护"] forState:UIControlStateNormal];
    self.rightTwoChangeOneView.customNameLabel.text = @"我是护理人员";
    [self.contentView addSubview:self.rightTwoChangeOneView];
    [self.rightTwoChangeOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenW * 2 / 3);
        make.width.mas_equalTo(ScreenW / 3 - 1 * WScale);
        make.height.mas_equalTo(150 * WScale);
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

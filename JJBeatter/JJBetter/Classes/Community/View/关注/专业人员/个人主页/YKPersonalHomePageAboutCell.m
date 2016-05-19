//
//  YKPersonalHomePageAboutCell.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPersonalHomePageAboutCell.h"

@implementation YKPersonalHomePageAboutCell


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
    UIView *oneView = [[UIView alloc] init];
    oneView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:oneView];
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(40 * WScale);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.top.mas_equalTo(oneView.mas_bottom);
        make.height.mas_equalTo(1 * WScale);
    }];
    
    UIView *twoView = [[UIView alloc] init];
    twoView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:twoView];
    [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(line.mas_bottom);
        make.height.mas_equalTo(32 * WScale);
    }];
    
    // 开始添加
    UILabel *postLabel = [[UILabel alloc] init];
    postLabel.textAlignment = NSTextAlignmentCenter;
    postLabel.text = @"帖子";
    postLabel.textColor = YK636363;
    postLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [oneView addSubview:postLabel];
    
    UILabel *labelLabel = [[UILabel alloc] init];
    labelLabel.textAlignment = NSTextAlignmentCenter;
    labelLabel.text = @"关注的标签";
    labelLabel.textColor = YK636363;
    labelLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [oneView addSubview:labelLabel];
    
    UILabel *focuserLabel = [[UILabel alloc] init];
    focuserLabel.textAlignment = NSTextAlignmentCenter;
    focuserLabel.text = @"关注者";
    focuserLabel.textColor = YK636363;
    focuserLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [oneView addSubview:focuserLabel];
    
    [postLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(oneView.mas_centerX);
        make.centerY.mas_equalTo(oneView.mas_centerY);
        make.width.mas_equalTo(ScreenW / 3);
        make.height.mas_equalTo(oneView.mas_height);
    }];
    [labelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(oneView.mas_centerY);
        make.left.mas_equalTo(oneView.mas_left);
        make.width.mas_equalTo(ScreenW / 3);
    }];
    [focuserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(oneView.mas_centerY);
        make.right.mas_equalTo(oneView.mas_right);
        make.width.mas_equalTo(ScreenW / 3);
    }];
    
    // 外部调用
    self.postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.postBtn.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.postBtn setTitleColor:YK333333 forState:UIControlStateNormal];
    [twoView addSubview:self.postBtn];
    
    self.labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.labelBtn.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.labelBtn setTitleColor:YK333333 forState:UIControlStateNormal];
    [twoView addSubview:self.labelBtn];

    self.focuserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.focuserBtn.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.focuserBtn setTitleColor:YK333333 forState:UIControlStateNormal];
    [twoView addSubview:self.focuserBtn];

    [self.postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(twoView.mas_centerX);
        make.centerY.mas_equalTo(twoView.mas_centerY);
        make.width.mas_equalTo(ScreenW / 3);
        make.height.mas_equalTo(twoView.mas_height);
    }];
    [self.labelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(twoView.mas_centerY);
        make.left.mas_equalTo(twoView.mas_left);
        make.width.mas_equalTo(ScreenW / 3);
    }];
    [self.focuserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(twoView.mas_centerY);
        make.right.mas_equalTo(twoView.mas_right);
        make.width.mas_equalTo(ScreenW / 3);
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

//
//  YKActivityOwnerCell.m
//  JJBetter
//
//  Created by yikang on 16/5/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKActivityOwnerCell.h"

@implementation YKActivityOwnerCell


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
    
    // 上面
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(36 * WScale);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = YK505050;
    label.text = @"活动发起方";
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.width.mas_equalTo(130 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKf0f0f0;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.width.mas_equalTo(355 * WScale);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
   
    
    // 下面
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(line.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 50 * WScale / 2;
    [bottomView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(13 * WScale);
        make.top.mas_equalTo(line.mas_bottom).offset(15 * WScale);
        make.width.mas_equalTo(50 * WScale);
        make.height.mas_equalTo(self.headImageView.mas_width);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK323232;
    self.nameLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [bottomView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(7 * WScale);
        make.top.mas_equalTo(bottomView.mas_top).offset(20 * WScale);
        make.height.mas_equalTo(15 * WScale);
        make.width.mas_equalTo(210 * WScale);
    }];
    
    
    self.hostCountLabel = [[UILabel alloc] init];
    self.hostCountLabel.textColor = YK646464;
    self.hostCountLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [bottomView addSubview:self.hostCountLabel];
    [self.hostCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(7 * WScale);
        make.height.mas_equalTo(13 * WScale);
        make.width.mas_equalTo(210 * WScale);
    }];
    
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:self.focusBtn];
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bottomView.mas_right).offset(-16 * WScale);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(41 * WScale);
        make.height.mas_equalTo(20 * WScale);
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

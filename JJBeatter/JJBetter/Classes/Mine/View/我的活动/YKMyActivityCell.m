//
//  YKMyActivityCell.m
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyActivityCell.h"

@implementation YKMyActivityCell


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
    UIView *gray = [[UIView alloc] init];
    gray.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:gray];
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(10 * WScale);
    }];
    
    
    self.activityImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.activityImg];
    [self.activityImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gray.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(140 * WScale);
    }];
    
    
    // 透明色
    UIView *clear = [[UIView alloc] init];
    clear.backgroundColor = [UIColor blackColor];
    clear.alpha = 0.2;
    [self.activityImg addSubview:clear];
    [clear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.activityImg.mas_left);
        make.right.mas_equalTo(self.activityImg.mas_right);
        make.bottom.mas_equalTo(self.activityImg.mas_bottom);
        make.height.mas_equalTo(30 * WScale);
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = YKffffff;
    self.timeLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [clear addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(clear.mas_left);
        make.right.mas_equalTo(clear.mas_right);
        make.centerY.mas_equalTo(clear.mas_centerY);
        make.height.mas_equalTo(14 * WScale);
    }];
    
    
    // 白色下面
    UIView * white = [[UIView alloc] init];
    white.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:white];
    [white mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.activityImg.mas_bottom);
        make.height.mas_equalTo(40 * WScale);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK505050;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [white addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(white.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(white.mas_centerY);
        make.height.mas_equalTo(16 * WScale);
        make.width.mas_equalTo(220 * WScale);
    }];
    
    
    self.typeImageView = [[UIImageView alloc] init];
    [white addSubview:self.typeImageView];
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.right.mas_equalTo(white.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(14 * WScale);
        make.width.mas_equalTo(self.typeImageView.mas_height);
        self.typeImageView.clipsToBounds = YES;
        self.typeImageView.layer.cornerRadius = 7 * WScale ;
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    self.nameLabel.textColor = YK646464;
    self.nameLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [white addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.typeImageView.mas_left).offset(-5 * WScale);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.height.mas_equalTo(12 * WScale);
        make.width.mas_equalTo(90 * WScale);
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

//
//  YKActivityModelCell.m
//  JJBetter
//
//  Created by yikang on 16/4/19.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKActivityModelCell.h"

@implementation YKActivityModelCell


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
    
    self.activityImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.activityImg];
    [self.activityImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(140 * WScale);
    }];
    
    
    // 顶视图布局
    UIView *topView = [[UIView alloc] init];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.activityImg.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(35 * WScale);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK313131;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [topView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.left.mas_equalTo(topView.mas_left).offset(14 * WScale);
        make.height.mas_equalTo(16 * WScale);
        make.width.mas_equalTo(270 * WScale);
    }];
    
    
    self.chargeLabel = [[UILabel alloc] init];
    self.chargeLabel.font = [UIFont systemFontOfSize:16 * WScale];
    self.chargeLabel.textAlignment = NSTextAlignmentRight;
    [topView addSubview:self.chargeLabel];
    [self.chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.right.mas_equalTo(topView.mas_right).offset(-18 * WScale);
        make.height.mas_equalTo(17 * WScale);
        make.width.mas_equalTo(100 * WScale);
    }];
    
    
    // 底视图布局
    UIView *bottomWhite = [[UIView alloc] init];
    [self.contentView addSubview:bottomWhite];
    [bottomWhite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(40 * WScale);
    }];
    
    
    self.headImg = [[UIImageView alloc] init];
    self.headImg.clipsToBounds = YES;
    self.headImg.layer.cornerRadius = 10 * WScale;
    [bottomWhite addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomWhite.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(bottomWhite.mas_centerY);
        make.height.mas_equalTo(20 * WScale);
        make.width.mas_equalTo(self.headImg.mas_height);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK323232;
    self.nameLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [bottomWhite addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).offset(5 * WScale);
        make.centerY.mas_equalTo(bottomWhite.mas_centerY);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    self.typeImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeImageView];
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(5 * WScale);
        make.height.mas_equalTo(14 * WScale);
        make.width.mas_equalTo(self.typeImageView.mas_height);
        self.typeImageView.clipsToBounds = YES;
        self.typeImageView.layer.cornerRadius = 7 * WScale ;
    }];
    
    
    
    // 右左黑色边框
    UIView *rightView = [[UIView alloc] init];
    rightView.clipsToBounds = YES;
    rightView.layer.cornerRadius = 5 * WScale;
    rightView.layer.borderColor = [UIColor blackColor].CGColor;
    rightView.layer.borderWidth = 0.3;
    [bottomWhite addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bottomWhite.mas_right).offset(-18 * WScale);
        make.centerY.mas_equalTo(bottomWhite.mas_centerY);
        make.width.mas_equalTo(101 * WScale);
        make.height.mas_equalTo(26 * WScale);
    }];
    
    self.joinLabel = [[UILabel alloc] init];
    self.joinLabel.textColor = YK636363;
    self.joinLabel.textAlignment = NSTextAlignmentCenter;
    self.joinLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [rightView addSubview:self.joinLabel];
    [self.joinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(rightView.mas_centerY);
        make.left.mas_equalTo(rightView.mas_left);
        make.right.mas_equalTo(rightView.mas_right);
        make.height.mas_equalTo(12 * WScale);
    }];

    
    //
    UIView *leftView = [[UIView alloc] init];
    leftView.clipsToBounds = YES;
    leftView.layer.cornerRadius = 5 * WScale;
    leftView.layer.borderColor = [UIColor blackColor].CGColor;
    leftView.layer.borderWidth = 0.3;
    [bottomWhite addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightView.mas_left).offset(-10 * WScale);
        make.centerY.mas_equalTo(bottomWhite.mas_centerY);
        make.width.mas_equalTo(61 * WScale);
        make.height.mas_equalTo(26 * WScale);
    }];
    
    UIImageView *addressImg = [[UIImageView alloc] init];
    addressImg.image = [UIImage imageNamed:@"发现界面location"];
    [leftView addSubview:addressImg];
    [addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView.mas_left).offset(5 * WScale);
        make.centerY.mas_equalTo(leftView.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(13);
    }];
    
    self.cityLabel = [[UILabel alloc] init];
    self.cityLabel.textAlignment = NSTextAlignmentCenter;
    self.cityLabel.textColor = YK636363;
    self.cityLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [leftView addSubview:self.cityLabel];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressImg.mas_right).offset(2 * WScale);
        make.centerY.mas_equalTo(leftView.mas_centerY);
        make.height.mas_equalTo(13 * WScale);
        make.width.mas_equalTo(38 * WScale);
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

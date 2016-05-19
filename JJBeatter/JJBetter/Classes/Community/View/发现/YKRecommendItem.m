//
//  YKRecommendItem.m
//  JJBetter
//
//  Created by yikang on 16/4/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKRecommendItem.h"

@implementation YKRecommendItem


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}



-(void)allViews
{
    
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 25 * WScale;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(50 * WScale);
        make.width.mas_equalTo(self.headImageView.mas_height);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:11 * WScale];
    self.nameLabel.textColor = YK323232;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(5 * WScale);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(70 * WScale);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    self.officeLabel = [[UILabel alloc] init];
    self.officeLabel.font = [UIFont systemFontOfSize:10 * WScale];
    self.officeLabel.textColor = YK656565;
    self.officeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.officeLabel];
    [self.officeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(4 * WScale);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(69 * WScale);
        make.height.mas_equalTo(11 * WScale);
    }];
    
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    self.addressLabel.clipsToBounds = YES;
    self.addressLabel.layer.cornerRadius = 12.5 * WScale / 2;
    self.addressLabel.textColor = [UIColor whiteColor];
    self.addressLabel.font = [UIFont systemFontOfSize:8 * WScale];
    self.addressLabel.backgroundColor = YK0faadd;
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12.5 * WScale);
        make.height.mas_equalTo(self.addressLabel.mas_width);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(-12.5 * WScale);
        make.top.mas_equalTo(self.headImageView.mas_top);
    }];
    
    
    
}




@end

//
//  YKEditLabelSectionView.m
//  JJBetter
//
//  Created by yikang on 16/5/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKEditLabelSectionView.h"

@implementation YKEditLabelSectionView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self allViews];
    }
    return self;
}



-(void)allViews
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK1f1f1f;
    self.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(15 * HScale);
        make.width.mas_equalTo(60 * WScale);
    }];
    
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textColor = YK00aadd;
    self.subTitleLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10 * WScale);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(13 * HScale);
        make.width.mas_equalTo(180 * WScale);
    }];
    
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitleColor:YKff2e2e forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15 * WScale);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(50 * WScale);
        make.height.mas_equalTo(15 * HScale);
    }];
    
    
}






@end

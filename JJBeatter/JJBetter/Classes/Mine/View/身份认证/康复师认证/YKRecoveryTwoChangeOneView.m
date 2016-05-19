//
//  YKRecoveryTwoChangeOneView.m
//  JJBetter
//
//  Created by yikang on 16/5/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKRecoveryTwoChangeOneView.h"

@implementation YKRecoveryTwoChangeOneView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}


-(void)allViews
{
    self.customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.customBtn];
    [self.customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(96 * WScale);
        make.height.mas_equalTo(self.customBtn.mas_width);
    }];
    
    
    self.customLabel = [[UILabel alloc] init];
    self.customLabel.textAlignment = NSTextAlignmentCenter;
    self.customLabel.textColor = YKFull153Color;
    self.customLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self addSubview:self.customLabel];
    [self.customLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(150 * WScale);
        make.top.mas_equalTo(self.customBtn.mas_bottom).offset(11 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
}







@end

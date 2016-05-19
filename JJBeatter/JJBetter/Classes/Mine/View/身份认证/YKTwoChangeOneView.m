//
//  YKTwoChangeOneView.m
//  JJBetter
//
//  Created by yikang on 16/5/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKTwoChangeOneView.h"

@implementation YKTwoChangeOneView


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
        make.top.mas_equalTo(self.mas_top).offset(18 * WScale);
        make.width.mas_equalTo(75 * WScale);
        make.height.mas_equalTo(self.customBtn.mas_width);
    }];
    
    
    self.customNameLabel = [[UILabel alloc] init];
    self.customNameLabel.textAlignment = NSTextAlignmentCenter;
    self.customNameLabel.textColor = YK606060;
    self.customNameLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self addSubview:self.customNameLabel];
    [self.customNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(ScreenW / 3 - 2 * WScale);
        make.top.mas_equalTo(self.customBtn.mas_bottom).offset(13 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我要认证";
    label.textColor = YK606060;
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(ScreenW / 3 - 2 * WScale);
        make.top.mas_equalTo(self.customNameLabel.mas_bottom);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
}





@end

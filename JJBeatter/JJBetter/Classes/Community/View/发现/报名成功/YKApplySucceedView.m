//
//  YKApplySucceedView.m
//  JJBetter
//
//  Created by yikang on 16/5/9.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKApplySucceedView.h"

@implementation YKApplySucceedView


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
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"报名成功"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(26 * WScale);
        make.width.mas_equalTo(76 * WScale);
        make.height.mas_equalTo(84 * WScale);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"报名成功";
    label.textColor = YK0faadd;
    label.font = [UIFont systemFontOfSize:16 * WScale];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).offset(15 * WScale);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(17 * WScale);
    }];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.numberOfLines = 2;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"感谢您参加本次活动，您可以返回活动首页与更多好友互动";
    label1.textColor = YK656565;
    label1.font = [UIFont systemFontOfSize:13 * WScale];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(label.mas_bottom).offset(25 * WScale);
        make.left.mas_equalTo(self.mas_left).offset(65 * WScale);
        make.right.mas_equalTo(self.mas_right).offset(-65 * WScale);
        make.height.mas_equalTo(32 * WScale);
    }];
    
    
    self.backToActivityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backToActivityBtn.titleLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.backToActivityBtn setBackgroundImage:[UIImage imageNamed:@"回到活动蓝色"] forState:UIControlStateNormal];
    [self.backToActivityBtn setTitle:@"回到活动" forState:UIControlStateNormal];
    [self.backToActivityBtn setTitleColor:YKffffff forState:UIControlStateNormal];
    [self.backToActivityBtn setBackgroundImage:[UIImage imageNamed:@"回到活动白色"] forState:UIControlStateHighlighted];
    [self.backToActivityBtn setTitle:@"回到活动" forState:UIControlStateHighlighted];
    [self.backToActivityBtn setTitleColor:YK797979 forState:UIControlStateHighlighted];
    [self addSubview:self.backToActivityBtn];
    [self.backToActivityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(label1.mas_bottom).offset(15 * WScale);
        make.width.mas_equalTo(85 * WScale);
        make.height.mas_equalTo(32 * WScale);
    }];
    
    
    
    
    
}






@end

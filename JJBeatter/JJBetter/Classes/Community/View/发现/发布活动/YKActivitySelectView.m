//
//  YKActivitySelectView.m
//  JJBetter
//
//  Created by yikang on 16/5/19.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKActivitySelectView.h"
#import "YKRecoveryTwoChangeOneView.h"


@implementation YKActivitySelectView


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
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请选择你要举办的活动形式";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = YKFull153Color;
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(17 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(15 * WScale);
        make.width.mas_equalTo(250 * WScale);
    }];
    
    
    self.topView = [[YKRecoveryTwoChangeOneView alloc] init];
    [self.topView.customBtn setBackgroundImage:[UIImage imageNamed:@"线上活动"] forState:UIControlStateNormal];
    self.topView.customLabel.text = @"线上活动";
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(label.mas_bottom).offset(28 * WScale);
        make.width.mas_equalTo(140 * WScale);
        make.height.mas_equalTo(122 * WScale);
    }];
    
    
    self.bottomView = [[YKRecoveryTwoChangeOneView alloc] init];
    [self.bottomView.customBtn setBackgroundImage:[UIImage imageNamed:@"线下活动"] forState:UIControlStateNormal];
    self.bottomView.customLabel.text = @"线下活动";
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(48 * WScale);
        make.width.mas_equalTo(140 * WScale);
        make.height.mas_equalTo(122 * WScale);
    }];
    
    
    self.nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextStepBtn setBackgroundImage:[UIImage imageNamed:@"globalButtonbg"] forState:UIControlStateNormal];
    [self.nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextStepBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.nextStepBtn];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(25 * WScale);
        make.right.mas_equalTo(self.mas_right).offset(-25 * WScale);
        make.height.mas_equalTo(35 * WScale);
        make.bottom.mas_equalTo(self.mas_bottom).offset( -70 * WScale);
    }];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.numberOfLines = 0;
    label1.text = @"活动内容需由佳佳康复审核通过后方可发布，审核通过在1~2个工作日内通知您";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = YKb2b2b2;
    label1.font = [UIFont systemFontOfSize:12 * WScale];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nextStepBtn.mas_bottom).offset(6 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(34 * WScale);
        make.width.mas_equalTo(270 * WScale);
    }];
    
    
    
}



@end

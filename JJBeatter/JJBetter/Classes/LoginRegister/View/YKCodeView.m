//
//  YKCodeView.m
//  JJBetter
//
//  Created by yikang on 16/4/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKCodeView.h"

@implementation YKCodeView

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
    // 验证码输入框
    self.codeTF = [[UITextField alloc] init];
    self.codeTF.backgroundColor = [UIColor whiteColor];
    self.codeTF.placeholder = @"请填写短信验证码";
    [self.codeTF setValue:YKFull153Color forKeyPath:@"_placeholderLabel.textColor"];
    self.codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTF.font = [UIFont systemFontOfSize:14 * WScale];
    self.codeTF.keyboardType = UIKeyboardTypePhonePad;
    self.codeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * WScale, 0)];
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(40 * WScale);
    }];
    
    
    // 下一步
    self.nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextStepBtn setBackgroundImage:[UIImage imageNamed:@"globalButtonbg"] forState:UIControlStateNormal];
    self.nextStepBtn.titleLabel.font = [UIFont systemFontOfSize:18 * WScale];
    [self addSubview:self.nextStepBtn];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTF.mas_bottom).offset(26 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(330 * WScale);
        make.height.mas_equalTo(35 * WScale);
    }];
    
    
    // 倒计时
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.textColor = YKFull153Color;
    self.countLabel.backgroundColor = [UIColor clearColor];
    self.countLabel.font = [UIFont systemFontOfSize:13 * WScale];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nextStepBtn.mas_bottom).offset( 15 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(250 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    // 重新发送
    self.resendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.resendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    [self.resendBtn setTitleColor:YK23149252Color forState:UIControlStateNormal];
    self.resendBtn.backgroundColor = [UIColor clearColor];
    self.resendBtn.titleLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self addSubview:self.resendBtn];
    [self.resendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countLabel.mas_bottom).offset(25 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(100 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    

}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}




@end

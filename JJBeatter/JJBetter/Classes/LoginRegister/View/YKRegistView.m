//
//  YKRegistView.m
//  JJBetter
//
//  Created by yikang on 16/4/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKRegistView.h"

@implementation YKRegistView

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
    // 手机号
    self.phoneNumberTF = [[UITextField alloc] init];
    self.phoneNumberTF.backgroundColor = [UIColor whiteColor];
    self.phoneNumberTF.placeholder = @"请填写您的手机号";
    [self.phoneNumberTF setValue:YKFull153Color forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneNumberTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTF.font = [UIFont systemFontOfSize:14 * WScale];
    self.phoneNumberTF.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNumberTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * WScale, 0)];
    self.phoneNumberTF.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.phoneNumberTF];
    [self.phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.mas_equalTo(self.phoneNumberTF.mas_bottom).offset(26 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(330 * WScale);
        make.height.mas_equalTo(35 * WScale);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"您也可以通过账户登录";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13 * WScale];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = YKFull153Color;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nextStepBtn.mas_bottom).offset(26 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(200 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
    // 登录
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:YK23149252Color forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"register_loginButton"] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:18 * WScale];
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(26 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(330 * WScale);
        make.height.mas_equalTo(35 * WScale);
    }];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"注册表示您已阅读并同意";
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:13 * WScale];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = YKFull153Color;
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset( - 56 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(200 * WScale);
        make.height.mas_equalTo(14 * WScale);
    }];

    
    // 协议
    self.protocolBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.protocolBtn setTitle:@"佳佳康复使用协议" forState:UIControlStateNormal];
    [self.protocolBtn setTitleColor:YK23149252Color forState:UIControlStateNormal];
    self.protocolBtn.backgroundColor = [UIColor clearColor];
    self.protocolBtn.titleLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self addSubview:self.protocolBtn];
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(5 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(330 * WScale);
        make.height.mas_equalTo(20 * WScale);
    }];



}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}




@end

//
//  YKLoginView.m
//  JJBetter
//
//  Created by yikang on 16/4/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKLoginView.h"

@implementation YKLoginView

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
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =YKGlobalBg;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.phoneNumberTF.mas_bottom);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(1);
        
    }];
    
    
    // 密码
    self.passWordTF = [[UITextField alloc] init];
    self.passWordTF.backgroundColor = [UIColor whiteColor];
    self.passWordTF.placeholder = @"请输入密码";
    [self.passWordTF setValue:YKFull153Color forKeyPath:@"_placeholderLabel.textColor"];
    self.passWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordTF.font = [UIFont systemFontOfSize:14 * WScale];
    self.passWordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * WScale, 0)];
    self.passWordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passWordTF.secureTextEntry = YES;
    [self addSubview:self.passWordTF];
    [self.passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.phoneNumberTF.mas_height);
    }];
    
    
    // 登录
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"globalButtonbg"] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:18 * WScale];
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordTF.mas_bottom).offset(30 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(330 * WScale);
        make.height.mas_equalTo(35 * WScale);
    }];
    
    
    // 新用户注册
    self.userRegistBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.userRegistBtn setTitle:@"新用户点击注册" forState:UIControlStateNormal];
    [self.userRegistBtn setTitleColor:YKFull153Color forState:UIControlStateNormal];
    self.userRegistBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self addSubview:self.userRegistBtn];
    [self.userRegistBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(10 * WScale);
        make.left.mas_equalTo(self.mas_left).offset(25 * WScale);
        make.width.mas_equalTo(150 * WScale);
        make.height.mas_equalTo(25 * WScale);
    }];
    
    
    // 忘记密码
    self.forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:YKFull153Color forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self addSubview:self.forgetBtn];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userRegistBtn.mas_top);
        make.right.mas_equalTo(self.mas_right).offset( - 25 * WScale);
        make.width.mas_equalTo(100 * WScale);
        make.height.mas_equalTo(25 * WScale);
    }];
    
    
}






-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}




@end

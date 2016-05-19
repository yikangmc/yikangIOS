//
//  YKPasswordView.m
//  JJBetter
//
//  Created by yikang on 16/4/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPasswordView.h"

@implementation YKPasswordView

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
    // 密码
    self.passWordTF = [[UITextField alloc] init];
    self.passWordTF.backgroundColor = [UIColor whiteColor];
    self.passWordTF.placeholder = @"请填写您的手机号";
    [self.passWordTF setValue:YKFull153Color forKeyPath:@"_placeholderLabel.textColor"];
    self.passWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordTF.font = [UIFont systemFontOfSize:14 * WScale];
    self.passWordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * WScale, 0)];
    self.passWordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passWordTF.secureTextEntry = YES;
    [self addSubview:self.passWordTF];
    [self.passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(40 * WScale);
    }];
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =YKGlobalBg;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.passWordTF.mas_bottom);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(1);
        
    }];
    
    
    // 再次密码
    self.rePassWordTF = [[UITextField alloc] init];
    self.rePassWordTF.backgroundColor = [UIColor whiteColor];
    self.rePassWordTF.placeholder = @"请输入密码";
    [self.rePassWordTF setValue:YKFull153Color forKeyPath:@"_placeholderLabel.textColor"];
    self.rePassWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.rePassWordTF.font = [UIFont systemFontOfSize:14 * WScale];
    self.rePassWordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * WScale, 0)];
    self.rePassWordTF.leftViewMode = UITextFieldViewModeAlways;
    self.rePassWordTF.secureTextEntry = YES;
    [self addSubview:self.rePassWordTF];
    [self.rePassWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.passWordTF.mas_height);
    }];
    
    
    // 下一步
    self.nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextStepBtn setBackgroundImage:[UIImage imageNamed:@"globalButtonbg"] forState:UIControlStateNormal];
    self.nextStepBtn.titleLabel.font = [UIFont systemFontOfSize:18 * WScale];
    [self addSubview:self.nextStepBtn];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rePassWordTF.mas_bottom).offset(30 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(330 * WScale);
        make.height.mas_equalTo(35 * WScale);
    }];
    
    
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}




@end

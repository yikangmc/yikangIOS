//
//  YKPasswordVC.m
//  JJBetter
//
//  Created by yikang on 16/4/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPasswordVC.h"
#import "YKPasswordView.h"
#import "YKNavigationController.h"
#import "YKLoginVC.h"

@interface YKPasswordVC ()

@property (nonatomic,strong)YKPasswordView *ykPasswordView;

@end

@implementation YKPasswordVC



#pragma mark  ------  loadView  ------
-(void)loadView
{
    self.ykPasswordView = [[YKPasswordView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykPasswordView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置密码";
    
    
    // button点击事件
    [self.ykPasswordView.nextStepBtn addTarget:self action:@selector(passWordNext:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(passWordBackToUp:)];

}

// 返回上一级
-(void)passWordBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  -----  下一步  ------
-(void)passWordNext:(UIButton *)sender
{
    if (self.ykPasswordView.passWordTF.text.length < 6 || self.ykPasswordView.rePassWordTF.text.length < 6) {
        [MBProgressHUD showError:@"密码长度必须在6位以上" toView:self.view];
        return;
        
    }
    if ([self.ykPasswordView.passWordTF.text  isEqual:@""] || [self.ykPasswordView.rePassWordTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写密码" toView:self.view];
        return;
    }
    if ([self.ykPasswordView.passWordTF.text isEqualToString:self.ykPasswordView.rePassWordTF.text]) {
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        dataDic[@"loginName"] = self.loginName;
        dataDic[@"password"] = self.ykPasswordView.passWordTF.text;
        dataDic[@"machineCode"] = [YKUUID getUUID];
        
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        paramDic[@"paramData"] = dataDic;
        paramDic[@"appId"] = @"10000";
        paramDic[@"accessTicket"] = @"";
        NSString *urlStr = [NSString stringWithFormat:@"%@registerUser", URLSTR];
        
        [MBProgressHUD showMessage:nil toView:self.view];
        [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
            [MBProgressHUD hideHUDForView:self.view];
            
            if ([json[@"status"] isEqualToString:@"000000"]) {
                
                [MBProgressHUD showSuccess:@"注册成功"];
                
                YKLoginVC *ykLoginVC = [[YKLoginVC alloc] init];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"passWord"];
                [[NSUserDefaults standardUserDefaults] setObject:self.loginName forKey:@"1"];
                [[NSUserDefaults standardUserDefaults] setObject:self.ykPasswordView.passWordTF.text forKey:@"2"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.navigationController pushViewController:ykLoginVC animated:NO];
                
            } else {
                
                [MBProgressHUD showError:json[@"message"] toView:self.view];
            }
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
        }];
    }else{
        [MBProgressHUD showError:@"两次输入的密码不一致" toView:self.view];
    }
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

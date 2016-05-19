//
//  YKLoginVC.m
//  JJBetter
//
//  Created by yikang on 16/4/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKLoginVC.h"
#import "YKLoginView.h"
#import "YKRegistVC.h"
#import "YKNavigationController.h"
#import "YKRootTabBarVC.h"
#import "YKAccount.h"

@interface YKLoginVC ()

@property (nonatomic,strong)YKLoginView *ykLoginView;


@end

@implementation YKLoginVC


#pragma mark  -------  loadView  ------
-(void)loadView
{
    self.ykLoginView = [[YKLoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykLoginView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"登录";
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"regist"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(loginBackToUp:)];
    }
    
    // button添加事件
    [self.ykLoginView.loginBtn addTarget:self action:@selector(logLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLoginView.userRegistBtn addTarget:self action:@selector(logUserRegist:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLoginView.forgetBtn addTarget:self action:@selector(logForget:) forControlEvents:UIControlEventTouchUpInside];

    // 取出手机号跟密码
    self.ykLoginView.phoneNumberTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"1"];
    self.ykLoginView.passWordTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"2"];

    // 如果是从设置密码界面进来的直接执行登录
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"passWord"]) {
        
        [self logLogin:nil];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"passWord"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // 判断是否执行自动登录
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"autoLogin"]) {
        [self logLogin:nil];
    }
    
}


// 返回
-(void)loginBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  ------  登录  ---------
-(void)logLogin:(UIButton *)sender
{
    if (![self checkInfo]) return;
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    dataDic[@"loginName"] = self.ykLoginView.phoneNumberTF.text;
    dataDic[@"passWord"] = self.ykLoginView.passWordTF.text;
    dataDic[@"machineCode"] = [YKUUID getUUID];
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"paramData"] = dataDic;
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = @"";
    NSString *urlStr = [NSString stringWithFormat:@"%@login", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            [MBProgressHUD showSuccess:@"登录成功"];
            
            [[NSUserDefaults standardUserDefaults] setObject:self.ykLoginView.phoneNumberTF.text forKey:@"1"];
            [[NSUserDefaults standardUserDefaults] setObject:self.ykLoginView.passWordTF.text forKey:@"2"];
            
            // 设置自动登录
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"autoLogin"];
            // 存储AccessTicket到本地
            [[NSUserDefaults standardUserDefaults] setObject:json[@"data"] forKey:AccessTicket];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            // 获取个人信息
            [[HandleInformation sharedDataHandle] getMyInforWithBlock:^(NSString *isSuccess) {
                
                if ([isSuccess isEqualToString:@"加载个人信息成功"]) {
                    
                    YKAccount *model = [[YKAccount alloc] initWithDict:[HandleInformation sharedDataHandle].MyInformationDic];
                    if ([model.infoWrite integerValue] == 0) {
                        
                        // 选择职位
                        //                        YKSelectPositionVC *selectVC = [[YKSelectPositionVC alloc] init];
                        //                        YKNavigationController *selectNC = [[YKNavigationController alloc] initWithRootViewController:selectVC];
                        //                        [self presentViewController:selectNC animated:NO completion:nil];
                        
                    }else {
                        
                        // 进入我的
                        YKRootTabBarVC *VC = [[YKRootTabBarVC alloc] init];
                        [self presentViewController:VC animated:YES completion:nil];
                    }
                    
                }else {
                    [UIAlertTool AlertWithViewController:self withMessage:@"加载个人信息失败"];
                }
            }];
        } else {
            [MBProgressHUD showError:json[@"message"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络故障,请重新登录" toView:self.view];
    }];
}

/** 检查填写的信息全不全 */
- (BOOL)checkInfo
{
    if (self.ykLoginView.phoneNumberTF.text.length != 11) {
        [MBProgressHUD showError:@"手机号格式不正确" toView:self.view];
        return NO;
    }
    if (!self.ykLoginView.passWordTF.text.length) {
        [MBProgressHUD showError:@"请填写密码" toView:self.view];
        return NO;
    }
    return YES;
}


#pragma mark  -------  注册  --------
-(void)logUserRegist:(UIButton *)sender
{
    YKRegistVC *registVC = [[YKRegistVC alloc] init];
    // 用来实现是否显示返回图标
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:registVC animated:YES];
    
}



#pragma mark  -------  忘记密码  ------
-(void)logForget:(UIButton *)sender
{
    
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

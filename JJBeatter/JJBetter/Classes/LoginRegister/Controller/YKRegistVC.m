//
//  YKRegistVC.m
//  JJBetter
//
//  Created by yikang on 16/4/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKRegistVC.h"
#import "YKRegistView.h"
#import "YKLoginVC.h"
#import "YKCodeVC.h"
#import "YKProtocolVC.h"

@interface YKRegistVC ()

@property (nonatomic,strong)YKRegistView *ykRegistView;

@end

@implementation YKRegistVC


#pragma mark  -----  loadView  ------
-(void)loadView
{
    self.ykRegistView = [[YKRegistView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykRegistView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册";
    
    // button点击事件
    [self.ykRegistView.nextStepBtn addTarget:self action:@selector(registNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykRegistView.loginBtn addTarget:self action:@selector(registLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykRegistView.protocolBtn addTarget:self action:@selector(registProtocol:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"have"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(registBackToUp:)];
    }
    
    // 注册重新发送验证码的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reSendCodeAction) name:@"reSendCodeAction" object:nil];
    

}


// 返回
-(void)registBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  -----  下一步  ------
-(void)registNext:(UIButton *)sender
{
    if (self.ykRegistView.phoneNumberTF.text.length != 11) {
        
        [MBProgressHUD showError:@"手机号格式不正确" toView:self.view];
        return ;
    }
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    dataDic[@"mobileNumber"] = self.ykRegistView.phoneNumberTF.text;
    dataDic[@"machineCode"] = [YKUUID getUUID];
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"paramData"] = dataDic;
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = @"";
    NSString *urlStr = [NSString stringWithFormat:@"%@00-25-01", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            [MBProgressHUD showSuccess:@"发送成功"];
            
            YKCodeVC *code = [[YKCodeVC alloc] init];
            code.isSend = YES;
            code.phoneNumber = self.ykRegistView.phoneNumberTF.text;
            [self.navigationController pushViewController:code animated:YES];
            
        } else {
            
            [MBProgressHUD showError:json[@"message"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
    }];
    
}


#pragma mark  -----  登录  ------
-(void)registLogin:(UIButton *)sender
{
    YKLoginVC *loginVC = [[YKLoginVC alloc] init];
    // 用来实现是否显示返回图标
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"regist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}


#pragma mark  -----  协议  ------
-(void)registProtocol:(UIButton *)sender
{
    YKProtocolVC *protocol = [[YKProtocolVC alloc] init];
    [self.navigationController pushViewController:protocol animated:YES];

}



// 重新发送验证码的通知
-(void)reSendCodeAction
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    dataDic[@"mobileNumber"] = self.ykRegistView.phoneNumberTF.text;
    dataDic[@"machineCode"] = [YKUUID getUUID];
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"paramData"] = dataDic;
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = @"";
    NSString *urlStr = [NSString stringWithFormat:@"%@00-25-01", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            [MBProgressHUD showSuccess:@"发送成功"];
            
        } else {
            
            [MBProgressHUD showError:json[@"message"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
    }];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reSendCodeAction" object:nil];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end

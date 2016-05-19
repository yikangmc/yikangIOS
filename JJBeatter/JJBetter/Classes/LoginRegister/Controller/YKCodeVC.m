//
//  YKCodeVC.m
//  JJBetter
//
//  Created by yikang on 16/4/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKCodeVC.h"
#import "YKCodeView.h"
#import "YKPasswordVC.h"
#import "YKProtocolVC.h"

@interface YKCodeVC ()

@property (nonatomic,strong)YKCodeView *ykCodeView;

/** 计时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 120s */
@property (nonatomic, assign) NSInteger num;


@end

@implementation YKCodeVC


#pragma mark  ------  loadView  -----
-(void)loadView
{
    self.ykCodeView = [[YKCodeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykCodeView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"填写验证码";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(codeBackToUp:)];
    
    // button点击事件
    [self.ykCodeView.nextStepBtn addTarget:self action:@selector(codeNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykCodeView.resendBtn addTarget:self action:@selector(codeReSend:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (self.isSend) {
        self.num = 60;
        [self addTimer];
        self.ykCodeView.countLabel.text = [NSString stringWithFormat:@"重新发送剩余时间%lds", self.num];
    }
    

}

// 返回上一级
-(void)codeBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  -----  下一步  ------
-(void)codeNext:(UIButton *)sender
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    dataDic[@"mobileNumber"] = self.phoneNumber;
    dataDic[@"captchar"] = self.ykCodeView.codeTF.text;
    dataDic[@"machineCode"] = [YKUUID getUUID];
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"paramData"] = dataDic;
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = @"";
    NSString *urlStr = [NSString stringWithFormat:@"%@00-25-02", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            [MBProgressHUD showSuccess:@"验证成功"];
            
            YKPasswordVC *password = [[YKPasswordVC alloc] init];
            password.loginName = self.phoneNumber;
            [self.navigationController pushViewController:password animated:YES];
            
        } else {
            
            [MBProgressHUD showError:json[@"message"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
    }];
    
}


#pragma mark  ------  重新发送  -----
-(void)codeReSend:(UIButton *)sender
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.num = 60;
    [self addTimer];
    self.ykCodeView.countLabel.text = [NSString stringWithFormat:@"重新发送剩余时间%lds", self.num];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reSendCodeAction" object:nil];
    
}


#pragma mark ---------- 添加定时器  -----------
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
//移除定时器
- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}
//定时器每次执行的方法
- (void)countDown
{
    self.ykCodeView.countLabel.text = [NSString stringWithFormat:@"重新发送剩余时间%lds", self.num--];
    if (0 == self.num) {
        [self changeLabelStatus];
    }
}
//改变“发送验证码”按钮的状态，当计时器到0或者vc要消失的时候执行此方法
- (void)changeLabelStatus
{
    [self removeTimer];
    self.ykCodeView.countLabel.text = @"";
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end

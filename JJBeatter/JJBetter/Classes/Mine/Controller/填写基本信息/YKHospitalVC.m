//
//  YKHospitalVC.m
//  JJBetter
//
//  Created by yikang on 16/3/29.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKHospitalVC.h"

@interface YKHospitalVC ()
@property (nonatomic,strong)UITextField *hospitalTF;

@end

@implementation YKHospitalVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"所在医院";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(hospitalBackToUp:)];
    
    // 保存按钮
    [self initRightSaveBtn];
    
    // 输入医院
    [self initHospitalTextField];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, 0, 0);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
    
}



// 返回
-(void)hospitalBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --------- 保存  ------------
-(void)initRightSaveBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 40, 20);
    btn.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:YK23149252Color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hospitalSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
// 保存按钮
-(void)hospitalSaveBtn
{
    if (self.hospitalTF.text.length == 0) {
        [UIAlertTool AlertWithViewController:self withMessage:@"请输入您的医院"];
        return;
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstOrRe"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.hospitalTF.text forKey:@"hospital"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        
        // 保存到服务器
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        dataDic[@"hospital"] = self.hospitalTF.text;
        
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        paramDic[@"paramData"] = dataDic;
        paramDic[@"appId"] = @"10000";
        paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
        paramDic[@"machineCode"] = [YKUUID getUUID];
        NSString *urlStr = [NSString stringWithFormat:@"%@00-17-12", URLSTR];
        
        [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
            
            if ([json[@"status"] isEqualToString:@"000000"]) {
                
                [MBProgressHUD showSuccess:@"提交成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            } else {
                
                [MBProgressHUD showError:json[@"message"] toView:self.view];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
        }];
    }
    
}


// 输入医院
-(void)initHospitalTextField
{
    self.hospitalTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 50 * WScale)];
    self.hospitalTF.placeholder = @"填写您所在的医院";
    [self.hospitalTF setValue:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    self.hospitalTF.backgroundColor = [UIColor whiteColor];
    self.hospitalTF.font = [UIFont systemFontOfSize:14 * WScale];
    self.hospitalTF.leftViewMode = UITextFieldViewModeAlways;
    self.hospitalTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * WScale, 0)];
    [self.view addSubview:self.hospitalTF];
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

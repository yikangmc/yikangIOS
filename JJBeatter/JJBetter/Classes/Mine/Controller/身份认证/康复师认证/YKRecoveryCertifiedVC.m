//
//  YKRecoveryCertifiedVC.m
//  JJBetter
//
//  Created by yikang on 16/5/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKRecoveryCertifiedVC.h"  // 当前界面
#import "YKRecoveryCertifiedView.h"
#import "YKRecoveryTwoChangeOneView.h"

#import "YKHospitalRecoveryCertifiedVC.h"  // 其他界面
#import "YKNoHospitalRecoveryCertifiedVC.h"


@interface YKRecoveryCertifiedVC ()

@property (nonatomic,strong)YKRecoveryCertifiedView *rootView;
@property (nonatomic,copy)NSString *tagSelectedString;  // 记录选择的职位

@end

@implementation YKRecoveryCertifiedVC


#pragma mark  ----  loadView  -----
-(void)loadView
{
    self.rootView = [[YKRecoveryCertifiedView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"康复师认证";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(RecoveryCertifiedBackToUp:)];
    
    
    // 添加点击事件
    [self.rootView.topView.customBtn addTarget:self action:@selector(atHospitalBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.bottomView.customBtn addTarget:self action:@selector(notAtHospitalBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.nextStepBtn addTarget:self action:@selector(recoveryCertifiedNext:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tagSelectedString = @"";
    [self clearAction];
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, 0, 0);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
    
}


#pragma mark  ----  返回  -----
-(void)RecoveryCertifiedBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


// 清空
-(void)clearAction
{
    [self.rootView.topView.customBtn setBackgroundImage:[UIImage imageNamed:@"我在医院"] forState:UIControlStateNormal];
    [self.rootView.bottomView.customBtn setBackgroundImage:[UIImage imageNamed:@"我在市场"] forState:UIControlStateNormal];
    
    self.rootView.topView.customLabel.textColor = YKFull153Color;
    self.rootView.bottomView.customLabel.textColor = YKFull153Color;
    
}


#pragma mark  ----  点击事件  -----
-(void)atHospitalBtn:(UIButton *)sender
{
    [self clearAction];
    
    self.tagSelectedString = @"我在医院";
    [self.rootView.topView.customBtn setBackgroundImage:[UIImage imageNamed:@"我在医院-点击"] forState:UIControlStateNormal];
    self.rootView.topView.customLabel.textColor = YK51b4ec;

}
-(void)notAtHospitalBtn:(UIButton *)sender
{
    [self clearAction];
    
    self.tagSelectedString = @"我在市场";
    [self.rootView.bottomView.customBtn setBackgroundImage:[UIImage imageNamed:@"我在市场-点击"] forState:UIControlStateNormal];
    self.rootView.bottomView.customLabel.textColor = YKade7c6;
    
}
-(void)recoveryCertifiedNext:(UIButton *)sender
{
    if ([self.tagSelectedString isEqualToString:@""]) {
        [UIAlertTool AlertWithViewController:self withMessage:@"请选择您所在的工作主体~"];
        return;
    }
    
    if ([self.tagSelectedString isEqualToString:@"我在医院"]) {
        
        YKHospitalRecoveryCertifiedVC *VC = [[YKHospitalRecoveryCertifiedVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([self.tagSelectedString isEqualToString:@"我在市场"]) {
        
        YKNoHospitalRecoveryCertifiedVC *VC = [[YKNoHospitalRecoveryCertifiedVC alloc] init];
        VC.title = @"非医院康复师认证";
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

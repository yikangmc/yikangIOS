//
//  YKActivitySelectVC.m
//  JJBetter
//
//  Created by yikang on 16/5/19.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKActivitySelectVC.h"  // 当前界面
#import "YKActivitySelectView.h"
#import "YKRecoveryTwoChangeOneView.h"

#import "YKOnlineOfflineActivityVC.h"  // 其他界面


@interface YKActivitySelectVC ()

@property (nonatomic,strong)YKActivitySelectView *rootView;
@property (nonatomic,copy)NSString *tagSelectedString;  // 记录选择的活动形式


@end

@implementation YKActivitySelectVC


#pragma mark  ----  loadView  -----
-(void)loadView
{
    self.rootView = [[YKActivitySelectView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"活动形式";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(ActivitySelectBackToUp:)];
    
    
    // 添加点击事件
    [self.rootView.topView.customBtn addTarget:self action:@selector(onlineAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.bottomView.customBtn addTarget:self action:@selector(offlineBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rootView.nextStepBtn addTarget:self action:@selector(ActivitySelectNext:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tagSelectedString = @"";
    [self clearAction];

}


#pragma mark  ----  返回  -----
-(void)ActivitySelectBackToUp:(UIBarButtonItem *)sender
{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


// 清空
-(void)clearAction
{
    [self.rootView.topView.customBtn setBackgroundImage:[UIImage imageNamed:@"线上活动"] forState:UIControlStateNormal];
    [self.rootView.bottomView.customBtn setBackgroundImage:[UIImage imageNamed:@"线下活动"] forState:UIControlStateNormal];
    
    self.rootView.topView.customLabel.textColor = YKFull153Color;
    self.rootView.bottomView.customLabel.textColor = YKFull153Color;
    
}


#pragma mark  ----  点击事件  -----
-(void)onlineAction:(UIButton *)sender
{
    [self clearAction];
    
    self.tagSelectedString = @"线上活动";
    [self.rootView.topView.customBtn setBackgroundImage:[UIImage imageNamed:@"线上活动-点击"] forState:UIControlStateNormal];
    self.rootView.topView.customLabel.textColor = YK51b4ec;
    
}
-(void)offlineBtn:(UIButton *)sender
{
    [self clearAction];
    
    self.tagSelectedString = @"线下活动";
    [self.rootView.bottomView.customBtn setBackgroundImage:[UIImage imageNamed:@"线下活动-点击"] forState:UIControlStateNormal];
    self.rootView.bottomView.customLabel.textColor = YKade7c6;
    
}
-(void)ActivitySelectNext:(UIButton *)sender
{
    if ([self.tagSelectedString isEqualToString:@""]) {
        [UIAlertTool AlertWithViewController:self withMessage:@"请选择您要举办的活动形式~"];
        return;
    }
    
    YKOnlineOfflineActivityVC *VC = [[YKOnlineOfflineActivityVC alloc] init];
    VC.title = [NSString stringWithFormat:@"发布%@",self.tagSelectedString];
    [self.navigationController pushViewController:VC animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

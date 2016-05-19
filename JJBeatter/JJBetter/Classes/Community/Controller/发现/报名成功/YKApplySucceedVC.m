//
//  YKApplySucceedVC.m
//  JJBetter
//
//  Created by yikang on 16/5/9.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKApplySucceedVC.h"
#import "YKApplySucceedView.h"

@interface YKApplySucceedVC ()

@property (nonatomic,strong)YKApplySucceedView *ykApplySucceedView;

@end

@implementation YKApplySucceedVC


#pragma mark  ----  loadView  -----
-(void)loadView
{
    self.ykApplySucceedView = [[YKApplySucceedView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykApplySucceedView;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ykApplySucceedView.backgroundColor = [UIColor whiteColor];

    self.title = @"报名成功";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(ApplySucceedBackToUp:)];
    
    // 回到活动添加事件
    [self.ykApplySucceedView.backToActivityBtn addTarget:self action:@selector(backToActivityBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}



#pragma mark  ----  返回  -----
-(void)ApplySucceedBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ----  回到活动添加事件  ----
-(void)backToActivityBtnAction:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

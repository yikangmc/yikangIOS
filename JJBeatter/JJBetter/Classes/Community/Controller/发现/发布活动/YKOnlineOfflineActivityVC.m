//
//  YKOnlineOfflineActivityVC.m
//  JJBetter
//
//  Created by yikang on 16/5/19.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKOnlineOfflineActivityVC.h"

@interface YKOnlineOfflineActivityVC ()

@end

@implementation YKOnlineOfflineActivityVC


- (void)viewDidLoad
{
    [super viewDidLoad];

    // 初始化取消与发布button
    [self initCancelAndIssueBtn];
    

    
}


#pragma mark  ----  初始化取消与发布button  -----
-(void)initCancelAndIssueBtn
{
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(0, 0, 40, 20);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:YK1f1f1f forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    UIButton *issueBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    issueBtn.frame = CGRectMake(0, 0, 40, 20);
    [issueBtn setTitle:@"发布" forState:UIControlStateNormal];
    [issueBtn setTitleColor:YK0faadd forState:UIControlStateNormal];
    issueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [issueBtn addTarget:self action:@selector(issueBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:issueBtn];
    
    
}


#pragma mark  ----  取消与发布  -----
-(void)cancelBtn:(UIBarButtonItem *)sender
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"确定退出编辑吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [controller addAction:action];
    [controller addAction:action1];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)issueBtn:(UIBarButtonItem *)sender
{
    
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}





@end

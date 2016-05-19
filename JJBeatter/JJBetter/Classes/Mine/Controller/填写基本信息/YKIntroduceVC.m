//
//  YKIntroduceVC.m
//  JJBetter
//
//  Created by yikang on 16/5/16.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKIntroduceVC.h"
#import "YKIntroduceView.h"

@interface YKIntroduceVC ()

@property (nonatomic,strong)YKIntroduceView *rootView;

@end

@implementation YKIntroduceVC


#pragma mark  ----  loadView  -----
-(void)loadView
{
    self.rootView = [[YKIntroduceView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(IntroduceBackToUp:)];
    
    // 保存按钮
    [self initRightSaveBtn];
    
    
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


#pragma mark  ----  返回  -----
-(void)IntroduceBackToUp:(UIBarButtonItem *)sender
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
    [btn addTarget:self action:@selector(introduceSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
// 保存方法
-(void)introduceSaveBtn
{
    if (self.rootView.textView.text.length > 30) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"超出字数限制啦~" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        
        return;
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end

//
//  YKProtocolVC.m
//  JJBetter
//
//  Created by 李洋 on 16/3/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKProtocolVC.h"

@interface YKProtocolVC ()<UIWebViewDelegate>

@end

@implementation YKProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户使用协议";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(protocolBackToUp:)];
    
    // 展示协议
    [self initWebView];
    
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


// 返回上一级
-(void)protocolBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


// 初始化WebView
-(void)initWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jjkangfu.com/appPage/operation"]]];
    
    
}

#pragma mark  每次加载走得方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end

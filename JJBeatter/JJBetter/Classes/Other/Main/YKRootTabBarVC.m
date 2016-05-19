//
//  YKRootTabBarVC.m
//  JJBetter
//
//  Created by yikang on 16/4/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKRootTabBarVC.h"
#import "YKNavigationController.h"

#import "YKHomePageVC.h"
#import "YKCommunityVC.h"
#import "YKMessageVC.h"
#import "YKMyVC.h"

@interface YKRootTabBarVC ()

@end

@implementation YKRootTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tabBar.translucent = NO;
    
    //监测网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [UIAlertTool AlertWithViewController:self withMessage:@"当前网络状态没有连接"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                break;
            default:
                break;
        }
    }];
    
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    
}


#pragma mark 添加所有子控制器
-(void)setUpAllChildViewController
{
    
    // 1
    YKHomePageVC *vc1 = [[YKHomePageVC alloc] init];
    [self setUpOneChildViewController:vc1 image:[UIImage imageNamed:@"首页（正常状态）"] selectedImage:[UIImage imageNamed:@"首页（选中状态）"] title:@"首页"];
    
    
    // 2
    YKCommunityVC *VC2 = [[YKCommunityVC alloc] init];
    [self setUpOneChildViewController:VC2 image:[UIImage imageNamed:@"社区（正常状态）"] selectedImage:[UIImage imageNamed:@"社区（选中状态）"] title:@"社区"];
    
    
    // 3
    YKMessageVC *VC3 = [[YKMessageVC alloc] init];
    [self setUpOneChildViewController:VC3 image:[UIImage imageNamed:@"消息（正常状态）"] selectedImage:[UIImage imageNamed:@"消息（选中状态）"] title:@"消息"];
    
    
    // 4
    YKMyVC *myViewVC = [[YKMyVC alloc] init];
    [self setUpOneChildViewController:myViewVC image:[UIImage imageNamed:@"我的（正常状态）"] selectedImage:[UIImage imageNamed:@"我的（选中状态）"] title:@"我的"];
    
    
    
}


#pragma mark 设置每一个子控制器
-(void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;

    YKNavigationController *nav = [[YKNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

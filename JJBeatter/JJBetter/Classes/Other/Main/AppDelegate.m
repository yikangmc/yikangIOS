//
//  AppDelegate.m
//  JJBetter
//
//  Created by 李洋 on 16/3/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "AppDelegate.h"
#import "YKLoginVC.h"
#import "YKNavigationController.h"
#import "YKRegistVC.h"
#import "IQKeyboardManager.h"

#import "YKLabelPostDetailVC.h" //
#import "YKIssueQuestionVC.h"

#import "YKRootTabBarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    // 取消在发布问题中的效果
    [[IQKeyboardManager sharedManager] disableDistanceHandlingInViewControllerClass:[YKIssueQuestionVC class]];

    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSString *key = @"CFBundleShortVersionString";
    // 上一次使用的版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion])
    {
        
        YKRootTabBarVC *loginVC = [[YKRootTabBarVC alloc] init];
        self.window.rootViewController = loginVC;
        // 版本号相同：这次打开和上次打开的是同一个版本
//        YKLoginVC *loginVC = [[YKLoginVC alloc] init];
//        YKNavigationController *loginNC = [[YKNavigationController alloc] initWithRootViewController:loginVC];
//        self.window.rootViewController = loginNC;
        
    }else{
        
        // 这次和上次打开的不是同一个版本
        YKRegistVC *registerVC = [[YKRegistVC alloc] init];
        YKNavigationController *registerNC = [[YKNavigationController alloc] initWithRootViewController:registerVC];
        self.window.rootViewController = registerNC;
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

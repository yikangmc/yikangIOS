//
//  YKNavigationController.m
//  Baisibudejie
//
//  Created by 李洋 on 16/3/3.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKNavigationController.h"

@interface YKNavigationController ()

@end

@implementation YKNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    bar.titleTextAttributes = @{NSForegroundColorAttributeName: YK1f1f1f, NSFontAttributeName: [UIFont fontWithName:@"ArialMT" size:18]};
    
    [bar setTranslucent:NO];
    bar.barTintColor = [UIColor whiteColor];
    bar.tintColor = YK1f1f1f;
    
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
}






@end

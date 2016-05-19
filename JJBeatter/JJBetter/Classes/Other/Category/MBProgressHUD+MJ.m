//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

#define ColorRGB(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //提示文字
    hud.labelText = message;
    //提示文字的颜色
    hud.labelColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    //hud消失的动画效果
    hud.animationType = MBProgressHUDAnimationFade;
    //hub的模式（圆的、条形）
    hud.mode = MBProgressHUDModeIndeterminate;
    //hub的大背景色
    hud.backgroundColor = [UIColor clearColor];
    //小正方形背景的颜色
//    hud.color = ColorRGB(100, 100, 100);
//    hud.color = [UIColor blackColor];
    //转转圈的颜色
    hud.activityIndicatorColor = [UIColor whiteColor];
    
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/** 在页面下边出现提示信息 */
+ (void)showBottomMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 15.f;
    hud.yOffset = view.frame.size.height/2-40;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

/** 自定义动画的HUD */
+ (void)showCustomHUDMessage:(NSString *)message toView:(UIView *)view {
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 1; i <= 6; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"motion_index_zy%d",i];
        UIImage *imge = [UIImage imageNamed:imageStr];
        [refreshingImages addObject:imge];
    };
    
    UIImageView *animatedImageView = [[UIImageView alloc] init];
    animatedImageView.bounds = CGRectMake(0, 0, 50, 50);
    animatedImageView.animationImages = refreshingImages;
    animatedImageView.animationDuration = 2;
    animatedImageView.animationRepeatCount = 0;
    [animatedImageView startAnimating];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.customView = animatedImageView;
    hud.square = YES;
    hud.labelText = message;
}

@end

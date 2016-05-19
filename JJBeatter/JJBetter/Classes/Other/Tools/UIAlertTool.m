//
//  UIAlertTool.m
//  testDemo
//
//  Created by 李洋 on 16/1/20.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "UIAlertTool.h"

@implementation UIAlertTool


#pragma mark 提示弹框
+(void)AlertWithViewController:(UIViewController *)viewController withMessage:(NSString *)message
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [viewController presentViewController:alertVC animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    });
}




@end

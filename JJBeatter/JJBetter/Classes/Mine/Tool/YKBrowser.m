//
//  WSBrowser.h
//
//  Created by 马文帅 on 15/7/23.
//  Copyright (c) 2015年 yikang. All rights reserved.
//

#import "YKBrowser.h"

@implementation YKBrowser

+ (void)showImage:(UIImage *)image {
    UIWindow *window=[UIApplication sharedApplication].keyWindow;

    UIView *blackView = [[UIView alloc] init];
    blackView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0;
    blackView.tag = 2080;
    
    CGFloat whiteViewX = ScreenW*0.15;
    CGFloat whiteViewY = window.center.y-ScreenW*0.35;
    CGFloat whiteViewW = ScreenW*0.7;
    CGFloat whiteViewH = ScreenW*0.7+50;
    UIView *whiteView = [[UIView alloc] init];
    whiteView.frame = CGRectMake(whiteViewX, whiteViewY, whiteViewW, whiteViewH);
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.alpha = 0;
    whiteView.tag = 3080;
    
    CGFloat blackW = whiteViewW*0.9;
    CGFloat blackH = whiteViewW*0.9;
    UIImageView *qrImageView = [[UIImageView alloc] init];
    qrImageView.frame = CGRectMake(0, 0, blackW, blackH);
    qrImageView.center = CGPointMake(whiteViewW / 2, whiteViewH / 2 + 30);
    qrImageView.image = image;
    qrImageView.alpha = 0;
    qrImageView.tag = 4080;
    
    CGFloat textLabW = whiteViewW*0.8;
    CGFloat textLabH = 20;
    CGFloat textLabX = whiteViewW*0.1;
    UILabel *textLab = [[UILabel alloc] init];
    textLab.frame = CGRectMake(textLabX, whiteViewH / 2 + 30 - blackH / 2 - 40, textLabW, textLabH);
    textLab.text = @"出示您的二维码";
    textLab.textColor = [UIColor colorWithRed:100/ 255.0 green:100/ 255.0 blue:100/ 255.0 alpha:1.0];
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.font = [UIFont systemFontOfSize:16];
    textLab.alpha = 0;
    textLab.tag = 5080;
    
    
    UILabel *jiajia = [[UILabel alloc] init];
    jiajia.frame = CGRectMake(textLabX, whiteViewH / 2 + 30 - blackH / 2 -20, textLabW, textLabH);
    jiajia.text = @"邀请患者加入佳佳康复";
    jiajia.textColor = [UIColor colorWithRed:100/ 255.0 green:100/ 255.0 blue:100/ 255.0 alpha:1.0];
    jiajia.textAlignment = NSTextAlignmentCenter;
    jiajia.font = [UIFont systemFontOfSize:16];
    jiajia.alpha = 0;
    jiajia.tag = 6080;
    
    [window addSubview:blackView];
    [window addSubview:whiteView];
    [whiteView addSubview:qrImageView];
    [whiteView addSubview:textLab];
    [whiteView addSubview:jiajia];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [blackView addGestureRecognizer: tap];
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [whiteView addGestureRecognizer: tap2];
    
    [UIView animateWithDuration:0.3 animations:^{
        blackView.alpha = 0.7;
        whiteView.alpha = 1;
        qrImageView.alpha = 1;
        textLab.alpha = 1;
        jiajia.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void)hideImage:(UITapGestureRecognizer*)tap {
    UIWindow *window=[UIApplication sharedApplication].keyWindow;

    UIView *blackView = [window viewWithTag:2080];
    UIView *whiteView = [window viewWithTag:3080];
    UIImageView *qrImageView=(UIImageView*)[window viewWithTag:4080];
    UILabel *textLab = (UILabel *)[window viewWithTag:5080];
    UILabel *jiajia = (UILabel *)[window viewWithTag:6080];
    
    [UIView animateWithDuration:0.3 animations:^{
        blackView.alpha = 0;
        whiteView.alpha = 0;
        qrImageView.alpha = 0;
        textLab.alpha = 0;
        jiajia.alpha = 0;
    } completion:^(BOOL finished) {
        [blackView removeFromSuperview];
        [whiteView removeFromSuperview];
    }];
}

@end

//
//  YK_CarouselFigure.h
//  JJBetter
//
//  Created by yikang on 16/4/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YK_CarouselFigure : UIScrollView


@property (nonatomic,strong)UIImage *bitmapImage; //占位图
@property (nonatomic, strong)NSArray *imageArray; //image的数组

@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)NSArray *sd_URLArray; //如果有SDWebImage使用这个数组加载视图
@property (nonatomic, assign)CGFloat carouselTime; //轮播时间
- (void)addTouchImageActionBlock:(void (^)(NSInteger index))block; //点击的回调



@end

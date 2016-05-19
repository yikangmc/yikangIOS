//
//  LYSlideHeadView.m
//  JJBetter
//
//  Created by yikang on 16/4/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "LYSlideHeadView.h"


static CGFloat const titleH = 30;/** 文字高度  */

static CGFloat const MaxScale = 1.1;/** 选中文字放大  */


@implementation LYSlideHeadView

- (NSMutableArray *)buttons
{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(void)setSlideHeadView
{
    [self setTitleScrollView];        /** 添加文字标签  */
    
    [self setContentScrollView];      /** 添加scrollView  */
    
    [self setupTitle];                /** 设置标签按钮 文字 背景图  */
    
    
    self.contentScrollView.contentSize = CGSizeMake(self.titlesArr.count * ScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator  = NO;
    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces = NO;
    
}
- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target = sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}


#pragma mark - PRIVATE
-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle
{
    UIViewController *superVC = [self findViewController:self];
    childVC.title = vcTitle;
    [superVC addChildViewController:childVC];
    
}
-(void)setTitleScrollView
{
    UIViewController *superVC = [self findViewController:self];
//    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
//    self.titleScrollView.center = CGPointMake(ScreenW / 2, 32 + 15);
    [superVC.view addSubview:self.titleScrollView];
    
    
}
-(void)setContentScrollView
{
    UIViewController *superVC = [self findViewController:self];
    
    CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect  = CGRectMake(0, y - 5, ScreenW, ScreenH - y);
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [superVC.view addSubview:self.contentScrollView];
    
    
}

-(void)setupTitle
{
    UIViewController *superVC = [self findViewController:self];
    
    NSUInteger count = superVC.childViewControllers.count;
    CGFloat x = 0;
    CGFloat w = 70;
    CGFloat h = titleH;
//    self.imageBackView  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 30, 60, 3)];
//    self.imageBackView.backgroundColor = YK23149252Color;
    self.imageBackView.userInteractionEnabled = YES;
    [self.titleScrollView addSubview:self.imageBackView];
    
    for (int i = 0; i < count; i++)
    {
        UIViewController *vc = superVC.childViewControllers[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 0, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:YK656565 forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        [self.titleScrollView addSubview:btn];
        
        if (i == 0)
        {
            [self click:btn];
        }
    }
    
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
}
-(void)click:(UIButton *)sender
{
    
    [self selectTitleBtn:sender];
    NSInteger i = sender.tag;
    CGFloat x  = i * ScreenW;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
    [self setUpOneChildController:i];
    
}

-(void)selectTitleBtn:(UIButton *)btn
{
    
    [self.selectedBtn setTitleColor:YK505050 forState:UIControlStateNormal];
    self.selectedBtn.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:YK0faadd forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(MaxScale, MaxScale);
    self.selectedBtn = btn;
    
    [self setupTitleCenter:btn];
    
}

-(void)setupTitleCenter:(UIButton *)sender
{
    
    CGFloat offset = sender.center.x - ScreenW * 0.5;
    if (offset < 0) {
        offset = 0;
    }
    
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - ScreenW;
    if (offset > maxOffset && maxOffset>0) {
        offset = maxOffset;
    }
    
//    NSLog(@"%lf,%lf,%ld",offset,maxOffset,sender.tag);
//    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}

-(void)setUpOneChildController:(NSInteger)index
{
    UIViewController *superVC = [self findViewController:self];
    
    CGFloat x  = index * ScreenW;
    UIViewController *vc  =  superVC.childViewControllers[index];
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, ScreenW, ScreenH - self.contentScrollView.frame.origin.y);
    [self.contentScrollView addSubview:vc.view];
    
}


#pragma mark - UIScrollView  delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger i  = self.contentScrollView.contentOffset.x / ScreenW;
    [self selectTitleBtn:self.buttons[i]];
    [self setUpOneChildController:i];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX  = scrollView.contentOffset.x;
    NSInteger leftIndex  = offsetX / ScreenW;
    NSInteger rightIdex  = leftIndex + 1;
    
    UIButton *rightButton  = nil;
    if (rightIdex < self.buttons.count) {
        rightButton  = self.buttons[rightIdex];
    }
    
    self.imageBackView.transform  = CGAffineTransformMakeTranslation((offsetX*(self.titleScrollView.contentSize.width / self.contentScrollView.contentSize.width)), 0);

}







@end

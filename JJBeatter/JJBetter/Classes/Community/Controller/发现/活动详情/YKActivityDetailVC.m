//
//  YKActivityDetailVC.m
//  JJBetter
//
//  Created by yikang on 16/5/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKActivityDetailVC.h"
#import "YKActivityDetailView.h"
#import "YKSegment.h"

#import "YKSubActivityDetailVC.h"
#import "YKChatInteractionVC.h"


@interface YKActivityDetailVC ()<UIScrollViewDelegate,SegmentDelegate>

@property (nonatomic,strong)YKActivityDetailView *ykActivityView;
@property (nonatomic,strong)YKSubActivityDetailVC *VC1;
@property (nonatomic,strong)YKChatInteractionVC *VC2;

@property (nonatomic,strong)YKSegment *segment;
@property (nonatomic,strong)UIScrollView *contentScrollView;


@end

@implementation YKActivityDetailVC


#pragma mark  ----  loadView  -----
-(void)loadView
{
    self.ykActivityView = [[YKActivityDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykActivityView;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // 加载活动图片
    [self.ykActivityView.activityImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"活动详情活动图"]];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(ActivityDetailBackToUp:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"三点分享"] style:UIBarButtonItemStylePlain target:self action:@selector(ActivityDetailShare:)];
    
    
    // 添加ViewController
    [self addChildViewController];
    // 布局ScrollView
    [self setContentScrollView];
    // 布局Segment
    [self setSegment];
    
    
    // 布局分享弹框与添加事件
    [self addShareClickedAction];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, 0, 0);
    
    // 隐藏导航栏
    UIImage *image = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    self.navigationController.navigationBar.translucent = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
    
    // 显示导航栏
    UIImage *image = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    self.navigationController.navigationBar.translucent = NO;
    
}



#pragma mark  ----  返回  -----
-(void)ActivityDetailBackToUp:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark  ----  分享  ------
-(void)ActivityDetailShare:(UIBarButtonItem *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.ykActivityView.grayBackView.hidden = NO;
        self.ykActivityView.shareBackView.y = CGRectGetMaxY(self.view.frame) - 234 * WScale;
    }];
}



#pragma mark  ----  设置segment  -----
-(void)setSegment
{
    // 初始化
    self.segment = [[YKSegment alloc] initWithFrame:CGRectMake(0, 205 * WScale, ScreenW, 40 * WScale)];
    self.segment.delegate = self;
    self.segment.backgroundColor = YKf0f0f0;
    [self.ykActivityView addSubview:self.segment];
    
}

// 布局ScrollView
-(void)setContentScrollView
{
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 245 * WScale - 64, ScreenW, ScreenH - 245 * WScale + 64 )];
    self.contentScrollView.contentSize = CGSizeMake(2 * ScreenW, 0);
    self.contentScrollView.bounces = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.scrollEnabled = YES;
    self.contentScrollView.userInteractionEnabled = YES;
    self.contentScrollView.delegate = self;
    
    for (int i=0; i < self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * ScreenW, 0, ScreenW, self.contentScrollView.height);
        [self.contentScrollView addSubview:vc.view];
        
    }
    [self.ykActivityView addSubview:self.contentScrollView];

}

//添加2个ViewController
-(void)addChildViewController
{
    
    self.VC1 = [[YKSubActivityDetailVC alloc]init];
    [self addChildViewController:self.VC1];
    self.VC2 = [[YKChatInteractionVC alloc]init];
    [self addChildViewController:self.VC2];
    
}

#pragma mark  ----  UIScrollViewDelegate  -----
//实现LGSegment代理方法
-(void)scrollToPage:(int)Page {
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = ScreenW * Page;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = offset;
    }];
}

// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    [self.segment moveToOffsetX:offsetX];
    
}


#pragma mark  ----  布局分享弹框与添加事件   ----
-(void)addShareClickedAction
{
    // 布局弹框
    [self.ykActivityView creatShareAlertView];
    // 添加点击事件
    [self.ykActivityView.weiboBtn addTarget:self action:@selector(activityDetailWeiboBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykActivityView.weixinBtn addTarget:self action:@selector(activityDetailWeixinBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykActivityView.weixinCircleBtn addTarget:self action:@selector(activityDetailWeixinCircleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykActivityView.reportBtn addTarget:self action:@selector(activityDetailReportBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykActivityView.cancleBtn addTarget:self action:@selector(activityDetailCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark  ----  分享到各社交平台  -----
-(void)activityDetailWeiboBtn:(UIButton *)sender
{
    NSLog(@"微博");
}
-(void)activityDetailWeixinBtn:(UIButton *)sender
{
    NSLog(@"微信");
}
-(void)activityDetailWeixinCircleBtn:(UIButton *)sender
{
    NSLog(@"微信朋友圈");
}


#pragma mark  ----  举报与取消  -----
-(void)activityDetailReportBtn:(UIButton *)sender
{
    NSLog(@"举报");
}

-(void)activityDetailCancleBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.ykActivityView.grayBackView.hidden = YES;
        self.ykActivityView.shareBackView.y = CGRectGetMaxY(self.view.frame);
    }];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}







@end

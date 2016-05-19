//
//  YKCommunityVC.m
//  JJBetter
//
//  Created by yikang on 16/4/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKCommunityVC.h"
#import "LYSlideHeadView.h"

#import "YKFindVC.h"
#import "YKFocusVC.h"


@interface YKCommunityVC ()

@end

@implementation YKCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 完成以下步骤即可
    // 初始化SlideHeadView，并加进view
    LYSlideHeadView *slideVC = [[LYSlideHeadView alloc]init];
    
    slideVC.titleScrollView.scrollEnabled = NO;
    slideVC.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    slideVC.titleScrollView.center = CGPointMake(ScreenW / 2, 32 + 15);
    slideVC.imageBackView  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 37, 60, 1.5)];
    slideVC.imageBackView.backgroundColor = YK1795fc;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view addSubview:slideVC];
    
    // 初始化子控制器
    YKFindVC *VC1 = [[YKFindVC alloc]init];
    YKFocusVC *VC2 = [[YKFocusVC alloc] init];
    
    NSArray *titleArr = @[@"发现",@"关注"];
    slideVC.titlesArr = titleArr;
    
    [slideVC addChildViewController:VC1 title:titleArr[0]];
    [slideVC addChildViewController:VC2 title:titleArr[1]];
    
    // 完成
    [slideVC setSlideHeadView];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

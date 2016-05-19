//
//  YKFocusVC.m
//  JJBetter
//
//  Created by yikang on 16/4/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKFocusVC.h"
#import "LYSlideHeadView.h"

#import "YKProfessionPeopleVC.h"
#import "YKLabelVC.h"
#import "YKCollectionVC.h"

@interface YKFocusVC ()

@end

@implementation YKFocusVC

- (void)viewDidLoad {
    [super viewDidLoad];

    LYSlideHeadView *slideVC = [[LYSlideHeadView alloc] init];
    
    slideVC.titleScrollView.scrollEnabled = NO;
    slideVC.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 210, 40 * WScale)];
    slideVC.titleScrollView.center = CGPointMake(self.view.frame.size.width / 2, 23 * WScale);
    
    [self.view addSubview:slideVC];
    
    YKProfessionPeopleVC *vc1 = [[YKProfessionPeopleVC alloc] init];
    YKLabelVC *vc2 = [[YKLabelVC alloc] init];
    YKCollectionVC *vc3 = [[YKCollectionVC alloc] init];
    
    NSArray *arr = @[@"专业人员",@"标签",@"收藏"];
    slideVC.titlesArr = arr;
    
    [slideVC addChildViewController:vc1 title:arr[0]];
    [slideVC addChildViewController:vc2 title:arr[1]];
    [slideVC addChildViewController:vc3 title:arr[2]];

    [slideVC setSlideHeadView];
    
    for (UIButton *btn in slideVC.buttons) {
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
    
    
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

//
//  YKMyActivityVC.m
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyActivityVC.h"  // 当前界面
#import "YKMyActivityCell.h"
#import "YKFocusAddLabelCell.h"

#import "YKNavigationController.h"  // 其他界面
#import "YKActivityDetailVC.h"


@interface YKMyActivityVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKMyActivityVC


#pragma mark  ----  loadView  ----
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"我的活动";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(MyActivityBackToUp:)];
    
    // 初始化tableView
    [self initTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, 0, 0);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
    
}


#pragma mark  ----  返回  -----
-(void)MyActivityBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = YKGlobalBg;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKMyActivityCell class] forCellReuseIdentifier:@"YKMyActivityCell"];
    [self.tableView registerClass:[YKFocusAddLabelCell class] forCellReuseIdentifier:@"YKFocusAddLabelCell"];

    
}


#pragma mark  -----  tableView代理方法  ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 40 * WScale;
    }
    return 190 * WScale;
}
// Header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10 * WScale;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
}
// Footer
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 100 * WScale;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        YKFocusAddLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKFocusAddLabelCell"];
        
        cell.addMoreLabel.text = @"参与更多活动";
        
        
        return cell;
        
    }else {
        
        YKMyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMyActivityCell"];
        
        
        [cell.activityImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"发现界面banner（康复+护理）2"]];
        cell.timeLabel.text = @"2016-05-11  12:30 ~ 2016-05-11  12:30";
        cell.titleLabel.text = @"糖尿病健康普及大讲堂";
        cell.nameLabel.text = @"践行者工作室";
        cell.typeImageView.image = [UIImage imageNamed:@"企-"];
        
        
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1) {
        
        // 点击更多回到社区界面
        [self.navigationController popToRootViewControllerAnimated:NO];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"MyActivityVCBackToCommunityVC"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else {
        
        YKActivityDetailVC *VC = [[YKActivityDetailVC alloc] init];
        YKNavigationController *NC = [[YKNavigationController alloc] initWithRootViewController:VC];
    
        CATransition* transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        [NC.view.layer addAnimation:transition forKey:@"SwitchToView"];
        
        [self presentViewController:NC animated:NO completion:nil];
    }
    
    
    
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}







@end

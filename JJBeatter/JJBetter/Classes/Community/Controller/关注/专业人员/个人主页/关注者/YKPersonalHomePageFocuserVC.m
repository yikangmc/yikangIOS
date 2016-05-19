//
//  YKPersonalHomePageFocuserVC.m
//  JJBetter
//
//  Created by yikang on 16/5/16.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPersonalHomePageFocuserVC.h"  // 当前界面
#import "YKPersonalHomePageFocuserCell.h"
#import "YKPersonalHomePageVC.h"

@interface YKPersonalHomePageFocuserVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKPersonalHomePageFocuserVC


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"关注者";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(PersonalHomePageFocuserBackToUp:)];
    
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
-(void)PersonalHomePageFocuserBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    
    // 注册cell
    [self.tableView registerClass:[YKPersonalHomePageFocuserCell class] forCellReuseIdentifier:@"YKPersonalHomePageFocuserCell"];
    
    
}


#pragma mark  ----  tableView代理方法  -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70 * WScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKPersonalHomePageFocuserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPersonalHomePageFocuserCell"];
    
    
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
    cell.nameLabel.text = @"康复师周琳";
    cell.typeImageView.image = [UIImage imageNamed:@"康-"];
    [cell.focusBtn setBackgroundImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
    
    // 自适应nameLabel宽度
    CGFloat nameW = [YKPersonalHomePageFocuserCell widthForNameLabel:cell.nameLabel.text];
    [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(nameW + 2);
    }];
    
    
    // 添加点击方法
    [cell.focusBtn addTarget:self action:@selector(focusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[YKPersonalHomePageVC class]]) {

            VC.title = @"另一个人啦";
            CATransition* transition = [CATransition animation];
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
            transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController popToViewController:VC animated:NO];
        }
    }
    
    
    
}



#pragma mark  ----  关注  -----
-(void)focusBtnAction:(UIButton *)sender
{
    if (sender.selected) {
        [sender setBackgroundImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
    }else {
        [sender setBackgroundImage:[UIImage imageNamed:@"已关注"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

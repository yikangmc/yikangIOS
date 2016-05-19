//
//  YKPersonalHomePageLabelVC.m
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPersonalHomePageLabelVC.h"  // 当前界面
#import "YKPersonalHomePageLabelCell.h"

#import "YKLabelContentVC.h"  // 其他界面


@interface YKPersonalHomePageLabelVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKPersonalHomePageLabelVC


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];

   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(PersonalHomePageLabelBackToUp:)];
    
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
-(void)PersonalHomePageLabelBackToUp:(UIBarButtonItem *)sender
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
    [self.tableView registerClass:[YKPersonalHomePageLabelCell class] forCellReuseIdentifier:@"YKPersonalHomePageLabelCell"];
    
    
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
    return 73 * WScale;
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
    YKPersonalHomePageLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPersonalHomePageLabelCell"];
    
    
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"热门标签背景图"]];
    cell.titleLabel.text = @"瘦身";
    [cell.focusBtn setBackgroundImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
    
    
    // 添加点击方法
    [cell.focusBtn addTarget:self action:@selector(focusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YKLabelContentVC *VC = [[YKLabelContentVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
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

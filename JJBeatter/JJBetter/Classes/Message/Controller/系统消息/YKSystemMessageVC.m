//
//  YKSystemMessageVC.m
//  JJBetter
//
//  Created by yikang on 16/5/11.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKSystemMessageVC.h"  // 当前界面
#import "YKSystemMessageCell.h"


@interface YKSystemMessageVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKSystemMessageVC


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"系统消息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(SystemMessageBackToUp:)];
    
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
-(void)SystemMessageBackToUp:(UIBarButtonItem *)sender
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
    
    // 注册cell
    [self.tableView registerClass:[YKSystemMessageCell class] forCellReuseIdentifier:@"YKSystemMessageCell"];
    
}


#pragma mark  -----  tableView代理方法  ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68 * WScale;
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
    YKSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKSystemMessageCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    [cell.systemImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"热门标签背景图"]];
    cell.titleLabel.text = @"佳佳产品团队";
    cell.messageLabel.text = @"佳佳康复最新V.20版本出炉，快来体验吧~";
    cell.timeLabel.text = @"5分钟之前";
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

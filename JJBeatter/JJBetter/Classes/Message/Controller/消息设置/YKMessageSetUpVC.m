//
//  YKMessageSetUpVC.m
//  JJBetter
//
//  Created by yikang on 16/5/11.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMessageSetUpVC.h"
#import "YKMessageSetUpCell.h"

@interface YKMessageSetUpVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKMessageSetUpVC


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"消息设置";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(MessageSetUpBackToUp:)];
    
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
-(void)MessageSetUpBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = YKGlobalBg;
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerClass:[YKMessageSetUpCell class] forCellReuseIdentifier:@"YKMessageSetUpCell"];
    
}



#pragma mark  -----  tableView代理方法  ------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49.5 ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10 ;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKMessageSetUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMessageSetUpCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSArray *array = @[@"评论",@"支持",@"回答",@"系统消息"];
    cell.customLabel.text = array[indexPath.row];
    
    
    NSArray *switchArr = @[@(1),@(0),@(1),@(0)];
    cell.customSwitch.on = [switchArr[indexPath.row] boolValue];
    
    
    
    return cell;
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

//
//  YKMyQuestionVC.m
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyQuestionVC.h"  // 当前界面
#import "YKMyQuestionCell.h"

#import "YKAnswerDetailVC.h"  // 其他界面


@interface YKMyQuestionVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;


@end

@implementation YKMyQuestionVC


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的问题";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(MyQuestionBackToUp:)];
    
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
-(void)MyQuestionBackToUp:(UIBarButtonItem *)sender
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKMyQuestionCell class] forCellReuseIdentifier:@"YKMyQuestionCell"];
    
    
}


#pragma mark  -----  tableView代理方法  ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68 * WScale;
}
// Header
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

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKMyQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMyQuestionCell"];
    
    
    cell.titleLabel.text = @"我的韧带撕裂，如何康复？";
    cell.labelLabel.text = @"软组织损伤";
    cell.timeLabel.text = @"2016-04-05";
    cell.commentLabel.text = @"99999";
    
    // 自适应labelLabel宽度
    CGFloat labelW = [YKMyQuestionCell widthForLabelLabel:cell.labelLabel.text];
    [cell.labelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(labelW);
    }];

    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YKAnswerDetailVC *VC = [[YKAnswerDetailVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end

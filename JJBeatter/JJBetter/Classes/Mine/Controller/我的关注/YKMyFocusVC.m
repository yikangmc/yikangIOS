//
//  YKMyFocusVC.m
//  JJBetter
//
//  Created by yikang on 16/5/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyFocusVC.h"  // 当前界面
#import "YKMyFocusCell.h"

#import "YKProfessionDetailVC.h"  // 其他界面


@interface YKMyFocusVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKMyFocusVC


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(MyFocusBackToUp:)];
    
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
-(void)MyFocusBackToUp:(UIBarButtonItem *)sender
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
    [self.tableView registerClass:[YKMyFocusCell class] forCellReuseIdentifier:@"YKMyFocusCell"];
    
    
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
    YKMyFocusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMyFocusCell"];
    
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"热门标签背景图"]];
    cell.titleLabel.text = @"如何让女士健康的康复运动?";
    cell.nameLabel.text = @"软组织损伤";
    cell.typeImageView.image = [UIImage imageNamed:@"康-"];
    
    // 自适应labelLabel宽度
    CGFloat labelW = [YKMyFocusCell widthForNameLabel:cell.nameLabel.text];
    [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(labelW + 2);
    }];
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    

    // 专业内容详情
    YKProfessionDetailVC *VC = [[YKProfessionDetailVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

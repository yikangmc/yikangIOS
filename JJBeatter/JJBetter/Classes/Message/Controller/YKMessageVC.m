//
//  YKMessageVC.m
//  JJBetter
//
//  Created by yikang on 16/5/10.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMessageVC.h"  // 当前界面
#import "YKMessageCell.h"

#import "YKMessageSetUpVC.h"  // 其他界面
#import "YKDynamicNotificationVC.h"
#import "YKSystemMessageVC.h"

@interface YKMessageVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKMessageVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tableView
    [self initTableView];
    
    // 我来回答button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"消息设置" forState:UIControlStateNormal];
    [btn setTitleColor:YK0faadd forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    btn.frame = CGRectMake(0, 0, 60 * WScale, 15 * HScale);
    [btn addTarget:self action:@selector(messageSetUp:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
}


#pragma mark  ----  消息设置  -----
-(void)messageSetUp:(UIButton *)sender
{
    YKMessageSetUpVC *VC = [[YKMessageSetUpVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
    [self.tableView registerClass:[YKMessageCell class] forCellReuseIdentifier:@"YKMessageCell"];
    
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10 * WScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMessageCell"];
    
    NSArray *array = @[@"动态通知",@"系统消息"];
    NSArray *boolArr = @[@(0),@(1)];
    
    
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",array[indexPath.section]]];
    cell.customLabel.text = array[indexPath.section];
    cell.boolImageView.hidden = [boolArr[indexPath.section] boolValue];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
        YKDynamicNotificationVC *VC = [[YKDynamicNotificationVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else {
        
        YKSystemMessageVC *VC = [[YKSystemMessageVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

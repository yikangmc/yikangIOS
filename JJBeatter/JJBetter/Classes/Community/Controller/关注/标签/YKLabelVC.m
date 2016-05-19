//
//  YKLabelVC.m
//  JJBetter
//
//  Created by yikang on 16/4/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKLabelVC.h"  // 当前界面
#import "YKFocusLabelCell.h"
#import "YKFocusAddLabelCell.h"

#import "YKLabelContentVC.h"  // 其他界面


@interface YKLabelVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;


@end

@implementation YKLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 初始化tableView
    [self initTableView];
    
    
}


/**  初始化tableView */
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH -  64 - 39 * WScale - 49) style:UITableViewStylePlain];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerClass:[YKFocusLabelCell class] forCellReuseIdentifier:@"YKFocusLabelCell"];
    [self.tableView registerClass:[YKFocusAddLabelCell class] forCellReuseIdentifier:@"YKFocusAddLabelCell"];
    
}


#pragma mark  -----  tableViewDelegate  ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return  10 * WScale;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 75 * WScale;
    }
    return 41 * WScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        YKFocusLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKFocusLabelCell"];
        
        
        cell.pictureImageView.image = [UIImage imageNamed:@"热门标签背景图"];
        cell.titleLabel.text = @"小儿脑瘫";
        cell.countLabel.text = @"199";
        
        if ([cell.countLabel.text integerValue] > 99) {
            cell.countLabel.text = @"99+";
        }
        
        
        
        return cell;
        
        
    }else {
        
        YKFocusAddLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKFocusAddLabelCell"];
        
        
        return cell;
    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1) {
        
        // 添加关注标签
        
    }else {
        
        // 标签帖子
        YKLabelContentVC *VC = [[YKLabelContentVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

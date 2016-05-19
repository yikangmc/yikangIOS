//
//  YKCollectionVC.m
//  JJBetter
//
//  Created by yikang on 16/4/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKCollectionVC.h"  // 当前界面
#import "YKFocusCollectionCell.h"

#import "YKProfessionDetailVC.h"  // 其他界面


@interface YKCollectionVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;


@end

@implementation YKCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化tableView
    [self initTableView];
    
    
}


/**  初始化tableView */
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH -  64 - 38 * WScale - 49) style:UITableViewStylePlain];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerClass:[YKFocusCollectionCell class] forCellReuseIdentifier:@"YKFocusCollectionCell"];
    
}


#pragma mark  -----  tableViewDelegate  ------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120 * WScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKFocusCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKFocusCollectionCell"];
    
    
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
    cell.nameLabel.text = @"康复师周琳";
    cell.typeImageView.image = [UIImage imageNamed:@"康-"];
    cell.timeLabel.text = @"2016-04-31";
    [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"热门标签背景图"]];
    cell.titleLabel.text = @"如何让女士健康的运动减肥？";
    
    
    
    // 自适应nameLabel宽度
    CGFloat nameW = [YKFocusCollectionCell widthForNameLabel:cell.nameLabel.text];
    [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(nameW + 2);
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

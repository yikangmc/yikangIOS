//
//  YKProfessionPeopleVC.m
//  JJBetter
//
//  Created by yikang on 16/5/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKProfessionPeopleVC.h"  // 当前界面
#import "YKFocusProfessionPeopleCell.h"

#import "YKNavigationController.h"  // 其他界面
#import "YKPersonalHomePageVC.h"


@interface YKProfessionPeopleVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;



@end

@implementation YKProfessionPeopleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tableView
    [self initTableView];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
//    [self.tableView reloadData];
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
    [self.tableView registerClass:[YKFocusProfessionPeopleCell class] forCellReuseIdentifier:@"YKFocusProfessionPeopleCell"];
    
}


#pragma mark  -----  tableViewDelegate  ------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75 * WScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKFocusProfessionPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKFocusProfessionPeopleCell"];

    
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
    cell.nameLabel.text = @"康复师周琳";
    cell.typeImageView.image = [UIImage imageNamed:@"康-"];
    cell.focusLabel.text = @"1234人在关注";
    // 创建标签
    NSArray *arr = @[@"运动运动",@"运动康复动",@"运动康复运动",@"运动康复运运动动"];
    [cell creatLabelWithArray:arr];
    
    
    // 自适应nameLabel宽度
    CGFloat nameW = [YKFocusProfessionPeopleCell widthForNameLabel:cell.nameLabel.text];
    [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(nameW + 2);
    }];
    // 将关注数设置为蓝色
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cell.focusLabel.text];
    [str addAttribute:NSForegroundColorAttributeName value:YK0faadd range:NSMakeRange(0 , cell.focusLabel.text.length - 4)];
    cell.focusLabel.attributedText = str;
    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YKPersonalHomePageVC *VC = [[YKPersonalHomePageVC alloc] init];
    VC.title = @"这里是名字";
    [self.navigationController pushViewController:VC animated:YES];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

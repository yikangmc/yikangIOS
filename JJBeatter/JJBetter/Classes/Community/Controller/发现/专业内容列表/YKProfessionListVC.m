//
//  YKProfessionListVC.m
//  JJBetter
//
//  Created by yikang on 16/5/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKProfessionListVC.h"  // 当前界面
#import "YKSealLabelCollectionView.h"
#import "YKProfessionListCell.h"

#import "YKEditLabelVC.h"  // 其他界面
#import "YKProfessionDetailVC.h"


@interface YKProfessionListVC ()<YKLableTitleClickedDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIButton *editBtn;  // 编辑button

@end

@implementation YKProfessionListVC


#pragma mark  ----  loadView  ----
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"专业内容";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(ProfessionListBackToUp:)];
    
    // 初始化最上方collectionView
    [self initCollectionView];
    
    
    // 初始化tableView
    [self initTableView];
    
    
    // 初始化编辑按钮
    [self initEditBtn];
    
    
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
-(void)ProfessionListBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  ---  初始化collectionView  ----
-(void)initCollectionView
{
    
    YKSealLabelCollectionView *titleBar = [[YKSealLabelCollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 48 * WScale, 37 * WScale)];
    self.titles = @[@"我的商城", @"我的优惠券", @"团购券", @"积分商城", @"微信", @"微博", @"墨迹天气",@"墨迹天气"];
    titleBar.titles = self.titles;
    titleBar.delegate = self;
    [self.view addSubview:titleBar];
    
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"专业内容列表添加"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-15 * WScale);
        make.centerY.mas_equalTo(titleBar.mas_centerY);
        make.height.mas_equalTo(18 * WScale);
        make.width.mas_equalTo(moreBtn.mas_height);
    }];
   
    
}


#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(36 * WScale);
        make.width.mas_equalTo(self.view.mas_width);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKProfessionListCell class] forCellReuseIdentifier:@"YKProfessionListCell"];
    
    
}


#pragma mark  -----  点击标签的回调事件  ----
-(void)YKTitleLabelView:(YKSealLabelCollectionView *)titleLabelView didSelectedItem:(int)index
{
    NSLog(@"%d", index);
}


#pragma mark  ----  更多添加标签  ------
-(void)moreAddAction:(UIButton *)sender
{
    YKEditLabelVC *VC = [[YKEditLabelVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}


#pragma mark  ----  tableView代理方法  -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170 * WScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKProfessionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKProfessionListCell"];
    
    
    
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"热门标签背景图"]];
    NSString *title = @"如何让女生正确的运动就散了时间到了的运动就散了时间到了";
    if (title.length > 20) {
        NSString *str = [title substringToIndex:20];
        cell.titleLabel.text = [str stringByAppendingString:@"..."];
    }
    cell.nameLabel.text = @"践行者工作室";
    cell.typeImageView.image = [UIImage imageNamed:@"康-"];
    NSString *content = @"这是一篇推荐的帖子，这是可以作为运营入口的地方，进行加近推荐近距离睡觉啦待交付的到家啦手段就是这是一篇推荐的帖子";
    if (content.length > 54) {
        NSString *str = [content substringToIndex:54];
        cell.contentLabel.text = [str stringByAppendingString:@"..."];
    }
    
    // 自适应nameLabel宽度
    CGFloat nameW = [YKProfessionListCell widthForNameLabel:cell.nameLabel.text];
    [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(nameW + 2);
    }];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YKProfessionDetailVC *VC = [[YKProfessionDetailVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}



#pragma mark  ----  初始化编辑按钮  -----
-(void)initEditBtn
{
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"编辑正常"] forState:UIControlStateNormal];
    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"编辑-点击"] forState:UIControlStateHighlighted];
    [self.editBtn addTarget:self action:@selector(professionEditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20 * WScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(51 * WScale);
        make.width.mas_equalTo(self.editBtn.mas_height);
    }];
    
}

#pragma mark  ----  编辑  ----
-(void)professionEditBtnAction:(UIButton *)sender
{
    
    NSLog(@"编辑");
    
}

#pragma mark  ----  滑动tableView  ------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.editBtn.alpha = 0;
    }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.editBtn.alpha = 1;
    }];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

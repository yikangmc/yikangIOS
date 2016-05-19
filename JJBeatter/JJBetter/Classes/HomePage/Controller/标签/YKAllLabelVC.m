//
//  YKAllLabelVC.m
//  JJBetter
//
//  Created by yikang on 16/4/20.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKAllLabelVC.h"  // 当前界面
#import "YKSealLabelCollectionView.h"
#import "YKAllLabelListCell.h"

#import "YKLabelContentVC.h"  // 其他界面


@interface YKAllLabelVC ()<UITableViewDataSource,UITableViewDelegate,YKLableTitleClickedDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) YKSealLabelCollectionView *titleBar; // 标签view


@end

static NSString *const cellIdentifier = @"cells";

@implementation YKAllLabelVC


#pragma mark  ----  loadView  ------
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"标签";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(AllLabelBackToUp:)];
    
    
    // 初始化最上方collectionView
    [self initCollectionView];
    
    
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
-(void)AllLabelBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ---  初始化collectionView  ----
-(void)initCollectionView
{
    
    YKSealLabelCollectionView *titleBar = [[YKSealLabelCollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 37 * WScale)];
    self.titles = @[@"我的商城", @"我的优惠券", @"团购券", @"积分商城", @"微信", @"微博", @"墨迹天气",@"墨迹天气"];
    titleBar.titles = self.titles;
    titleBar.delegate = self;
    [self.view addSubview:titleBar];

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
        make.top.mas_equalTo(self.view.mas_top).offset(36 * WScale);
        make.width.mas_equalTo(self.view.mas_width);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKAllLabelListCell class] forCellReuseIdentifier:@"YKAllLabelListCell"];
    
}



#pragma mark  -----  点击标签的回调事件  ----
-(void)YKTitleLabelView:(YKSealLabelCollectionView *)titleLabelView didSelectedItem:(int)index
{
    NSLog(@"%d", index);
}




#pragma mark  -----  tableView代理方法  ------
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
    YKAllLabelListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAllLabelListCell"];
    
    
    cell.photoImageView.image = [UIImage imageNamed:@"热门标签背景图"];
    cell.titleLabel.text = [NSString stringWithFormat:@"体态矫正"];
    cell.postsLabel.text = [NSString stringWithFormat:@"124条帖子"];
    cell.updateLabel.text = [NSString stringWithFormat:@"更新时间： 1小时前"];
    cell.focusLabel.text = [NSString stringWithFormat:@"1234人关注"];
    
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    YKLabelContentVC *VC = [[YKLabelContentVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

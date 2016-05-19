//
//  YKFindVC.m
//  JJBetter
//
//  Created by yikang on 16/4/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKFindVC.h"
#import "YKFindView.h"

#import "YK_CarouselFigure.h"  // 当前界面
#import "YKFourModuleCell.h"
#import "YKRecommendCell.h"
#import "YKRecommendItem.h"
#import "YKActivityModelCell.h"

#import "YKProfessionListVC.h"  // 其他界面
#import "YKAnswersListVC.h"
#import "YKPersonalHomePageVC.h"
#import "YKNavigationController.h"
#import "YKActivityDetailVC.h"

// 发布活动
#import "YKActivitySelectVC.h"


@interface YKFindVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)YKFindView *ykFindView;  // 根视图

@property (nonatomic,strong)YK_CarouselFigure *ykCF;  // 轮播图

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UITableViewCell *recommendCell; // 推荐康复师cell
@property (nonatomic,strong)UICollectionView *collectionView; // 放在康复师cell上的collectionView

//@property (nonatomic,strong)UIButton *editBtn;  // 编辑button

@end

@implementation YKFindVC



#pragma mark  -----  loadView  ------
-(void)loadView
{
    self.ykFindView = [[YKFindView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykFindView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self initTableView];
    
#warning -----------------------------
    // 初始化编辑按钮
//    [self initEditBtn];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.ykCF.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.ykCF.carouselTime]];
}


#pragma mark  -------  初始化tableView ---
-(void)initTableView
{
    NSString *string = @"http://img2.a0bi.com/upload/ttq/20140722/1405995619576_middle.jpg";
    NSString *string1 = @"http://ww2.sinaimg.cn/mw600/c6c1d258jw1e5r59ttpkcj20gu0gsmyh.jpg";
    
    //有SD使用方法
    //创建只能用此方法
    self.ykCF = [[YK_CarouselFigure alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 140 * WScale)];    //添加点击时方法
    [self.ykCF addTouchImageActionBlock:^(NSInteger index) {
        NSLog(@"cf == %ld",index);
    }];
    //设置轮播时间
    self.ykCF.carouselTime = 1;
    //设置占位图
//    self.ykCF.bitmapImage = [UIImage imageNamed:@"qidongtu"];
    //给URLstring数组
    self.ykCF.sd_URLArray = @[string,string1];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.ykCF;
    [self.ykFindView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ykFindView.mas_top);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width);
        make.bottom.mas_equalTo(self.ykFindView.mas_bottom).offset(-49);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKFourModuleCell class] forCellReuseIdentifier:@"YKFourModuleCell"];
    [self.tableView registerClass:[YKRecommendCell class] forCellReuseIdentifier:@"YKRecommendCell"];
    [self.tableView registerClass:[YKActivityModelCell class] forCellReuseIdentifier:@"cell_activityModel"];
    
}



#pragma mark  -------  tableViewDelegate -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1;
    }
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90 * WScale;
    }else if (indexPath.section == 1) {
        return 156 * WScale;
    }
    return 215 * WScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        YKFourModuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKFourModuleCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 添加手势
        UITapGestureRecognizer *tapGROne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGROne:)];
        UITapGestureRecognizer *tapGRTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRTwo:)];
        
        [cell.YKOneImageView addGestureRecognizer:tapGROne];
        [cell.YKTwoImageView addGestureRecognizer:tapGRTwo];
        
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        YKRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKRecommendCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        self.recommendCell = cell;
        
        [self layoutRecommendItem];
        
        
        return cell;
        
    }else {
        
        
        YKActivityModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_activityModel"];

        
        [cell.activityImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"发现界面banner（康复+护理）2"]];
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        NSString *title = @"这是活动发布的主标题字数限制超过用";
        if (title.length > 16) {
            NSString *str = [title substringToIndex:16];
            cell.titleLabel.text = [str stringByAppendingString:@"..."];
        }
        cell.chargeLabel.textColor = YKe82c2c;
        cell.chargeLabel.text = @"¥ 999999K";
        cell.nameLabel.text = @"周琳周琳";
        cell.typeImageView.image = [UIImage imageNamed:@"康-"];
        cell.cityLabel.text = @"北京";
        
        // 将参与数设置为红色
        cell.joinLabel.text = @"已有33参与";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cell.joinLabel.text];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2 , cell.joinLabel.text.length - 4)];
        cell.joinLabel.attributedText = str;
        
        

        
        
        return cell;
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section != 0 && indexPath.section != 1) {
        YKActivityDetailVC *VC = [[YKActivityDetailVC alloc] init];
        YKNavigationController *NC = [[YKNavigationController alloc] initWithRootViewController:VC];
        NC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:NC animated:YES completion:nil];
        
    }
    
}


#pragma mark  ----  点击imageView的方法  ----
-(void)tapGROne:(UITapGestureRecognizer *)sender
{
    YKProfessionListVC *VC = [[YKProfessionListVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}
-(void)tapGRTwo:(UITapGestureRecognizer *)sender
{
    YKAnswersListVC *VC = [[YKAnswersListVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}



#pragma mark  ------  tableview滑动  ------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.ykCF.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.ykCF.carouselTime]];
}



#pragma mark  -----  布局推荐康复师cell  -----
-(void)layoutRecommendItem
{
    
    UIView *topView = [[UIView alloc] init];
    [self.recommendCell.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.recommendCell.contentView.mas_top);
        make.width.mas_equalTo(self.recommendCell.contentView.mas_width);
        make.centerX.mas_equalTo(self.recommendCell.contentView.mas_centerX);
        make.height.mas_equalTo(35 * WScale);
    }];
    
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"推荐康复师"];
    [topView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(10);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"推荐康复师";
    label.textColor = YK323232;
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(6 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.width.mas_equalTo(130 * WScale);
        make.height.mas_equalTo(topView.mas_height);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKGlobalBg;
    [self.recommendCell.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.width.mas_equalTo(self.recommendCell.contentView.mas_width);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(self.recommendCell.contentView.mas_centerX);
    }];
    
    
    // 布局collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 25 * WScale;
    layout.minimumInteritemSpacing = 1;
    layout.itemSize = CGSizeMake((375 - 150) * WScale / 5, 80 * WScale);
    layout.sectionInset = UIEdgeInsetsMake(12 * WScale, 25 * WScale, 0, 25 * WScale);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    // 注册
    [self.collectionView registerClass:[YKRecommendItem class] forCellWithReuseIdentifier:@"YKRecommendItem"];
    [self.recommendCell addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.width.mas_equalTo(self.recommendCell.contentView.mas_width);
        make.height.mas_equalTo(95 * WScale);
        make.centerX.mas_equalTo(self.recommendCell.contentView.mas_centerX);
    }];
    
    
    UIView *bottomGrayView = [[UIView alloc] init];
    bottomGrayView.backgroundColor = YKGlobalBg;
    [self.recommendCell addSubview:bottomGrayView];
    [bottomGrayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(15 * WScale);
        make.left.mas_equalTo(self.recommendCell.mas_left);
        make.right.mas_equalTo(self.recommendCell.mas_right);
        make.height.mas_equalTo(10 * WScale);
    }];
    
}


#pragma mark ------- 实现方法--------- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YKRecommendItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"YKRecommendItem" forIndexPath:indexPath];
    
    
    NSString *name = @"李伟明名字";
    NSString *office = @"践行者工作室室";


    [item.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"发现推荐康复师头像"]];
    item.nameLabel.text = name;
    
    if (office.length > 6) {
        NSString *str = [office substringToIndex:6];
        office = [str stringByAppendingString:@"..."];
    }
    item.officeLabel.text = office;
    item.addressLabel.text = @"蒙";
    
    
    return item;
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YKPersonalHomePageVC *VC = [[YKPersonalHomePageVC alloc] init];
    VC.title = @"推荐康复师";
    [self.navigationController pushViewController:VC animated:YES];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark  ----  初始化编辑按钮  -----
//-(void)initEditBtn
//{
//    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"编辑正常"] forState:UIControlStateNormal];
//    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"编辑-点击"] forState:UIControlStateHighlighted];
//    [self.editBtn addTarget:self action:@selector(LabelEditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.ykFindView addSubview:self.editBtn];
//    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.ykFindView.mas_bottom).offset(-20 * WScale);
//        make.centerX.mas_equalTo(self.ykFindView.mas_centerX);
//        make.height.mas_equalTo(51 * WScale);
//        make.width.mas_equalTo(self.editBtn.mas_height);
//    }];
//    
//}


#pragma mark  ----  编辑  ----
//-(void)LabelEditBtnAction:(UIButton *)sender
//{
//    YKActivitySelectVC *VC = [[YKActivitySelectVC alloc] init];
//    YKNavigationController *NC = [[YKNavigationController alloc] initWithRootViewController:VC];
//    [self presentViewController:NC animated:YES completion:nil];
//    
//}





@end

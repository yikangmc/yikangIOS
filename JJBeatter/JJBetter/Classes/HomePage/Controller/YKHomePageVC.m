//
//  YKHomePageVC.m
//  JJBetter
//
//  Created by yikang on 16/4/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKHomePageVC.h"
#import "YKHomePageView.h"

#import "YKNavigationController.h" /** 当前界面*/
#import "YKEssenceCell.h"
#import "YKHotLabelCell.h"
#import "YKHotLabelItem.h"
#import "YKGoodAnswerCell.h"

#import "YKSearchResultListVC.h" /** 其他界面*/
#import "YKAllLabelVC.h"
#import "YKLabelPostDetailVC.h"
#import "YKLabelContentVC.h"


@interface YKHomePageVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)YKHomePageView *ykHomePageView;

/** 头部图片 */
@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UITableView *tableView;


@property (nonatomic,strong)UITableViewCell *hotLabelCell; // 热门标签cell
@property (nonatomic,strong)UICollectionView *collectionView; // 热门标签cell上的collectionView

/** 类似于pageControll的线 */
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *middleView;
@property (nonatomic,strong)UIView *rightView;


@end


@implementation YKHomePageVC


#pragma mark  -----  lazyload  -----
-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 141 * WScale)];
        _headImageView.image = [UIImage imageNamed:@"首页banner"];
        _headImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
        [_headImageView addGestureRecognizer:tapGR];
    }
    return _headImageView;
}


#pragma mark  -----  loadView  -----
-(void)loadView
{
    self.ykHomePageView = [[YKHomePageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykHomePageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTableView];
    self.automaticallyAdjustsScrollViewInsets = YES;
    

    // 搜索点击事件
    [self.ykHomePageView.searchBtn addTarget:self action:@selector(tapSearchAction:) forControlEvents:UIControlEventTouchUpInside];

    
    // 布局分享弹框与添加事件
    [self addShareClickedAction];
    
    
}

#pragma mark  -------  初始化tableView ---
-(void)initTableView
{
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.headImageView;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ykHomePageView.searchBtn.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width);
        make.bottom.mas_equalTo(self.ykHomePageView.mas_bottom);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKHotLabelCell class] forCellReuseIdentifier:@"YKHotLabelCell"];
    [self.tableView registerClass:[YKEssenceCell class] forCellReuseIdentifier:@"YKEssenceCell"];
    [self.tableView registerClass:[YKGoodAnswerCell class] forCellReuseIdentifier:@"YKGoodAnswerCell"];
    
}


#pragma mark  -------  点击搜索  ------
-(void)tapSearchAction:(UIButton *)sender
{
    YKSearchResultListVC *VC = [[YKSearchResultListVC alloc] init];
    YKNavigationController *NC = [[YKNavigationController alloc] initWithRootViewController:VC];
    NC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:NC animated:NO completion:nil];
    
}


#pragma mark  -------  tableViewDelegate -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 43 * WScale;
    }
    return 10 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        
        UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 43 * WScale)];
        gray.backgroundColor = YKGlobalBg;
        UIView *goodAnswer = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 33 * WScale)];
        goodAnswer.backgroundColor = [UIColor whiteColor];
        [gray addSubview:goodAnswer];
        
        UIImageView *iconImg = [[UIImageView alloc] init];
        iconImg.image = [UIImage imageNamed:@"精彩解答"];
        [goodAnswer addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(goodAnswer.mas_left).offset(20 * WScale);
            make.centerY.mas_equalTo(goodAnswer.mas_centerY);
            make.height.mas_equalTo(13 * WScale);
            make.width.mas_equalTo(iconImg.mas_height);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YK333333;
        label.text = @"精彩解答";
        label.font = [UIFont systemFontOfSize:14 * WScale];
        [goodAnswer addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconImg.mas_right).offset(6 * WScale);
            make.centerY.mas_equalTo(goodAnswer.mas_centerY);
            make.width.mas_equalTo(130 * WScale);
            make.height.mas_equalTo(goodAnswer.mas_height);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = YKf0f0f0;
        [goodAnswer addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(goodAnswer.mas_bottom);
            make.width.mas_equalTo(355 * WScale);
            make.height.mas_equalTo(1 );
            make.centerX.mas_equalTo(goodAnswer.mas_centerX);
        }];
        
        return gray;
    }
    
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1;
    }
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 257 * WScale;
    }else if (indexPath.section == 1) {
        return 123 * WScale;
    }else if (indexPath.section == 2) {
        return 225 * WScale;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        
        YKEssenceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKEssenceCell"];
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"热门标签背景图"]];
        cell.titleLabel.text = @"如何让女士健康的运动如何让女士健康的运动多";
        cell.nameLabel.text = @"践行者工作室践行者工作室";
        cell.typeImageView.image = [UIImage imageNamed:@"康-"];
        cell.contentLabel.text = @"清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已早已儿早已早已儿早已早样样"; // 100个字
        cell.commentLabel.text = @"88";
        cell.likeLabel.text = @"3288";
        [cell.likeBtn setBackgroundImage: [UIImage imageNamed:@"喜欢（点击效果）"] forState:UIControlStateNormal];
        if (cell.contentLabel.text.length > 99) {
            NSString *str = [cell.contentLabel.text substringToIndex:99];
            cell.contentLabel.text = [str stringByAppendingString:@"..."];
        }else {
            cell.seeContentBtn.hidden = YES;
        }
        // 创建标签
        NSArray *arr = @[@"运动运动",@"运动康复动",@"运动康复运动",@"运动康复运运动动"];
        [cell creatLabelWithArray:arr];
        
        
        // 自适应nameLabel宽度
        CGFloat nameW = [YKEssenceCell widthForNameLabel:cell.nameLabel.text];
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(nameW + 2);
        }];
        // 调整字行距
        [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
        // 点击事件：查看全部，喜欢，评论
        [cell.seeContentBtn addTarget:self action:@selector(EssenceSeeContentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeBtn addTarget:self action:@selector(EssenceLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.commentBtn addTarget:self action:@selector(EssenceCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreImageBtn addTarget:self action:@selector(EssenceMoreShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreLabelBtn addTarget:self action:@selector(EssenceMoreShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        
        YKHotLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKHotLabelCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.hotLabelCell = cell;
        [self layoutHotLabelCell];
        
        
        return cell;
        
    }else {
        
        YKGoodAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKGoodAnswerCell"];
        
        cell.titleLabel.text = @"我的韧带撕裂，如何康复才能快速的好转？好转";
        cell.tagImageView.hidden = NO;
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        cell.nameLabel.text = @"康复师周琳";
        cell.typeImageView.image = [UIImage imageNamed:@"康-"];
        cell.timeLabel.text = @"回答于2016.04.05";
        cell.contentLabel.text = @"清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已早已儿早已早已儿早已早样样清晨，不知何处的鸟儿早已在树上在树上清晨在树上清晨样"; //126
        cell.getYesLabel.text = @"回答获得3288赞同";
        if (cell.contentLabel.text.length > 125) {
            NSString *str = [cell.contentLabel.text substringToIndex:125];
            cell.contentLabel.text = [str stringByAppendingString:@"..."];
        }else {
            cell.seeContentBtn.hidden = YES;
        }
        
        
        // 自适应nameLabel宽度
        CGFloat nameW = [YKGoodAnswerCell widthForNameLabel:cell.nameLabel.text];
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(nameW + 2);
        }];
        // 调整字行距
        [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
        // 将赞同数设置为红色
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cell.getYesLabel.text];
        [str addAttribute:NSForegroundColorAttributeName value:YKff2e2e range:NSMakeRange(4 , cell.getYesLabel.text.length - 6)];
        cell.getYesLabel.attributedText = str;
        
        
        
        
        return cell;
        
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        YKLabelPostDetailVC *VC = [[YKLabelPostDetailVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 2) {
        
        
    }
    
}


#pragma mark  ------  点击头部图片  ------
-(void)tapGR:(UITapGestureRecognizer *)sender
{
    NSLog(@"点击头部图片");
}

#pragma mark  -----  查看全部，喜欢，评论 ，分享 ------
-(void)EssenceSeeContentBtn:(UIButton *)sender
{
    YKLabelPostDetailVC *VC = [[YKLabelPostDetailVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    NSLog(@"更多");
}
-(void)EssenceLikeBtn:(UIButton *)sender
{
    NSLog(@"喜欢");
}
-(void)EssenceCommentBtn:(UIButton *)sender
{
    NSLog(@"评论");
}
-(void)EssenceMoreShareBtn:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.ykHomePageView.grayBackView.hidden = NO;
        self.ykHomePageView.shareBackView.y = CGRectGetMaxY(self.view.frame) - 234 * WScale - 64;
    }];
    
}


#pragma mark  ----  布局分享弹框与添加事件   ----
-(void)addShareClickedAction
{
    // 布局弹框
    [self.ykHomePageView creatShareAlertView];
    // 添加点击事件
    [self.ykHomePageView.weiboBtn addTarget:self action:@selector(homePageWeiboBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykHomePageView.weixinBtn addTarget:self action:@selector(homePageWeixinBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykHomePageView.weixinCircleBtn addTarget:self action:@selector(homePageWeixinCircleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykHomePageView.reportBtn addTarget:self action:@selector(homePageReportBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykHomePageView.cancleBtn addTarget:self action:@selector(homePageCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark  ----  分享到各社交平台  -----
-(void)homePageWeiboBtn:(UIButton *)sender
{
    NSLog(@"微博");
}
-(void)homePageWeixinBtn:(UIButton *)sender
{
    NSLog(@"微信");
}
-(void)homePageWeixinCircleBtn:(UIButton *)sender
{
    NSLog(@"微信朋友圈");
}


#pragma mark  ----  举报与取消  -----
-(void)homePageReportBtn:(UIButton *)sender
{
    NSLog(@"举报");
}

-(void)homePageCancleBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.ykHomePageView.grayBackView.hidden = YES;
        self.ykHomePageView.shareBackView.y = CGRectGetMaxY(self.view.frame) + 64;
    }];

}


#pragma mark  ----  布局热门标签cell  -----
-(void)layoutHotLabelCell
{
    
    // 上半部分
    UIView *topView = [[UIView alloc] init];
    [self.hotLabelCell.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hotLabelCell.contentView.mas_top);
        make.width.mas_equalTo(self.hotLabelCell.contentView.mas_width);
        make.centerX.mas_equalTo(self.hotLabelCell.contentView.mas_centerX);
        make.height.mas_equalTo(33 * WScale);
    }];
    
    
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"热门标签"];
    [topView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(20 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.height.mas_equalTo(13 * WScale);
        make.width.mas_equalTo(iconImg.mas_height);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = YK333333;
    label.text = @"热门标签";
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(6 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.width.mas_equalTo(130 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    UIButton *moreBtn0 = [UIButton buttonWithType:UIButtonTypeSystem];
    [moreBtn0 setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn0 setTitleColor:YK656565 forState:UIControlStateNormal];
    moreBtn0.titleLabel.font = [UIFont systemFontOfSize: 13.0 * WScale];
    [moreBtn0 addTarget:self action:@selector(moreLabelAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:moreBtn0];
    [moreBtn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView.mas_right).offset(-40 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.width.mas_equalTo(30 * WScale);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"更多.png"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreLabelAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(moreBtn0.mas_right).offset(15 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.height.mas_equalTo(9);
        make.width.mas_equalTo(5);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKf0f0f0;
    [self.hotLabelCell.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.width.mas_equalTo(355 * WScale);
        make.height.mas_equalTo(1 );
        make.centerX.mas_equalTo(self.hotLabelCell.contentView.mas_centerX);
    }];
    
    
    // 中间部分
    UIView *centerView = [[UIView alloc] init];
    [self.hotLabelCell.contentView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.centerX.mas_equalTo(self.hotLabelCell.contentView.mas_centerX);
        make.width.mas_equalTo(self.hotLabelCell.contentView.mas_width);
        make.height.mas_equalTo(70 * WScale);
    }];
    
    
    // 布局collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 11.5 * WScale;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 11.5 * WScale;
    layout.itemSize = CGSizeMake(50 * WScale, 50 * WScale);

    layout.sectionInset = UIEdgeInsetsMake(10 * WScale, 9 * WScale, 10 * WScale, 9 * WScale);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // 注册
    [self.collectionView registerClass:[YKHotLabelItem class] forCellWithReuseIdentifier:@"YKHotLabelItem"];
    [centerView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(centerView.mas_top);
        make.width.mas_equalTo(centerView.mas_width);
        make.bottom.mas_equalTo(centerView.mas_bottom);
        make.centerX.mas_equalTo(centerView.mas_centerX);
    }];
    
    
    // 下半部分
    UIView *bottomView = [[UIView alloc] init];
    [self.hotLabelCell addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(centerView.mas_bottom);
        make.width.mas_equalTo(self.hotLabelCell.contentView.mas_width);
        make.centerX.mas_equalTo(centerView.mas_centerX);
        make.height.mas_equalTo(20 * WScale);
    }];
    
    self.middleView = [[UIView alloc] init];
    self.middleView.backgroundColor = YKFull153Color;
    [bottomView addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(5 * WScale);
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.width.mas_equalTo(40 * WScale);
        make.height.mas_equalTo(2 * WScale);
    }];
    
    self.leftView = [[UIView alloc] init];
    self.leftView.backgroundColor = YK1795fc;
    [bottomView addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.middleView.mas_left).offset( - 20 * WScale);
        make.centerY.mas_equalTo(self.middleView.mas_centerY);
        make.width.mas_equalTo(self.middleView.mas_width);
        make.height.mas_equalTo(self.middleView.mas_height);
    }];
    
    self.rightView = [[UIView alloc] init];
    self.rightView.backgroundColor = YKFull153Color;
    [bottomView addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.middleView.mas_right).offset( 20 * WScale);
        make.centerY.mas_equalTo(self.middleView.mas_centerY);
        make.width.mas_equalTo(self.middleView.mas_width);
        make.height.mas_equalTo(self.middleView.mas_height);
    }];
    
    
}


#pragma mark  ----  更多标签方法  -------
-(void)moreLabelAction:(UIButton *)sender
{
    YKAllLabelVC *VC = [[YKAllLabelVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}


#pragma mark ------- 实现方法--------- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YKHotLabelItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"YKHotLabelItem" forIndexPath:indexPath];
    
    item.hotItemLabel.text = @"佳佳康复";
    
    
    
    return item;
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YKLabelContentVC *VC = [[YKLabelContentVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}


#pragma mark  -----  pageController滑动  ------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.collectionView.contentOffset.x >= 0 && self.collectionView.contentOffset.x < ScreenW) {
        
        self.leftView.backgroundColor = YK1795fc;
        self.middleView.backgroundColor = YKFull153Color;
        self.rightView.backgroundColor = YKFull153Color;
        
    }else if (self.collectionView.contentOffset.x >= ScreenW && self.collectionView.contentOffset.x < 2 * ScreenW) {
        
        self.leftView.backgroundColor = YKFull153Color;
        self.middleView.backgroundColor = YK1795fc;
        self.rightView.backgroundColor = YKFull153Color;
        
    }else if (self.collectionView.contentOffset.x >= 2 * ScreenW) {
        
        self.leftView.backgroundColor = YKFull153Color;
        self.middleView.backgroundColor = YKFull153Color;
        self.rightView.backgroundColor = YK1795fc;
    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

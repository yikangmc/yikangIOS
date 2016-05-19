//
//  YKLabelContentVC.m
//  JJBetter
//
//  Created by yikang on 16/4/23.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKLabelContentVC.h"  // 当前界面
#import "YKLabelContentView.h"
#import "YKImgLabelContentCell.h"
#import "YKOnlyLabelContentCell.h"

#import "YKLabelPostDetailVC.h"  // 其他界面
#import "YKNavigationController.h"
#import "YKIssuePostVC.h"


@interface YKLabelContentVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)YKLabelContentView *ykLabelContentView;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIButton *editBtn;  // 编辑button

@end

@implementation YKLabelContentVC


#pragma mark  ------  loadView  ------
-(void)loadView
{
    self.ykLabelContentView = [[YKLabelContentView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykLabelContentView;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"瘦身";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(LabelContentBackToUp:)];
    // 关注button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 41 * WScale, 20 * WScale);
    [btn setBackgroundImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(focusAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    // 初始化tableView
    [self initTableView];
    
    
    // 初始化编辑按钮
    [self initEditBtn];
    
    
    // 布局分享弹框与添加事件
    [self labelContentAddShareClickedAction];
    
    
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
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.ykLabelContentView.frame.origin.y - 64, self.ykLabelContentView.frame.size.width, 44);
    
}



#pragma mark  ----  返回  -----
-(void)LabelContentBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ----  关注  ------
-(void)focusAction:(UIButton *)sender
{
    if (sender.selected) {
        
        [sender setBackgroundImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        
    }else{
        
        [sender setBackgroundImage:[UIImage imageNamed:@"已关注"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
    
}



#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.ykLabelContentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ykLabelContentView.mas_top);
        make.width.mas_equalTo(self.ykLabelContentView.mas_width);
        make.centerX.mas_equalTo(self.ykLabelContentView.mas_centerX);
        make.bottom.mas_equalTo(self.ykLabelContentView.mas_bottom);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKImgLabelContentCell class] forCellReuseIdentifier:@"YKImgLabelContentCell"];
    [self.tableView registerClass:[YKOnlyLabelContentCell class] forCellReuseIdentifier:@"YKOnlyLabelContentCell"];
    
    
}


#pragma mark  -----  tableView代理方法  ------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 309 * WScale;
    }
    return 217 * WScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        YKImgLabelContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKImgLabelContentCell"];
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        cell.lineView.hidden = YES;
        cell.nickLabel.text = @"运动员";
        cell.nameLabel.text = @"瘦身SSYD";
        cell.timeLabel.text = @"2016-04-06";
        cell.contentLabel.text = @"清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已早已儿早已早已儿早已早样样李"; // 101个字
        cell.commentLabel.text = @"88";
        cell.likeLabel.text = @"3288";
        if (cell.contentLabel.text.length > 100) {
            NSString *str = [cell.contentLabel.text substringToIndex:100];
            cell.contentLabel.text = [str stringByAppendingString:@"..."];
        }else {
            cell.moreContentBtn.hidden = YES;
        }
        // 创建标签
        NSArray *arr = @[@"运动康复瘦身",@"运动康复瘦身",@"运动康复瘦身",@"运动康复瘦身"];
        [cell creatLabelWithArray:arr];
        
        
        // 自适应nameLabel宽度
        CGFloat nameW = [YKImgLabelContentCell widthForNameLabel:cell.nameLabel.text];
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(nameW + 2);
        }];
        // 调整字行距
        [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
        // 点击事件：更多，喜欢，分享
        [cell.moreContentBtn addTarget:self action:@selector(labelMoreContentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeBtn addTarget:self action:@selector(LabelContentLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreImageBtn addTarget:self action:@selector(LabelContentMoreShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreLabelBtn addTarget:self action:@selector(LabelContentMoreShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        

        
        
        return cell;
        
    }else {
        
        YKOnlyLabelContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKOnlyLabelContentCell"];
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        cell.lineView.hidden = YES;
        cell.nickLabel.text = @"运动员";
        cell.nameLabel.text = @"瘦身SSYD";
        cell.timeLabel.text = @"2016-04-06";
        cell.contentLabel.text = @"清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已早已儿早已早已儿早已早样样李"; // 101个字
        cell.commentLabel.text = @"88";
        cell.likeLabel.text = @"3288";
        if (cell.contentLabel.text.length > 100) {
            NSString *str = [cell.contentLabel.text substringToIndex:100];
            cell.contentLabel.text = [str stringByAppendingString:@"..."];
        }else {
            cell.moreContentBtn.hidden = YES;
        }
        // 创建标签
        NSArray *arr = @[@"运动康复",@"运动康复",@"运动康复",@"运动康复"];
        [cell creatLabelWithArray:arr];
        
        
        // 自适应nameLabel宽度
        CGFloat nameW = [YKImgLabelContentCell widthForNameLabel:cell.nameLabel.text];
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(nameW + 2);
        }];
        // 调整字行距
        [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
        // 点击事件：更多，喜欢，分享
        [cell.moreContentBtn addTarget:self action:@selector(labelMoreContentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeBtn addTarget:self action:@selector(LabelContentLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreImageBtn addTarget:self action:@selector(LabelContentMoreShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreLabelBtn addTarget:self action:@selector(LabelContentMoreShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }
    
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YKLabelPostDetailVC *VC = [[YKLabelPostDetailVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}




#pragma mark  ----  更多，喜欢，分享 -----
-(void)labelMoreContentBtn:(UIButton *)sender
{
    YKLabelPostDetailVC *VC = [[YKLabelPostDetailVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)LabelContentLikeBtn:(UIButton *)sender
{
    NSLog(@"喜欢");
}
-(void)LabelContentMoreShareBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.ykLabelContentView.grayBackView.hidden = NO;
        self.ykLabelContentView.shareBackView.y = CGRectGetMaxY(self.view.frame) - 234 * WScale - 64;
    }];
}


#pragma mark  ----  布局分享弹框与添加事件   ----
-(void)labelContentAddShareClickedAction
{
    // 布局弹框
    [self.ykLabelContentView creatShareAlertView];
    // 添加点击事件
    [self.ykLabelContentView.weiboBtn addTarget:self action:@selector(labelContentWeiboBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLabelContentView.weixinBtn addTarget:self action:@selector(labelContentWeixinBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLabelContentView.weixinCircleBtn addTarget:self action:@selector(labelContentWeixinCircleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLabelContentView.reportBtn addTarget:self action:@selector(labelContentReportBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLabelContentView.cancleBtn addTarget:self action:@selector(labelContentCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark  ----  分享到各社交平台  -----
-(void)labelContentWeiboBtn:(UIButton *)sender
{
    NSLog(@"微博");
}
-(void)labelContentWeixinBtn:(UIButton *)sender
{
    NSLog(@"微信");
}
-(void)labelContentWeixinCircleBtn:(UIButton *)sender
{
    NSLog(@"微信朋友圈");
}


#pragma mark  ----  举报与取消  -----
-(void)labelContentReportBtn:(UIButton *)sender
{
    NSLog(@"举报");
}

-(void)labelContentCancleBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.ykLabelContentView.grayBackView.hidden = YES;
        self.ykLabelContentView.shareBackView.y = CGRectGetMaxY(self.view.frame) + 64;
    }];
    
}


#pragma mark  ----  初始化编辑按钮  -----
-(void)initEditBtn
{
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"编辑正常"] forState:UIControlStateNormal];
    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"编辑-点击"] forState:UIControlStateHighlighted];
    [self.editBtn addTarget:self action:@selector(LabelEditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLabelContentView addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.ykLabelContentView.mas_bottom).offset(-20 * WScale);
        make.centerX.mas_equalTo(self.ykLabelContentView.mas_centerX);
        make.height.mas_equalTo(51 * WScale);
        make.width.mas_equalTo(self.editBtn.mas_height);
    }];
    
}


#pragma mark  ----  编辑  ----
-(void)LabelEditBtnAction:(UIButton *)sender
{
    
    YKIssuePostVC *VC = [[YKIssuePostVC alloc] init];
    YKNavigationController *NC = [[YKNavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:NC animated:YES completion:nil];
    
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

//
//  YKAnswerDetailVC.m
//  JJBetter
//
//  Created by yikang on 16/5/10.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKAnswerDetailVC.h"  // 当前界面
#import "YKAnswerDetailView.h"
#import "YKAnswerQuestionImageCell.h"
#import "YKAnswerQuestionNoImgCell.h"
#import "YKAnswerAnswerCell.h"

@interface YKAnswerDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)YKAnswerDetailView *ykAnswerDetailView;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSString *middleTitleStr;
@property (nonatomic,copy)NSString *middleContentStr;

@end

@implementation YKAnswerDetailVC


#pragma mark  ----  loadView  -----
-(void)loadView
{
    self.ykAnswerDetailView = [[YKAnswerDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykAnswerDetailView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"问答-这是用户ID";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(AnswerDetailBackToUp:)];
    // 我来回答button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"我来回答" forState:UIControlStateNormal];
    [btn setTitleColor:YK0faadd forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    btn.frame = CGRectMake(0, 0, 60 * WScale, 15 * HScale);
    [btn addTarget:self action:@selector(letMeAnswer:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    // 初始化tableView
    [self initTableView];
    
    
    // 布局分享弹框与添加事件
    [self labelPostDetailAddShareClickedAction];
    
    
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
-(void)AnswerDetailBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ----  我来回答  ----
-(void)letMeAnswer:(UIButton *)sender
{
    NSLog(@"我来回答");
}


#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = YKGlobalBg;
    [self.ykAnswerDetailView addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerClass:[YKAnswerQuestionImageCell class] forCellReuseIdentifier:@"YKAnswerQuestionImageCell"];
    [self.tableView registerClass:[YKAnswerQuestionNoImgCell class] forCellReuseIdentifier:@"YKAnswerQuestionNoImgCell"];
    [self.tableView registerClass:[YKAnswerAnswerCell class] forCellReuseIdentifier:@"YKAnswerAnswerCell"];
    
    
}



#pragma mark  -----  tableView代理方法  ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10 * WScale;
    }
    return 42 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 42 * WScale)];
        gray.backgroundColor = YKGlobalBg;
        
        UIView *white = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 32 * WScale)];
        white.backgroundColor = [UIColor whiteColor];
        [gray addSubview:white];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 13 * WScale, ScreenW, 19 * WScale)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"全部回答";
        label.textColor = YK1f1f1f;
        label.font = [UIFont systemFontOfSize:13 * WScale];
        label.textAlignment = NSTextAlignmentCenter;
        [white addSubview:label];
        
        return gray;
    }
    
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        BOOL show = YES;
        if (show) {
            
            // 带图片row高度
            CGSize size = CGSizeMake(345 * WScale, 0);
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15 * WScale]};
            CGRect rect = [self.middleTitleStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            
            NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
            CGRect rect1 = [self.middleContentStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic1 context:nil];
            CGFloat countH = (self.middleContentStr.length / 26 + 1 ) * 3 * WScale;
            
            return rect.size.height + rect1.size.height + countH + 227 * WScale;
            
        }else {
            
            // 不带图片row高度
            CGSize size = CGSizeMake(345 * WScale, 0);
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15 * WScale]};
            CGRect rect = [self.middleTitleStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            
            NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
            CGRect rect1 = [self.middleContentStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic1 context:nil];
            CGFloat countH = (self.middleContentStr.length / 26 + 1 ) * 3 * WScale;
            
            return rect.size.height + rect1.size.height + countH + 137 * WScale;
        }
        
        
    }
    return 300 * WScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        BOOL show = YES;
        if (show) {
            // 带图片cell
            YKAnswerQuestionImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAnswerQuestionImageCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            cell.titleLabel.text = @"我的韧带撕裂，如何康复才能快速的好转？何康复才能快速的好转？";
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
            cell.nameLabel.text = @"这是用户ID";
            cell.timeLabel.text = @"提问于2016.04.05";
            cell.contentLabel.text = @"这是对问题的描述，这是对问题的描述，这是对问题的描述，这是对问题的描述，这是对问题的描述，这是对问题的描述这是对问题的描述，liyang";
            cell.commentLabel.text = @"88";
            cell.likeLabel.text = @"3288";
            // 创建标签
            NSArray *arr = @[@"运动康复清晨",@"运动清晨康复",@"清晨运动康复",@"运动康清晨复"];
            [cell creatLabelWithArray:arr];
            self.middleTitleStr = cell.titleLabel.text;
            self.middleContentStr = cell.contentLabel.text;
            
            
            // 调整字体行间距
            [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
            
            // 标题自适应高度
            CGFloat titleH = [YKAnswerQuestionImageCell heightForTitleLabel:cell.titleLabel.text];
            [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(titleH + 2);
            }];
            // 自适应nameLabel宽度
            CGFloat nameW = [YKAnswerQuestionImageCell widthForNameLabel:cell.nameLabel.text];
            [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(nameW + 2);
            }];
            // 自适应内容高度
            CGFloat contentH = [YKAnswerQuestionImageCell heightForQuestionContentLabel:cell.contentLabel.text];
            [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(345 * WScale);
                make.height.mas_equalTo(contentH );
            }];
            
            // 点击事件：喜欢，分享
            [cell.likeBtn addTarget:self action:@selector(answerDetailLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.moreImageBtn addTarget:self action:@selector(answerDetailShareBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.moreLabelBtn addTarget:self action:@selector(answerDetailShareBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            return cell;
            
        }else {
            
            // 不带图片cell
            YKAnswerQuestionNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAnswerQuestionNoImgCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            cell.titleLabel.text = @"我的韧带撕裂，如何康复才能快速的好转？何康复才能快速的好转？";
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
            cell.nameLabel.text = @"这是用户ID";
            cell.timeLabel.text = @"提问于2016.04.05";
            cell.contentLabel.text = @"这是对问题的描述，这是对问题的描述，这是对问题的描述，这是对问题的描述，这是对问题的描述，这是对问题的描述这是对问题的描述，liyang";
            cell.commentLabel.text = @"88";
            cell.likeLabel.text = @"3288";
            // 创建标签
            NSArray *arr = @[@"运动康复清晨",@"运动清晨康复",@"清晨运动康复",@"运动康清晨复"];
            [cell creatLabelWithArray:arr];
            self.middleTitleStr = cell.titleLabel.text;
            self.middleContentStr = cell.contentLabel.text;
            
            
            // 调整字体行间距
            [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
            
            // 标题自适应高度
            CGFloat titleH = [YKAnswerQuestionImageCell heightForTitleLabel:cell.titleLabel.text];
            [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(titleH + 2);
            }];
            // 自适应nameLabel宽度
            CGFloat nameW = [YKAnswerQuestionImageCell widthForNameLabel:cell.nameLabel.text];
            [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(nameW + 2);
            }];
            // 自适应内容高度
            CGFloat contentH = [YKAnswerQuestionImageCell heightForQuestionContentLabel:cell.contentLabel.text];
            [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(345 * WScale);
                make.height.mas_equalTo(contentH );
            }];
            
            // 点击事件：喜欢，分享
            [cell.likeBtn addTarget:self action:@selector(answerDetailLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.moreImageBtn addTarget:self action:@selector(answerDetailShareBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.moreLabelBtn addTarget:self action:@selector(answerDetailShareBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            return cell;
        }
        
        
    }else {
        
        
        YKAnswerAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAnswerAnswerCell"];
        
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        cell.nameLabel.text = @"康复师周琳";
        cell.typeImageView.image = [UIImage imageNamed:@"康-"];
        cell.timeLabel.text = @"30分钟前";
        
        
        // 自适应nameLabel宽度
        CGFloat nameW = [YKAnswerAnswerCell widthForNameLabel:cell.nameLabel.text];
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(nameW + 2);
        }];
        
        
        
        return cell;
    }
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}


#pragma mark  ----  喜欢，分享  -----
-(void)answerDetailLikeBtn:(UIButton *)sender
{
    NSLog(@"喜欢");
}

-(void)answerDetailShareBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.ykAnswerDetailView.grayBackView.hidden = NO;
        self.ykAnswerDetailView.shareBackView.y = CGRectGetMaxY(self.view.frame) - 234 * WScale - 64;
    }];
}


#pragma mark  ----  布局分享弹框与添加事件   ----
-(void)labelPostDetailAddShareClickedAction
{
    // 布局弹框
    [self.ykAnswerDetailView creatShareAlertView];
    // 添加点击事件
    [self.ykAnswerDetailView.weiboBtn addTarget:self action:@selector(answerDetailWeiboBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykAnswerDetailView.weixinBtn addTarget:self action:@selector(answerDetailWeixinBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykAnswerDetailView.weixinCircleBtn addTarget:self action:@selector(answerDetailWeixinCircleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykAnswerDetailView.reportBtn addTarget:self action:@selector(answerDetailReportBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykAnswerDetailView.cancleBtn addTarget:self action:@selector(answerDetailCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark  ----  分享到各社交平台  -----
-(void)answerDetailWeiboBtn:(UIButton *)sender
{
    NSLog(@"微博");
}
-(void)answerDetailWeixinBtn:(UIButton *)sender
{
    NSLog(@"微信");
}
-(void)answerDetailWeixinCircleBtn:(UIButton *)sender
{
    NSLog(@"微信朋友圈");
}


#pragma mark  ----  举报与取消  -----
-(void)answerDetailReportBtn:(UIButton *)sender
{
    NSLog(@"举报");
}

-(void)answerDetailCancleBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.ykAnswerDetailView.grayBackView.hidden = YES;
        self.ykAnswerDetailView.shareBackView.y = CGRectGetMaxY(self.view.frame) + 64;
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end

//
//  YKLabelPostDetailVC.m
//  JJBetter
//
//  Created by yikang on 16/4/25.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKLabelPostDetailVC.h" // 当前界面
#import "YKLabelPostDetailView.h"
#import "YKLabelPostDetailImgCell.h"
#import "YKLabelPostDetailNoImgCell.h"
#import "YKLabelPostPeopleCell.h"
#import "YKLabelPostCommentCell.h"


@interface YKLabelPostDetailVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)YKLabelPostDetailView *ykLabelPostDetailView;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSString *middleContentStr;  // 接收帖子的内容
@property (nonatomic,copy)NSString *middleCommentStr;  // 接收评论的内容

@property (nonatomic,strong)UITextField *commentTF;  // 评论输入框


@end

@implementation YKLabelPostDetailVC


#pragma mark  -----  loadView  ------
-(void)loadView
{
    self.ykLabelPostDetailView = [[YKLabelPostDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykLabelPostDetailView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"瘦身SSYD";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(LabelPostDetailBackToUp:)];
    
    // 初始化tableView
    [self initTableView];
    

    // 初始化最下方发表评论框
    [self initCommentTF];
    
    
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
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.ykLabelPostDetailView.frame.origin.y - 64, self.ykLabelPostDetailView.frame.size.width, 44);
    
}



#pragma mark  ----  返回  -----
-(void)LabelPostDetailBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = YKGlobalBg;
    [self.ykLabelPostDetailView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ykLabelPostDetailView.mas_top);
        make.width.mas_equalTo(self.ykLabelPostDetailView.mas_width);
        make.centerX.mas_equalTo(self.ykLabelPostDetailView.mas_centerX);
        make.bottom.mas_equalTo(self.ykLabelPostDetailView.mas_bottom).offset(-50 * WScale);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKLabelPostDetailImgCell class] forCellReuseIdentifier:@"YKLabelPostDetailImgCell"];
    [self.tableView registerClass:[YKLabelPostDetailNoImgCell class] forCellReuseIdentifier:@"YKLabelPostDetailNoImgCell"];
    [self.tableView registerClass:[YKLabelPostPeopleCell class] forCellReuseIdentifier:@"YKLabelPostPeopleCell"];
    [self.tableView registerClass:[YKLabelPostCommentCell class] forCellReuseIdentifier:@"YKLabelPostCommentCell"];
    
    
}



#pragma mark  -----  tableView代理方法  ------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        BOOL show = YES;
        if (show) {
            
            // 带图片row高度
            CGSize size = CGSizeMake(345 * WScale, 0);
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
            CGRect rect = [self.middleContentStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            CGFloat countH = (self.middleContentStr.length / 26 + 1 ) * 3 * WScale;
            
            return rect.size.height + countH + 234 * WScale;
            
        }else {
            
            // 不带图片row高度
            CGSize size = CGSizeMake(345 * WScale, 0);
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
            CGRect rect = [self.middleContentStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            CGFloat countH = (self.middleContentStr.length / 26 + 1 ) * 3 * WScale;
            
            return rect.size.height + countH + 144 * WScale;
            
        }
        
    }else if (indexPath.section == 1) {
        
        return 55 * WScale;
    }
    
    CGSize size = CGSizeMake(310 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
    CGRect rect = [self.middleCommentStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height + 90 * WScale;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 10 * WScale;
    }
    return 42 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        
        UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 42 * WScale)];
        gray.backgroundColor = YKGlobalBg;
        
        UIView *white = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 32 * WScale)];
        white.backgroundColor = [UIColor whiteColor];
        [gray addSubview:white];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 13 * WScale, ScreenW, 19 * WScale)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"全部评论";
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        
        
        BOOL show = YES;
        if (show) {
            
            // 带图片cell
            YKLabelPostDetailImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKLabelPostDetailImgCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.userInteractionEnabled = YES;
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
            cell.nickLabel.text = @"运动员";
            cell.nameLabel.text = @"瘦身SSYD";
            cell.timeLabel.text = @"2016-04-06";
            cell.contentLabel.text = @"清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已早已的鸟儿早";
            self.middleContentStr = cell.contentLabel.text;
            cell.commentLabel.text = @"88";
            cell.likeLabel.text = @"3288";
            
            // 调整字体行间距
            [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
            
            // 创建标签
            NSArray *arr = @[@"运动康复清晨",@"运动清晨康复",@"清晨运动康复",@"运动康清晨复"];
            [cell creatLabelWithArray:arr];
            
            // 自适应nameLabel宽度
            CGFloat nameW = [YKLabelPostDetailImgCell widthForNameLabel:cell.nameLabel.text];
            [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(nameW + 2);
            }];
            // 自适应内容高度
            CGFloat contentH = [YKLabelPostDetailImgCell heightForPostContentLabel:cell.contentLabel.text];
            [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(contentH );
            }];
            
            // 点击事件：喜欢，分享
            [cell.likeBtn addTarget:self action:@selector(labelPostDetailLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.moreImageBtn addTarget:self action:@selector(labelPostDetailShareBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.moreLabelBtn addTarget:self action:@selector(labelPostDetailShareBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            return cell;
            
        }else {
            
            // 不带图片cell
            YKLabelPostDetailNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKLabelPostDetailNoImgCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.userInteractionEnabled = YES;
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
            cell.nickLabel.text = @"运动员";
            cell.nameLabel.text = @"瘦身SSYD";
            cell.timeLabel.text = @"2016-04-06";
            cell.contentLabel.text = @"清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已早已的鸟儿早已在树上清晨，不知何处的鸟儿早已早已的鸟儿早已在树上清晨，不知何处的鸟儿早已早已处不知何处的鸟儿早已早已的鸟儿早已在树上清晨，不知何处的鸟儿早已早已处晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已早已的鸟儿早已在树上清晨，不知何处的鸟儿早已早已的鸟儿早已在树上清晨，不知何处的鸟儿早已早已处不知何处的鸟儿早已早已的鸟儿早已在树上清晨，不知何处的鸟儿早已早已处在树上清晨，不知何处的鸟儿早已早已处不知何处的鸟儿早已早已的鸟儿早已在树上清晨，不知何处的鸟儿早已早已处在树上清晨，不知何处的鸟";
            self.middleContentStr = cell.contentLabel.text;
            cell.commentLabel.text = @"88";
            cell.likeLabel.text = @"3288";
            
            // 调整字体行间距
            [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
            
            // 创建标签
            NSArray *arr = @[@"运动康复清晨",@"运动清晨康复",@"清晨运动康复",@"运动康清晨复"];
            [cell creatLabelWithArray:arr];
            
            // 自适应nameLabel宽度
            CGFloat nameW = [YKLabelPostDetailImgCell widthForNameLabel:cell.nameLabel.text];
            [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(nameW + 2);
            }];
            // 自适应内容高度
            CGFloat contentH = [YKLabelPostDetailImgCell heightForPostContentLabel:cell.contentLabel.text];
            [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(contentH );
            }];
            
            // 点击事件：喜欢，分享
            [cell.likeBtn addTarget:self action:@selector(labelPostDetailLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.moreImageBtn addTarget:self action:@selector(labelPostDetailShareBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.moreLabelBtn addTarget:self action:@selector(labelPostDetailShareBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            return cell;
        }
        
        
    }else if (indexPath.section == 1) {
        
        YKLabelPostPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKLabelPostPeopleCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.getYesLabel.text = @"获4567支持";
        NSArray *arr = @[@"",@"",@"",@"",@"",@"",@""];
        [cell creatImageViewWithArray:arr];
        
        // 将支持数设置为红色
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cell.getYesLabel.text];
        [str addAttribute:NSForegroundColorAttributeName value:YKff2e2e range:NSMakeRange(1 , cell.getYesLabel.text.length - 3)];
        cell.getYesLabel.attributedText = str;
        
        
        
        return cell;
        
    }else {
        

        YKLabelPostCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKLabelPostCommentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        cell.nameLabel.text = @"康复师周琳";
        cell.typeImageView.image = [UIImage imageNamed:@"康-"];
        cell.timeLabel.text = @"30分钟前";
        cell.contentLabel.text = @"夏天是快乐的。我们可以到公园去游泳，去划船；可以在浓浓的树荫下玩耍，夏天是快乐的。我们可以到公园去游泳，去划船；可以在浓浓的树荫下玩";
        self.middleCommentStr = cell.contentLabel.text;
        
        // 自适应nameLabel宽度
        CGFloat nameW = [YKLabelPostCommentCell widthForNameLabel:cell.nameLabel.text];
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(nameW + 2);
        }];
        // 自适应评论内容高度
        CGFloat commentH = [YKLabelPostCommentCell heightForPostCommentLabel:cell.contentLabel.text];
        [cell.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(commentH + 2);
        }];
        
        
        
        
        return cell;
    }
    
    return nil;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}



#pragma mark  ----  喜欢，评论，分享  -----
-(void)labelPostDetailLikeBtn:(UIButton *)sender
{
    NSLog(@"喜欢");
}
-(void)labelPostDetailShareBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.ykLabelPostDetailView.grayBackView.hidden = NO;
        self.ykLabelPostDetailView.shareBackView.y = CGRectGetMaxY(self.view.frame) - 234 * WScale - 64;
    }];
}


#pragma mark  ----  布局分享弹框与添加事件   ----
-(void)labelPostDetailAddShareClickedAction
{
    // 布局弹框
    [self.ykLabelPostDetailView creatShareAlertView];
    // 添加点击事件
    [self.ykLabelPostDetailView.weiboBtn addTarget:self action:@selector(labelPostDetailWeiboBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLabelPostDetailView.weixinBtn addTarget:self action:@selector(labelPostDetailWeixinBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLabelPostDetailView.weixinCircleBtn addTarget:self action:@selector(labelPostDetailWeixinCircleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLabelPostDetailView.reportBtn addTarget:self action:@selector(labelPostDetailReportBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.ykLabelPostDetailView.cancleBtn addTarget:self action:@selector(labelPostDetailCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark  ----  分享到各社交平台  -----
-(void)labelPostDetailWeiboBtn:(UIButton *)sender
{
    NSLog(@"微博");
}
-(void)labelPostDetailWeixinBtn:(UIButton *)sender
{
    NSLog(@"微信");
}
-(void)labelPostDetailWeixinCircleBtn:(UIButton *)sender
{
    NSLog(@"微信朋友圈");
}


#pragma mark  ----  举报与取消  -----
-(void)labelPostDetailReportBtn:(UIButton *)sender
{
    NSLog(@"举报");
}

-(void)labelPostDetailCancleBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.ykLabelPostDetailView.grayBackView.hidden = YES;
        self.ykLabelPostDetailView.shareBackView.y = CGRectGetMaxY(self.view.frame) + 64;
    }];
    
}


#pragma mark  ---  初始化最下方发表评论框  -----
-(void)initCommentTF
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 64 - 50*WScale, ScreenW, 50 * WScale)];
    view.backgroundColor = [UIColor whiteColor];
    [self.ykLabelPostDetailView addSubview:view];

    
    self.commentTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40 * WScale)];
    self.commentTF.placeholder = @"我在这里补充两句~";
    [self.commentTF setValue:YK656565 forKeyPath:@"_placeholderLabel.textColor"];
    self.commentTF.font = [UIFont systemFontOfSize:13 * WScale];
    self.commentTF.returnKeyType = UIReturnKeySend;
    self.commentTF.leftViewMode = UITextFieldViewModeAlways;
    self.commentTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30 * WScale, 0)];
    self.commentTF.delegate = self;
    [view addSubview:self.commentTF];

    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1 * WScale)];
    line0.backgroundColor = YK656565;
    [view addSubview:line0];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14 * WScale, 41 * WScale, 300 *WScale, 1 * WScale )];
    line.backgroundColor = YKf0f0f0;
    [view addSubview:line];
    
    
}


#pragma mark  -----  发送评论  -----
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"发送评论");
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




@end

//
//  YKPersonalHomePageVC.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPersonalHomePageVC.h"  // 当前界面
#import "YKPersonalHomePageInforCell.h"
#import "YKPersonalHomePageAboutCell.h"
#import "YKPersonalHomePageProfessionFieldCell.h"
#import "YKPersonalHomePagePersonContentCell.h"
#import "YKPersonalHomePageDynamicCell.h"

#import "YKPersonalHomePageLabelVC.h"  // 其他界面
#import "YKPersonalHomePagePostVC.h"
#import "YKPersonalHomePageFocuserVC.h"


@interface YKPersonalHomePageVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSString *middleContentStr;

@end

@implementation YKPersonalHomePageVC



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(PersonalHomePageBackToUp:)];
    
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
-(void)PersonalHomePageBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];

    
    // 注册cell
    [self.tableView registerClass:[YKPersonalHomePageInforCell class] forCellReuseIdentifier:@"YKPersonalHomePageInforCell"];
    [self.tableView registerClass:[YKPersonalHomePageAboutCell class] forCellReuseIdentifier:@"YKPersonalHomePageAboutCell"];
    [self.tableView registerClass:[YKPersonalHomePageProfessionFieldCell class] forCellReuseIdentifier:@"YKPersonalHomePageProfessionFieldCell"];
    [self.tableView registerClass:[YKPersonalHomePagePersonContentCell class] forCellReuseIdentifier:@"YKPersonalHomePagePersonContentCell"];
    [self.tableView registerClass:[YKPersonalHomePageDynamicCell class] forCellReuseIdentifier:@"YKPersonalHomePageDynamicCell"];
    
    
}


#pragma mark  ----  tableView代理方法  -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 4) {
        return 5;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90 * WScale;
    }else if (indexPath.section == 1) {
        return 73 * WScale;
    }else if (indexPath.section == 2) {
        return 84 * WScale;
    }else if (indexPath.section == 3) {
        
        CGFloat contentH = [YKPersonalHomePagePersonContentCell heightForIntroduceLabel:self.middleContentStr];
        return contentH + 63 * WScale ;
        
    }else {
        return 64 * WScale;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 4) {
        return 50 * WScale;
    }
    return 10 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 4) {
        
        UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40 * WScale)];
        gray.backgroundColor = YKGlobalBg;
        
        UIView *white = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 40)];
        white.backgroundColor = [UIColor whiteColor];
        [gray addSubview:white];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YK333333;
        label.font = [UIFont systemFontOfSize:15 * WScale];
        label.text = @"最新动态";
        [white addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(white.mas_left).offset(15 * WScale);
            make.right.mas_equalTo(white.mas_right);
            make.centerY.mas_equalTo(white.mas_centerY);
            make.height.mas_equalTo(white.mas_height);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = YKGlobalBg;
        [white addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(white.mas_left).offset(15 * WScale);
            make.right.mas_equalTo(white.mas_right).offset(-15 * WScale);
            make.bottom.mas_equalTo(label.mas_bottom);
            make.height.mas_equalTo(1 * WScale);
        }];
        return gray;
    }
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 信息
    if (indexPath.section == 0) {
        
        YKPersonalHomePageInforCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPersonalHomePageInforCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        cell.nameLabel.text = @"这里是名字";
        [cell.focusBtn setBackgroundImage:[UIImage imageNamed:@"个人主页关注"] forState:UIControlStateNormal];
        [cell.focusBtn addTarget:self action:@selector(focusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        return cell;
        
    // 关于
    }else if (indexPath.section == 1) {
        
        YKPersonalHomePageAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPersonalHomePageAboutCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell.labelBtn setTitle:@"13" forState:UIControlStateNormal];
        [cell.postBtn setTitle:@"34" forState:UIControlStateNormal];
        [cell.focuserBtn setTitle:@"1234" forState:UIControlStateNormal];
        
        // 添加点击方法
        [cell.labelBtn addTarget:self action:@selector(labelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.postBtn addTarget:self action:@selector(postBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.focuserBtn addTarget:self action:@selector(focuserBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
     
    // 专业领域
    }else if (indexPath.section == 2) {
    
        YKPersonalHomePageProfessionFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPersonalHomePageProfessionFieldCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        // 创建标签
        NSArray *arr = @[@"运动运动",@"运动康复动",@"运动康复运动",@"运动康复运运动动"];
        [cell creatLabelWithArray:arr];

        
        
        return cell;
    
    // 个人简介
    }else if (indexPath.section == 3) {
        
        YKPersonalHomePagePersonContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPersonalHomePagePersonContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.introduceLabel.text = @"活泼开朗，施针小能手上班可恶化额人扔简介接纳街简介待定带地的方法活泼开朗，施针小能手上班可恶化额人扔简介接纳街简介待定带地的方法活泼开朗，施针小能手上班可恶化额人扔简介接纳街简介待定带";
        self.middleContentStr = cell.introduceLabel.text;
        
        // 调整字体行间距
        [YKUpdateWordSpace updateLineSpaceWithLabel:cell.introduceLabel];
        // 自适应内容高度
        CGFloat contentH = [YKPersonalHomePagePersonContentCell heightForIntroduceLabel:cell.introduceLabel.text];
        [cell.introduceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(contentH );
        }];
        
        
        return cell;
    
    // 最新动态
    }else {
        
        YKPersonalHomePageDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPersonalHomePageDynamicCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        cell.nameLabel.text = @"专业人ID";
        cell.titleLabel.text = @"我的韧带撕裂，如何康复才能";
        
        
        return cell;
        
    }
    
    
}




#pragma mark  ----  关注  -----
-(void)focusBtnAction:(UIButton *)sender
{
    if (sender.selected) {
        
        [sender setBackgroundImage:[UIImage imageNamed:@"个人主页关注"] forState:UIControlStateNormal];
    }else {
        
        [sender setBackgroundImage:[UIImage imageNamed:@"个人主页取消关注"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
    
}


#pragma mark  ----  添加点击事件  -----
-(void)labelBtnAction
{
    // 标签
    YKPersonalHomePageLabelVC *VC = [[YKPersonalHomePageLabelVC alloc] init];
    VC.title = @"专业人员ID关注的标签";
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)postBtnAction
{
    // 帖子
    YKPersonalHomePagePostVC *VC = [[YKPersonalHomePagePostVC alloc] init];
    VC.title = @"专业人员ID的帖子";
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)focuserBtnAction
{
    // 关注者
    YKPersonalHomePageFocuserVC *VC = [[YKPersonalHomePageFocuserVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

//
//  YKMyVC.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyVC.h"  // 当前界面
#import "YKMyInforCell.h"
#import "YKOrdinaryCell.h"
#import "YKProfessionalHeadCell.h" //


#import "YKSetUpVC.h"  // 其他界面
#import "YKBasicInformationVC.h"
#import "YKPersonalHomePagePostVC.h"  //我的帖子
#import "YKMyProfessionalVC.h"
#import "YKMyQuestionVC.h"
#import "YKMyAnswerVC.h"
#import "YKMyFocusVC.h"
#import "YKMyPatientVC.h"
#import "YKMyActivityVC.h"
#import "YKIdentityCertifiedVC.h"


@interface YKMyVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKMyVC



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // 设置按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(setUpAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    // 初始化tableView
    [self initTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"MyActivityVCBackToCommunityVC"]) {
        
        // 置为初始值
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"MyActivityVCBackToCommunityVC"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.tabBarController.selectedIndex = 1;
    }
}


#pragma mark  ----  设置  ----
-(void)setUpAction
{
    YKSetUpVC *VC = [[YKSetUpVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
#warning  ----------------------------
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"renzhengguole"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = YKGlobalBg;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKMyInforCell class] forCellReuseIdentifier:@"YKMyInforCell"];
    [self.tableView registerClass:[YKOrdinaryCell class] forCellReuseIdentifier:@"YKOrdinaryCell"];
    [self.tableView registerClass:[YKProfessionalHeadCell class] forCellReuseIdentifier:@"YKProfessionalHeadCell"];
    
}


#pragma mark  -----  tableView代理方法  ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 普通用户
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"renzhengguole"]) {
        
        return 4;
        
    // 专业人员
    }else {
        
        return 3;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 普通用户
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"renzhengguole"]) {
        
        if (section == 0) {
            return 1;
        }else if (section == 1) {
            return 3;
        }else if (section == 2) {
            return 2;
        }else {
            return 1;
        }
        
    // 专业人员
    }else {

        if (section == 0) {
            return 1;
        }else if (section == 1) {
            return 4;
        }else {
            return 2;
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90 * WScale;
    }
    return 45 * WScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10 * WScale;
    }
    return 0.1 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 普通用户
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"renzhengguole"]) {
        
        if (indexPath.section == 0) {
            
            YKMyInforCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMyInforCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
            cell.boolOnlineLabel.text = @"登录/注册";
            
            
            
            
            return cell;
            
        }else {
            
            YKOrdinaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKOrdinaryCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            NSArray *imageArr1 = @[@"我的帖子（正常状态）",@"我的问题（正常状态）",@"我的关注（正常状态）"];
            NSArray *imageArr2 = @[@"参与活动（正常状态）",@"邀请（正常状态）"];
            NSArray *imageArr3 = @[@"身份认证（点击状态）"];
            NSArray *allImageArr = @[imageArr1,imageArr2,imageArr3];
            cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",allImageArr[indexPath.section - 1][indexPath.row]]];
            NSArray *titleArr1 = @[@"我的帖子",@"我的问题",@"我的关注"];
            NSArray *titleArr2 = @[@"我的活动",@"邀请好友"];
            NSArray *titleArr3 = @[@"身份认证"];
            NSArray *allTitleArr = @[titleArr1,titleArr2,titleArr3];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",allTitleArr[indexPath.section - 1][indexPath.row]];
            if ([cell.titleLabel.text isEqualToString:@"身份认证"]) {
                cell.titleLabel.textColor = YKf24b4b;
                cell.subTitleLabel.text = @"专业人员可在此认证身份，获取身份特权";
            }
            
            
            
            return cell;
        }
     
    // 专业人员
    }else {
        
        if (indexPath.section == 0) {
            
            YKProfessionalHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKProfessionalHeadCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
            cell.nameLabel.text = @"这里是名字";
            cell.typeImageView.image = [UIImage imageNamed:@"康-"];
            cell.positionLabel.text = @"护士";
            
            // 自适应nameLabel宽度
            CGFloat nameW = [YKProfessionalHeadCell widthForNameLabel:cell.nameLabel.text];
            [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(nameW + 2);
            }];
            
            
            
            return cell;
            
            
        }else {
            
            YKOrdinaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKOrdinaryCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            NSArray *imageArr1 = @[@"我的帖子（正常状态）",@"我的专业内容（正常状态）",@"我的回答（正常状态）",@"我的患者（正常状态）"];
            NSArray *imageArr2 = @[@"参与活动（正常状态）",@"邀请（正常状态）"];
            NSArray *allImageArr = @[imageArr1,imageArr2];
            cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",allImageArr[indexPath.section - 1][indexPath.row]]];
            NSArray *titleArr1 = @[@"我的帖子",@"我的专业内容",@"我的回答",@"我的患者"];
            NSArray *titleArr2 = @[@"我的活动",@"邀请好友"];
            NSArray *allTitleArr = @[titleArr1,titleArr2];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",allTitleArr[indexPath.section - 1][indexPath.row]];
            if ([cell.titleLabel.text isEqualToString:@"邀请好友"]) {
                cell.titleLabel.textColor = YK515151;
                cell.subTitleLabel.text = @"";
            }
            
            
            
            
            return cell;
        }
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 普通用户
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"renzhengguole"]) {
        
        if (indexPath.section == 0) {
            
            // 基本信息
            YKBasicInformationVC *VC = [[YKBasicInformationVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 0) {
            
            // 我的帖子
            YKPersonalHomePagePostVC *VC = [[YKPersonalHomePagePostVC alloc] init];
            VC.title = @"我的帖子";
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 1) {
            
            // 我的问题
            YKMyQuestionVC *VC = [[YKMyQuestionVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 2) {
            
            // 我的关注
            YKMyFocusVC *VC = [[YKMyFocusVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 2 && indexPath.row == 0) {
            
            // 我的活动
            YKMyActivityVC *VC = [[YKMyActivityVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 2 && indexPath.row == 1) {
            
            // 邀请好友
            
        }else if (indexPath.section == 3 && indexPath.row == 0) {
            
             //身份认证
            YKIdentityCertifiedVC *VC = [[YKIdentityCertifiedVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    
    // 专业人员
    }else {
        
        if (indexPath.section == 0) {
            
            // 基本信息
            YKBasicInformationVC *VC = [[YKBasicInformationVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 0) {
            
            // 我的帖子
            YKPersonalHomePagePostVC *VC = [[YKPersonalHomePagePostVC alloc] init];
            VC.title = @"我的帖子";
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 1) {
            
            // 我的专业内容
            YKMyProfessionalVC *VC = [[YKMyProfessionalVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 2) {
            
            // 我的回答
            YKMyAnswerVC *VC = [[YKMyAnswerVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 3) {
            
            // 我的患者
            YKMyPatientVC *VC = [[YKMyPatientVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 2 && indexPath.row == 0) {
            
            // 我的活动
            YKMyActivityVC *VC = [[YKMyActivityVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 2 && indexPath.row == 1) {
            
            // 邀请好友

        }
    }
    
    
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end

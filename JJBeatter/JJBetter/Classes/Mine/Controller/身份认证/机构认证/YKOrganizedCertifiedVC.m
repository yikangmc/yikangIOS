//
//  YKOrganizedCertifiedVC.m
//  JJBetter
//
//  Created by yikang on 16/5/16.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKOrganizedCertifiedVC.h"  // 当前界面
#import "YKAllAboutOrdinaryCell.h"
#import "YKAllAboutOrdinaryNoMarkCell.h"
#import "YKAllAboutOrdinaryBtnCell.h"

#import "YKNameVC.h"  // 其他界面
#import "YKHospitalVC.h"
#import "YKIntroduceVC.h"
#import "YKAddressVC.h"
#import "YKGoodAtVC.h"
#import "YKCertifiedVC.h"

#import "YKGoodAtModel.h"  // model


@interface YKOrganizedCertifiedVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

/** 擅长数据 */
@property (nonatomic,strong)NSMutableArray *allGoodAtArr;
/** 擅长title */
@property (nonatomic,strong)NSMutableArray *allTitleArray;


@end

@implementation YKOrganizedCertifiedVC


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(OrganizedCertifiedBackToUp:)];
    
    // 初始化tableView
    [self initTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, 0, 0);
    
    // 请求擅长数据
    [self requestGoodAtData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
    
}


#pragma mark  ----  返回  -----
-(void)OrganizedCertifiedBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = YKGlobalBg;
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerClass:[YKAllAboutOrdinaryCell class] forCellReuseIdentifier:@"YKAllAboutOrdinaryCell"];
    [self.tableView registerClass:[YKAllAboutOrdinaryNoMarkCell class] forCellReuseIdentifier:@"YKAllAboutOrdinaryNoMarkCell"];
    [self.tableView registerClass:[YKAllAboutOrdinaryBtnCell class] forCellReuseIdentifier:@"YKAllAboutOrdinaryBtnCell"];
    
}


#pragma mark  -----  tableView代理方法  ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 100 * WScale;
    }
    return 45 * WScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 50 * WScale;
    }
    return 10 * WScale;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        
        UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50 * WScale)];
        gray.backgroundColor = YKGlobalBg;
        return gray;
    }
    
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
        
        YKAllAboutOrdinaryBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAllAboutOrdinaryBtnCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.applyCertifiedBtn addTarget:self action:@selector(applyCertifiedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
        
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        
        
        if ([self.title isEqualToString:@"机构主体认证"]) {
            
            YKAllAboutOrdinaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAllAboutOrdinaryCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.titleLabel.text = @"机构简介";
            
            return cell;
            
        }else if ([self.title isEqualToString:@"医院/科室主体认证"]) {
            
            YKAllAboutOrdinaryNoMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAllAboutOrdinaryNoMarkCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleLabel.text = @"所在科室";
            cell.inforLabel.text = @"康复科";
            
            
            return cell;
        }
        
    }else {
        
        
        if ([self.title isEqualToString:@"机构主体认证"]) {
            
            YKAllAboutOrdinaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAllAboutOrdinaryCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            NSArray *titleArr1 = @[@"机构名称",@"机构简介",@"机构地址"];
            NSArray *titleArr2 = @[@"擅长方向",@"执业证书"];
            NSArray *allTitleArr = @[titleArr1,titleArr2];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",allTitleArr[indexPath.section][indexPath.row]];
            
            
            
            return cell;
            
        }else if ([self.title isEqualToString:@"医院/科室主体认证"]) {
            
            
            YKAllAboutOrdinaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAllAboutOrdinaryCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            NSArray *titleArr1 = @[@"所在医院",@"所在科室",@"医院地址"];
            NSArray *titleArr2 = @[@"擅长方向",@"执业证书"];
            NSArray *allTitleArr = @[titleArr1,titleArr2];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",allTitleArr[indexPath.section][indexPath.row]];
            
            
            
            return cell;

            
        }
        
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 机构主体认证
    if ([self.title isEqualToString:@"机构主体认证"]) {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            
            // 机构简介
            YKNameVC *VC = [[YKNameVC alloc] init];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            VC.title = @"机构名称";
            VC.placeholderStr = @"填写您的机构名称";
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 0 && indexPath.row == 1) {
            
            // 机构简介
            YKIntroduceVC *VC = [[YKIntroduceVC alloc] init];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            VC.title = @"机构简介";
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 0 && indexPath.row == 2) {
            
            // 机构地址
            YKAddressVC *VC = [[YKAddressVC alloc] init];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            VC.title = @"机构地址";
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 0) {
            
            // 擅长方向
            YKGoodAtVC *VC = [[YKGoodAtVC alloc] init];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            VC.title = @"擅长方向";
            VC.promptStr = @"请选择自己的擅长方向，最多只能选四项";
            VC.allGoodAtArr = [NSArray arrayWithArray:self.allGoodAtArr];
            VC.allGoodAtTitleArr = [NSArray arrayWithArray:self.allTitleArray];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 1) {
            
            // 执业证书
            YKCertifiedVC *VC = [[YKCertifiedVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    // 医院/科室主体认证
    }else if ([self.title isEqualToString:@"医院/科室主体认证"]) {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            
            // 所在医院
            YKHospitalVC *VC = [[YKHospitalVC alloc] init];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 0 && indexPath.row == 1) {
            // 无点击
        }else if (indexPath.section == 0 && indexPath.row == 2) {
            
            // 医院地址
            YKAddressVC *VC = [[YKAddressVC alloc] init];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            VC.title = @"医院地址";
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 0) {
            
            // 擅长方向
            YKGoodAtVC *VC = [[YKGoodAtVC alloc] init];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            VC.title = @"擅长方向";
            VC.promptStr = @"请选择自己的擅长方向，最多只能选四项";
            VC.allGoodAtArr = [NSArray arrayWithArray:self.allGoodAtArr];
            VC.allGoodAtTitleArr = [NSArray arrayWithArray:self.allTitleArray];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.section == 1 && indexPath.row == 1) {
            
            // 执业证书
            YKCertifiedVC *VC = [[YKCertifiedVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    }
    
    
    
}


#pragma mark  ----  申请认证  -----
-(void)applyCertifiedBtn:(UIButton *)sender
{
    NSLog(@"申请认证");
}



#pragma mark  ----  请求擅长数据  -----
// 请求擅长数据
-(void)requestGoodAtData
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userPosition"] = @1;
    
    paramDic[@"paramData"] = dic;
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
    paramDic[@"machineCode"] = [YKUUID getUUID];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@00-23-01", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            
            NSArray *arr = json[@"data"];
            self.allGoodAtArr = [NSMutableArray array];
            self.allTitleArray = [NSMutableArray array];
            
            for (NSDictionary *dic in arr) {
                YKGoodAtModel *model = [[YKGoodAtModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.allGoodAtArr addObject:model];
                [self.allTitleArray addObject:model.adeptName];
            }
        } else {
            [MBProgressHUD showError:json[@"message"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络故障,请重新登录" toView:self.view];
    }];
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end

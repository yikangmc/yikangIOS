//
//  YKNoHospitalRecoveryCertifiedVC.m
//  JJBetter
//
//  Created by yikang on 16/5/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKNoHospitalRecoveryCertifiedVC.h"  // 当前界面
#import "YKAllAboutOrdinaryCell.h"
#import "YKAllAboutOrdinaryNoMarkCell.h"
#import "YKAllAboutOrdinaryBtnCell.h"

#import "YKPickerView.h"  // 其他界面
#import "YKIntroduceVC.h"
#import "YKAddressVC.h"
#import "YKGoodAtVC.h"
#import "YKCertifiedVC.h"

#import "YKGoodAtModel.h"  // model


@interface YKNoHospitalRecoveryCertifiedVC ()<UITableViewDataSource,UITableViewDelegate,YKPickerViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

/** 下拉框 */
@property (nonatomic, strong)YKPickerView *pickerView;
/** pickerView出来时，后面灰灰的一层 */
@property (nonatomic, strong) UIView *blackView;
/** 擅长数据 */
@property (nonatomic,strong)NSMutableArray *allGoodAtArr;
/** 擅长title */
@property (nonatomic,strong)NSMutableArray *allTitleArray;


@end

@implementation YKNoHospitalRecoveryCertifiedVC


#pragma mark  ----  懒加载  -------
- (YKPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[YKPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, YKPickerViewHeight)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (UIView *)blackView {
    if (_blackView == nil) {
        _blackView = [[UIView alloc] initWithFrame:self.view.bounds];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0;
        _blackView.userInteractionEnabled = YES;
    }
    return _blackView;
}


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(NoHospitalRecoveryCertifiedBackToUp:)];
    
    // 初始化tableView
    [self initTableView];
    
    // 添加pickerView
    [self.view addSubview:self.blackView];
    [self.view addSubview:self.pickerView];
    
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
-(void)NoHospitalRecoveryCertifiedBackToUp:(UIBarButtonItem *)sender
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
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return 100 * WScale;
    }
    return 45 * WScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
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
    
    if (indexPath.section == 3) {
        
        YKAllAboutOrdinaryBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAllAboutOrdinaryBtnCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.applyCertifiedBtn addTarget:self action:@selector(applyCertifiedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
        
    }else if (indexPath.section == 0 && indexPath.row == 0) {
        
        YKAllAboutOrdinaryNoMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAllAboutOrdinaryNoMarkCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = @"职位";
        if ([self.title isEqualToString:@"非医院康复师认证"]) {
            cell.inforLabel.text = @"康复师";
        }else if ([self.title isEqualToString:@"中医师认证"]) {
            cell.inforLabel.text = @"中医师";
        }else if ([self.title isEqualToString:@"护士认证"]) {
            cell.inforLabel.text = @"护士";
        }
        
        
        return cell;
        
    }else {
        
        YKAllAboutOrdinaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKAllAboutOrdinaryCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        NSArray *titleArr1 = @[@"",@"性别",@"个人简介"];
        NSArray *titleArr2 = @[@"常驻地址",@"擅长方向"];
        NSArray *titleArr3 = @[@"执业证书"];
        NSArray *allTitleArr = @[titleArr1,titleArr2,titleArr3];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",allTitleArr[indexPath.section][indexPath.row]];
        
        
        
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        // 显示选择框
        self.pickerView.dataArr = @[@"男",@"女"];
        [self pickerViewAppear];
        
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        
        // 个人简介
        YKIntroduceVC *VC = [[YKIntroduceVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        VC.title = @"个人简介";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        
        // 常驻地址
        YKAddressVC *VC = [[YKAddressVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        VC.title = @"常驻地址";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        
        // 擅长方向
        YKGoodAtVC *VC = [[YKGoodAtVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        VC.title = @"擅长方向";
        VC.promptStr = @"请选择自己的擅长方向，最多只能选四项";
        VC.allGoodAtArr = [NSArray arrayWithArray:self.allGoodAtArr];
        VC.allGoodAtTitleArr = [NSArray arrayWithArray:self.allTitleArray];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
        // 执业证书
        YKCertifiedVC *VC = [[YKCertifiedVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


#pragma mark  ----  申请认证  -----
-(void)applyCertifiedBtn:(UIButton *)sender
{
    NSLog(@"申请认证");
}


#pragma mark --------- pickerViewDelegate --------------
- (void)pickerViewDoneSelectorRow:(NSInteger)row title:(NSString *)title
{
    [self pickerViewDisappear];
    
    // 赋值性别
    YKAllAboutOrdinaryCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.inforLabel.text = title;
    
}
- (void)pickerViewCancel
{
    [self pickerViewDisappear];
}
- (void)pickerViewDisappear
{
    [UIView animateWithDuration:0.2 animations:^{
        self.blackView.alpha = 0;
        self.pickerView.y = self.view.height;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)pickerViewAppear
{
    [UIView animateWithDuration:0.2 animations:^{
        self.blackView.alpha = 0.5;
        self.pickerView.y = self.view.height-YKPickerViewHeight;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self pickerViewCancel];
    
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

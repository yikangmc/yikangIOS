//
//  YKBasicInformationVC.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKBasicInformationVC.h"  // 当前界面
#import "YKBasicInforHeadCell.h"
#import "YKBasicInforWordCell.h"

#import "YKNameVC.h"  // 其他界面
#import "YKGoodAtVC.h"
#import "YKPickerView.h"
#import "PickerChoiceView.h"
#import "YKAddressVC.h"

#import "YKGoodAtModel.h"  // model

@interface YKBasicInformationVC ()<UITableViewDataSource,UITableViewDelegate,YKPickerViewDelegate,TFPickerDelegate>

@property (nonatomic,strong)UITableView *tableView;

/** 番号数据 */
@property (nonatomic,strong)NSMutableArray *allGoodAtArr;
/** 番号title */
@property (nonatomic,strong)NSMutableArray *allTitleArray;

/** 下拉框 */
@property (nonatomic, strong)YKPickerView *pickerView;
/** pickerView出来时，后面灰灰的一层 */
@property (nonatomic, strong) UIView *blackView;


@end

@implementation YKBasicInformationVC


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

    self.title = @"基本信息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(BasicInformationBackToUp:)];
    
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
    
    // 请求番号数据
    [self requestGoodAtData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
    
}


#pragma mark  ----  返回  -----
-(void)BasicInformationBackToUp:(UIBarButtonItem *)sender
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
    [self.tableView registerClass:[YKBasicInforHeadCell class] forCellReuseIdentifier:@"YKBasicInforHeadCell"];
    [self.tableView registerClass:[YKBasicInforWordCell class] forCellReuseIdentifier:@"YKBasicInforWordCell"];
    
}


#pragma mark  -----  tableView代理方法  ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100 * WScale;
    }
    return 45 * WScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        YKBasicInforHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKBasicInforHeadCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        
        
        return cell;
        
        
    }else {
        
        YKBasicInforWordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKBasicInforWordCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        NSArray *titleArr1 = @[@"昵称",@"我的番号"];
        NSArray *titleArr2 = @[@"生日",@"性别",@"地址"];
        NSArray *allTitleArr = @[titleArr1,titleArr2];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",allTitleArr[indexPath.section - 1][indexPath.row]];
        
        
        
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
        NSLog(@"头像");
        
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        
        // 昵称
        YKNameVC *VC = [[YKNameVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        VC.title = @"昵称";
        VC.placeholderStr = @"请输入您的昵称";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        
        // 我的番号
        YKGoodAtVC *VC = [[YKGoodAtVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        VC.title = @"我的番号";
        VC.promptStr = @"选择属于自己的番号特征";
        VC.allGoodAtArr = [NSArray arrayWithArray:self.allGoodAtArr];
        VC.allGoodAtTitleArr = [NSArray arrayWithArray:self.allTitleArray];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
        // 生日
        PickerChoiceView *picker = [[PickerChoiceView alloc] initWithFrame:self.view.bounds];
        picker.arrayType = DeteArray;
        picker.delegate = self;
        [self.view addSubview:picker];
        
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        
        // 性别
        // 显示选择框
        self.pickerView.dataArr = @[@"男",@"女"];
        [self pickerViewAppear];
        
    }else if (indexPath.section == 2 && indexPath.row == 2) {
        
        // 地址
        YKAddressVC *VC = [[YKAddressVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        VC.title = @"地址";
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}





#pragma mark --------- pickerViewDelegate --------------
- (void)pickerViewDoneSelectorRow:(NSInteger)row title:(NSString *)title
{
    [self pickerViewDisappear];
    
    // 赋值性别
    YKBasicInforWordCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
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
        self.pickerView.y = self.view.height - YKPickerViewHeight;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self pickerViewCancel];
    
}


#pragma mark  ----  TFPickerDelegate  ------
- (void)PickerSelectorIndixString:(NSString *)str
{
    // 赋值生日
    YKBasicInforWordCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    cell.inforLabel.text = str;
    
}




#pragma mark  ----  请求番号（擅长）数据  -----
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

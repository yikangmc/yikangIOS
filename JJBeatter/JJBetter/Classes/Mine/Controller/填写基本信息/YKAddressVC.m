//
//  AddressViewController.m
//  YouthFountain
//
//  Created by 马文帅 on 15/6/29.
//  Copyright (c) 2015年 yikang. All rights reserved.
//

#import "YKAddressVC.h"
//#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "YKAddressTableViewCell.h"

@interface YKAddressVC ()<UITableViewDataSource, UITableViewDelegate, AMapSearchDelegate,UITextFieldDelegate>
{
    AMapSearchAPI *_search;
    AMapInputTipsSearchRequest *_tipsRequest;
}
//输入粗略位置的框
@property (strong, nonatomic) UITextField *roughTextField;
//输入详细位置的框
@property (strong, nonatomic) UITextField *detailTextField;
//显示提示信息的table
@property (strong, nonatomic) UITableView *tableView;
//"未找到相关地址"的label
@property (strong, nonatomic) UILabel *remindLabel;
//数据源，存储高德返回的提示信息
@property (strong, nonatomic) NSMutableArray *dataArr;
//高德地图返回的区域编码
@property (nonatomic, strong) NSString *adcode;

@end

@implementation YKAddressVC


#pragma mark  ----  viewDidLoad  ----
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(nameBackToUp:)];
    
    // 保存按钮
    [self initRightSaveBtn];

    [self setupUI];
    [self setupAmapSearchAPI];
    
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

// 返回
-(void)nameBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---------  保存  ------------
-(void)initRightSaveBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 40, 20);
    btn.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:YK23149252Color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addressSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
// 保存按钮
-(void)addressSaveBtn
{
    if (!self.roughTextField.text.length || !self.detailTextField.text.length) {
        [UIAlertTool AlertWithViewController:self withMessage:@"地址不完整"];
        return;
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstOrRe"]) {
        NSString *string = [NSString stringWithFormat:@"%@ %@",self.roughTextField.text,self.detailTextField.text];
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"address"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        // 保存到服务器
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        NSString *string = [NSString stringWithFormat:@"%@ %@",self.roughTextField.text,self.detailTextField.text];
        dataDic[@"addressDetail"] = string;
        
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        paramDic[@"paramData"] = dataDic;
        paramDic[@"appId"] = @"10000";
        paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
        paramDic[@"machineCode"] = [YKUUID getUUID];
        NSString *urlStr = [NSString stringWithFormat:@"%@00-17-12", URLSTR];
        
        [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
            
            if ([json[@"status"] isEqualToString:@"000000"]) {
                
                [MBProgressHUD showSuccess:@"提交成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            } else {
                
                [MBProgressHUD showError:json[@"message"] toView:self.view];
            }
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
        }];
    }
    
    
}


#pragma mark  -------  初始化搜索与布局视图  ----------
- (void)setupAmapSearchAPI
{
    //初始化检索对象
    [AMapSearchServices sharedServices].apiKey = AMapSearchKey;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    //构造AMapInputTipsSearchRequest对象，keywords为必选项，city为可选项
    _tipsRequest= [[AMapInputTipsSearchRequest alloc] init];
//    _tipsRequest.searchType = AMapSearchType_InputTips;
    _tipsRequest.city = @"北京";
}

- (void)setupUI
{
    //布局大体位置的textfield
    self.roughTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 50 * WScale)];
    self.roughTextField.placeholder = @"搜索地址（如小区，街道）";
    [self.roughTextField setValue:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    self.roughTextField.returnKeyType = UIReturnKeyDone;
    self.roughTextField.backgroundColor = [UIColor whiteColor];
    self.roughTextField.font = [UIFont systemFontOfSize:15 * WScale];
    self.roughTextField.delegate = self;
    self.roughTextField.leftViewMode = UITextFieldViewModeAlways;
    self.roughTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * WScale, 0)];
    [self.view addSubview:self.roughTextField];
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (10 * ScreenH / 667 + 50 * ScreenH / 667) * ScreenH / 667, ScreenW, 1)];
//    lineView.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.1];
//    [self.view addSubview:lineView];
    
    //布局详细位置的textfield
    self.detailTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 10 * WScale + 50 * WScale + 1, ScreenW, 50 * WScale)];
    self.detailTextField.placeholder = @"请输入详细位置（如单元，门牌号）";
    [self.detailTextField setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    self.detailTextField.returnKeyType = UIReturnKeyDone;
    self.detailTextField.backgroundColor = [UIColor whiteColor];
    self.detailTextField.font = [UIFont systemFontOfSize:14 * WScale];
    self.detailTextField.hidden = YES;
    self.detailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.detailTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 * WScale, 0)];
    [self.view addSubview:self.detailTextField];
    
    //布局“未找到相关地址”
    self.remindLabel.hidden = YES;
    [self.view addSubview:self.remindLabel];
    [self.remindLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.roughTextField withOffset:10.f];
    [self.remindLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10.f * WScale];
    [self.remindLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10.f * WScale];
    [self.remindLabel autoSetDimension:ALDimensionHeight toSize:44.0 * WScale];
    
    //布局tableview
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.roughTextField withOffset:5.0 * WScale];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length == 0) {
        [self.tableView reloadData];
    }
    _tipsRequest.keywords = textField.text;
    //发起输入提示搜索
    [_search AMapInputTipsSearch: _tipsRequest];
    return YES;
}

//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    //通过AMapInputTipsSearchResponse对象处理搜索结果
    if (response.tips.count == 0) {
        self.remindLabel.hidden = NO;
        self.tableView.hidden = YES;
        self.detailTextField.hidden = YES;
        return;
    }
//    for (AMapTip *tip in response.tips) {
//        NSLog(@"%@ %@ %@", tip.district, tip.name, tip.adcode);
//    }
    self.tableView.hidden = NO;
    self.dataArr = [response.tips mutableCopy];
    [self.tableView reloadData];
}


#pragma mark --------  tableViewDelegate  ---------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50 * WScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKAddressTableViewCell *cell = [YKAddressTableViewCell cellInitWithTable:tableView];
    if (![self.dataArr[0] respondsToSelector:@selector(length)]) {
        
        AMapTip *tip = self.dataArr[indexPath.row];
        [cell refreshWithTitle:tip.name subTitle:tip.district];
        
    } else {
        
        [cell refreshWithTitle:self.dataArr[indexPath.row] subTitle:nil];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapTip *tip = self.dataArr[indexPath.row];
    self.roughTextField.text = tip.name;
    self.adcode = tip.adcode;
    self.detailTextField.hidden = NO;
    self.tableView.hidden = YES;
    self.remindLabel.hidden = YES;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

#pragma mark  --------  lazy loading  ----------
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.text = @"未搜到相关地址";
        _remindLabel.textColor = [UIColor grayColor];
    }
    return _remindLabel;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}






@end

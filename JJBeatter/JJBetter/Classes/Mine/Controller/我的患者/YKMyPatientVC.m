//
//  YKMyPatientVC.m
//  JJBetter
//
//  Created by yikang on 16/4/3.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyPatientVC.h"
#import "YKMyPatientView.h"
#import "YKTwoLabelImageView.h"
#import "YKMyPatientCell.h"
#import "YKMyPatientModel.h"

@interface YKMyPatientVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)YKMyPatientView *myPatientView;
@property (nonatomic,strong)UITableView *tableView;
/** 存放已注册患者 */
@property (nonatomic,strong)NSMutableArray *allRegisterArr;
/** 存放已付款患者 */
@property (nonatomic,strong)NSMutableArray *allPayMoneyArr;
/** 显示在tableView的数组 */
@property (nonatomic,strong)NSArray *allTableViewDataArr;
/** 没有数据显示的界面 */
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *lable;


@end

@implementation YKMyPatientVC

#pragma mark  ------  lazyLoading  -------
-(NSMutableArray *)allRegisterArr
{
    if (!_allRegisterArr) {
        _allRegisterArr = [NSMutableArray array];
    }
    return _allRegisterArr;
}
-(NSMutableArray *)allPayMoneyArr
{
    if (!_allPayMoneyArr) {
        _allPayMoneyArr = [NSMutableArray array];
    }
    return _allPayMoneyArr;
}


#pragma mark  ------  viewDidLoad  --------
-(void)loadView
{
    self.myPatientView = [[YKMyPatientView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.myPatientView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"我的患者";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(patientBackToUp:)];
    
    // 布局tableView
    [self layoutTableView];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"YKMyPatientCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YKMyPatientCell"];

    // 添加手势
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapAction:)];
    [self.myPatientView.leftView addGestureRecognizer:leftTap];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapAction:)];
    [self.myPatientView.rightView addGestureRecognizer:rightTap];
    
    // 设置没有数据显示的界面
    self.imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error_image"]];
    self.imageView.frame = CGRectMake(0, 0, 110 * WScale, 143 * WScale);
    self.imageView.hidden = YES;
    self.imageView.center = CGPointMake(ScreenW / 2, self.tableView.frame.size.height / 2 );
    [self.tableView addSubview:self.imageView];
    
    self.lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 60)];
    self.lable.center = CGPointMake(ScreenW / 2 , CGRectGetMaxY(self.imageView.frame) );
    self.lable.hidden = YES;
    self.lable.textAlignment = NSTextAlignmentCenter;
    self.lable.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
    self.lable.font = [UIFont systemFontOfSize:14 * WScale];
    self.lable.text = @"您暂时还没有患者哦~";
    [self.tableView addSubview:self.lable];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, 0, 0);
    
    // 请求我的患者数据
    [self requestMyPatientData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
    
}


#pragma mark  ----  返回  -----
-(void)patientBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  ----  请求我的患者数据  -----
-(void)requestMyPatientData
{
    // 解析已注册患者
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userStatus"] = @0; // 注册
    
    paramDic[@"paramData"] = dic;
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
    paramDic[@"machineCode"] = [YKUUID getUUID];
    NSString *urlStr = [NSString stringWithFormat:@"%@00-01-04", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            
            for (NSDictionary *dic in json[@"data"]) {
                YKMyPatientModel *model = [[YKMyPatientModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.allRegisterArr addObject:model];
            }
            // 解析已付款患者
            NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"userStatus"] = @1; // 付款
            
            paramDic[@"paramData"] = dic;
            paramDic[@"appId"] = @"10000";
            paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
            paramDic[@"machineCode"] = [YKUUID getUUID];
            NSString *urlStr = [NSString stringWithFormat:@"%@00-01-04", URLSTR];
            
            [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
                
                if ([json[@"status"] isEqualToString:@"000000"]) {
                    
                    for (NSDictionary *dic in json[@"data"]) {
                        YKMyPatientModel *model = [[YKMyPatientModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.allPayMoneyArr addObject:model];
                    }
                    

//                    self.myPatientView.centerView.numberLabel.text = [NSString stringWithFormat:@"%ld",self.allRegisterArr.count+self.allPayMoneyArr.count];
//                    self.myPatientView.leftView.numberLabel.text = [NSString stringWithFormat:@"%ld",self.allRegisterArr.count];
//                    self.myPatientView.rightView.numberLabel.text = [NSString stringWithFormat:@"%ld",self.allPayMoneyArr.count];
//                    self.allTableViewDataArr = [NSArray arrayWithArray:self.allRegisterArr];
                    
                }else {
                    
                }
            } failure:^(NSError *error) {
                
                [MBProgressHUD showError:@"加载个人信息失败" toView:self.view];
            }];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"加载个人信息失败" toView:self.view];
    }];
    
    self.myPatientView.centerView.numberLabel.text = [NSString stringWithFormat:@"%ld",self.allRegisterArr.count+self.allPayMoneyArr.count];
    self.myPatientView.leftView.numberLabel.text = [NSString stringWithFormat:@"%ld",self.allRegisterArr.count];
    self.myPatientView.rightView.numberLabel.text = [NSString stringWithFormat:@"%ld",self.allPayMoneyArr.count];
    self.allTableViewDataArr = [NSArray arrayWithArray:self.allRegisterArr];
    
    if (self.allTableViewDataArr.count == 0) {
        self.imageView.hidden = NO;
        self.lable.hidden = NO;
    }else {
        self.imageView.hidden = YES;
        self.lable.hidden = YES;
    }
    
}


#pragma mark  -----  布局tableView  --------
-(void)layoutTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myPatientView.twoView.frame) , ScreenW, ScreenH - CGRectGetMaxY(self.myPatientView.twoView.frame) - 64 ) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.myPatientView addSubview:self.tableView];
    
}


#pragma mark -------  tableView代理方法 -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allTableViewDataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKMyPatientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMyPatientCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (cell != nil) {
        
    }
    // 赋值
    YKMyPatientModel *model =  self.allTableViewDataArr[indexPath.row];
    [cell setCellWithPatientModel:model];
    
    
    return cell;
    
}


#pragma mark ----- 界面切换 --------
-(void)leftTapAction:(UITapGestureRecognizer *)sender
{
    self.myPatientView.leftImageView.hidden = NO;
    self.myPatientView.rightImageView.hidden = YES;
    self.myPatientView.leftView.numberLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.myPatientView.rightView.numberLabel.textColor = [UIColor colorWithRed:254/255.0 green:254/255.0 blue:254/255.0 alpha:1.0];
    self.allTableViewDataArr = [NSArray arrayWithArray:self.allRegisterArr];
    if (self.allTableViewDataArr.count == 0) {
        self.imageView.hidden = NO;
        self.lable.hidden = NO;
    }else {
        self.imageView.hidden = YES;
        self.lable.hidden = YES;
    }
    [self.tableView reloadData];
    
}
-(void)rightTapAction:(UITapGestureRecognizer *)sender
{
    self.myPatientView.leftImageView.hidden = YES;
    self.myPatientView.rightImageView.hidden = NO;
    self.myPatientView.leftView.numberLabel.textColor = [UIColor colorWithRed:254/255.0 green:254/255.0 blue:254/255.0 alpha:1.0];
    self.myPatientView.rightView.numberLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.allTableViewDataArr = [NSArray arrayWithArray:self.allPayMoneyArr];
    if (self.allTableViewDataArr.count == 0) {
        self.imageView.hidden = NO;
        self.lable.hidden = NO;
    }else {
        self.imageView.hidden = YES;
        self.lable.hidden = YES;
    }
    [self.tableView reloadData];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end

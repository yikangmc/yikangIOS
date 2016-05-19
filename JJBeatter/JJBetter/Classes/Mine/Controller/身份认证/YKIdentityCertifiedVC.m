//
//  YKIdentityCertifiedVC.m
//  JJBetter
//
//  Created by yikang on 16/5/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKIdentityCertifiedVC.h"  // 当前界面
#import "YKIdentityCertifiedCell.h"
#import "YKIdentityCertifiedBCell.h"
#import "YKIdentityCertifiedNextStepCell.h"
#import "YKTwoChangeOneView.h"

#import "YKProtocolVC.h"  // 其他界面
#import "YKRecoveryCertifiedVC.h"
#import "YKNoHospitalRecoveryCertifiedVC.h"
#import "YKOrganizedCertifiedVC.h"


@interface YKIdentityCertifiedVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSString *tagSelectedString;  // 记录选择的职位


@end

@implementation YKIdentityCertifiedVC



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"身份认证";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(IdentityCertifiedBackToUp:)];
    
    // 初始化tableView
    [self initTableView];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tagSelectedString = @"";
    [self clearAction];
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
-(void)IdentityCertifiedBackToUp:(UIBarButtonItem *)sender
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKIdentityCertifiedCell class] forCellReuseIdentifier:@"YKIdentityCertifiedCell"];
    [self.tableView registerClass:[YKIdentityCertifiedBCell class] forCellReuseIdentifier:@"YKIdentityCertifiedBCell"];
    [self.tableView registerClass:[YKIdentityCertifiedNextStepCell class] forCellReuseIdentifier:@"YKIdentityCertifiedNextStepCell"];
    
}


#pragma mark  -----  tableView代理方法  ------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 195 * WScale;
    }
    return 190 * WScale;
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
        
        YKIdentityCertifiedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKIdentityCertifiedCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        // 添加点击事件
        [cell.certifiedMoreBtn addTarget:self action:@selector(personalCertifiedMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        cell.leftTwoChangeOneView.customBtn.tag = 50;
        cell.centerTwoChangeOneView.customBtn.tag = 51;
        cell.rightTwoChangeOneView.customBtn.tag = 52;
        [cell.leftTwoChangeOneView.customBtn addTarget:self action:@selector(kangCertified:) forControlEvents:UIControlEventTouchUpInside];
        [cell.centerTwoChangeOneView.customBtn addTarget:self action:@selector(zhongCertified:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightTwoChangeOneView.customBtn addTarget:self action:@selector(huCertified:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
        
        
    }else if (indexPath.section == 1) {
        
        YKIdentityCertifiedBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKIdentityCertifiedBCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 添加点击事件
        [cell.certifiedMoreBtn addTarget:self action:@selector(organizationCertifiedMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        cell.leftTwoChangeOneView.customBtn.tag = 53;
        cell.rightTwoChangeOneView.customBtn.tag = 54;
        [cell.leftTwoChangeOneView.customBtn addTarget:self action:@selector(qiyeCertified:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightTwoChangeOneView.customBtn addTarget:self action:@selector(yiyuanCertified:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
        
    }else{
        
        YKIdentityCertifiedNextStepCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKIdentityCertifiedNextStepCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.nextStepBtn addTarget:self action:@selector(identityCertifiedNextStep:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
}


#pragma mark  ----  认证说明  -----
-(void)personalCertifiedMoreBtn
{
    YKProtocolVC *VC = [[YKProtocolVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];

}
-(void)organizationCertifiedMoreBtn
{
    YKProtocolVC *VC = [[YKProtocolVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 清空
-(void)clearAction
{
    UIButton *btn1 = [self.view viewWithTag:50];
    UIButton *btn2 = [self.view viewWithTag:51];
    UIButton *btn3 = [self.view viewWithTag:52];
    UIButton *btn4 = [self.view viewWithTag:53];
    UIButton *btn5 = [self.view viewWithTag:54];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"身份认证康"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"身份认证中"] forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"身份认证护"] forState:UIControlStateNormal];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"身份认证企"] forState:UIControlStateNormal];
    [btn5 setBackgroundImage:[UIImage imageNamed:@"身份认证院"] forState:UIControlStateNormal];
    btn1.superview.backgroundColor = [UIColor whiteColor];
    btn2.superview.backgroundColor = [UIColor whiteColor];
    btn3.superview.backgroundColor = [UIColor whiteColor];
    btn4.superview.backgroundColor = [UIColor whiteColor];
    btn5.superview.backgroundColor = [UIColor whiteColor];
    
}


#pragma mark  ----  职业选择  -----
-(void)kangCertified:(UIButton *)sender
{
    [self clearAction];

    self.tagSelectedString = @"康";
    sender.superview.backgroundColor = YKf7fcfe;
    [sender setBackgroundImage:[UIImage imageNamed:@"身份认证康-点击"] forState:UIControlStateNormal];
}

-(void)zhongCertified:(UIButton *)sender
{
    [self clearAction];

    self.tagSelectedString = @"中";
    sender.superview.backgroundColor = YKf7fcfe;
    [sender setBackgroundImage:[UIImage imageNamed:@"身份认证中-点击"] forState:UIControlStateNormal];
}

-(void)huCertified:(UIButton *)sender
{
    [self clearAction];

    self.tagSelectedString = @"护";
    sender.superview.backgroundColor = YKf7fcfe;
    [sender setBackgroundImage:[UIImage imageNamed:@"身份认证护-点击"] forState:UIControlStateNormal];
}

-(void)qiyeCertified:(UIButton *)sender
{
    [self clearAction];

    self.tagSelectedString = @"企";
    sender.superview.backgroundColor = YKf7fcfe;
    [sender setBackgroundImage:[UIImage imageNamed:@"身份认证企-点击"] forState:UIControlStateNormal];
}

-(void)yiyuanCertified:(UIButton *)sender
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"该项认证暂只支持康复科室的医院/科室主体认证，其他科室的认证暂不会通过哦~" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"继续去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self clearAction];
        self.tagSelectedString = @"院";
        sender.superview.backgroundColor = YKf7fcfe;
        [sender setBackgroundImage:[UIImage imageNamed:@"身份认证院-点击"] forState:UIControlStateNormal];
        
    }];
    
    
    // 自定义提示信息 颜色 字体
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"该项认证暂只支持康复科室的医院/科室主体认证，其他科室的认证暂不会通过哦~"];
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:YK505050 range:NSMakeRange(0, 37)];
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15 * WScale] range:NSMakeRange(0, 37)];
    [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    //修改按钮
    [action1 setValue:YK0faadd forKey:@"titleTextColor"];
    [action2 setValue:YK0faadd forKey:@"titleTextColor"];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
    
}




#pragma mark  ----  下一步  -----
-(void)identityCertifiedNextStep:(UIButton *)sender
{
    if ([self.tagSelectedString isEqualToString:@""]) {
        [UIAlertTool AlertWithViewController:self withMessage:@"请选择职业"];
        
#warning  ----------------------------
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"renzhengguole"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return;
    }
    
    if ([self.tagSelectedString isEqualToString:@"康"]) {
        
        YKRecoveryCertifiedVC *VC = [[YKRecoveryCertifiedVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([self.tagSelectedString isEqualToString:@"中"]) {
        
        YKNoHospitalRecoveryCertifiedVC *VC = [[YKNoHospitalRecoveryCertifiedVC alloc] init];
        VC.title = @"中医师认证";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([self.tagSelectedString isEqualToString:@"护"]) {
        
        YKNoHospitalRecoveryCertifiedVC *VC = [[YKNoHospitalRecoveryCertifiedVC alloc] init];
        VC.title = @"护士认证";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([self.tagSelectedString isEqualToString:@"企"]) {
        
        YKOrganizedCertifiedVC *VC = [[YKOrganizedCertifiedVC alloc] init];
        VC.title = @"机构主体认证";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([self.tagSelectedString isEqualToString:@"院"]) {
        
        YKOrganizedCertifiedVC *VC = [[YKOrganizedCertifiedVC alloc] init];
        VC.title = @"医院/科室主体认证";
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

//
//  YKSetUpVC.m
//  JJBetter
//
//  Created by yikang on 16/5/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKSetUpVC.h"
#import "YKSetUpCell.h"

@interface YKSetUpVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKSetUpVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(setupBackToUp:)];
    
    
    // 当前软件的版本号（从info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//    self.versionLabel.text = [NSString stringWithFormat:@"V%@",currentVersion];
    
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
-(void)setupBackToUp:(UIBarButtonItem *)sender
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
    [self.tableView registerClass:[YKSetUpCell class] forCellReuseIdentifier:@"YKSetUpCell"];

    
}


#pragma mark  -----  tableView代理方法  ------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10 * WScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKSetUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKSetUpCell"];
    
    
    
    return cell;
}



#pragma mark ----  点击cell  ------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/hu-li-jia-yi-hu-duan/id1089475512?mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }else if (indexPath.section == 1) {
        
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"finishToMineForAutoLogin"]) {
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"finishToMineForAutoLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
//            UIWindow *window  = [UIApplication sharedApplication].keyWindow;
//            YKLoginVC *VC = [[YKLoginVC alloc] init];
//            YKNavigationController *NC = [[YKNavigationController alloc] initWithRootViewController:VC];
//            window.rootViewController = NC;
        }
        // 退出 取消自动登录
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"autoLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end

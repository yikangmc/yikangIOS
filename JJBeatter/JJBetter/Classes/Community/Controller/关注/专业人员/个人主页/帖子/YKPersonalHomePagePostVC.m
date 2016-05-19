
//
//  YKPersonalHomePagePostVC.m
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPersonalHomePagePostVC.h"  // 当前界面
#import "YKPersonalHomePagePostImgCell.h"
#import "YKPersonalHomePagePostNoImgCell.h"

#import "YKLabelPostDetailVC.h"  // 其他界面


@interface YKPersonalHomePagePostVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YKPersonalHomePagePostVC


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(PersonalHomePageLabelBackToUp:)];
    
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
-(void)PersonalHomePageLabelBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark  ---  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [self.tableView registerClass:[YKPersonalHomePagePostImgCell class] forCellReuseIdentifier:@"YKPersonalHomePagePostImgCell"];
    [self.tableView registerClass:[YKPersonalHomePagePostNoImgCell class] forCellReuseIdentifier:@"YKPersonalHomePagePostNoImgCell"];
    
}


#pragma mark  ----  tableView代理方法  -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        return 260 * WScale;
        
    }else {
        return 172 * WScale;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row % 2 == 0) {
        
        YKPersonalHomePagePostImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPersonalHomePagePostImgCell"];
        
        
        
        cell.timeLabel.text = @"2016-04-06";
        cell.contentLabel.text = @"清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已早已儿早已早已儿早已早样样李"; // 101个字
        cell.commentLabel.text = @"999999";
        cell.likeLabel.text = @"999999";
        if (cell.contentLabel.text.length > 100) {
            NSString *str = [cell.contentLabel.text substringToIndex:100];
            cell.contentLabel.text = [str stringByAppendingString:@"..."];
        }else {
            cell.moreContentBtn.hidden = YES;
        }
        // 创建标签
        NSArray *arr = @[@"运动康复瘦身",@"运动康复瘦身",@"运动康复瘦身",@"运动康复瘦身"];
        [cell creatLabelWithArray:arr];
        
        
        // 调整字行距
        [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
        // 点击事件：更多，喜欢
        [cell.moreContentBtn addTarget:self action:@selector(personalHomePagePostMore:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeBtn addTarget:self action:@selector(personalHomePagePostLike:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
        
    }else {
        
        YKPersonalHomePagePostNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPersonalHomePagePostNoImgCell"];
        
        
        
        cell.timeLabel.text = @"2016-04-06";
        cell.contentLabel.text = @"清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已在树上清晨，不知何处的鸟儿早已早已儿早已早已儿早已早样样李"; // 101个字
        cell.commentLabel.text = @"999999";
        cell.likeLabel.text = @"999999";
        if (cell.contentLabel.text.length > 100) {
            NSString *str = [cell.contentLabel.text substringToIndex:100];
            cell.contentLabel.text = [str stringByAppendingString:@"..."];
        }else {
            cell.moreContentBtn.hidden = YES;
        }
        // 创建标签
        NSArray *arr = @[@"运动康复瘦身",@"运动康复瘦身",@"运动康复瘦身",@"运动康复瘦身"];
        [cell creatLabelWithArray:arr];
        
        
        // 调整字行距
        [YKUpdateWordSpace updateLineSpaceWithLabel:cell.contentLabel];
        // 点击事件：更多，喜欢
        [cell.moreContentBtn addTarget:self action:@selector(personalHomePagePostMore:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeBtn addTarget:self action:@selector(personalHomePagePostLike:) forControlEvents:UIControlEventTouchUpInside];

        
        
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    YKLabelPostDetailVC *VC = [[YKLabelPostDetailVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}



#pragma mark  ----  更多，喜欢 -----
-(void)personalHomePagePostMore:(UIButton *)sender
{
    YKLabelPostDetailVC *VC = [[YKLabelPostDetailVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)personalHomePagePostLike:(UIButton *)sender
{
    NSLog(@"喜欢");
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}







@end

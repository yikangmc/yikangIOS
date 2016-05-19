//
//  YKActivityApplyVC.m
//  JJBetter
//
//  Created by yikang on 16/5/9.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKActivityApplyVC.h"  // 当前界面
#import "YKActivityIntroduceCell.h"
#import "YKPayAmountCell.h"
#import "YKPayMethodCell.h"

#import "YKApplySucceedVC.h"  // 报名成功


@interface YKActivityApplyVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIButton *confirmPayBtn;  // 确认支付

@property (nonatomic,copy)NSString *recordPayMethod;

@property (nonatomic,copy)NSString *middleTitleStr;
@property (nonatomic,copy)NSString *middleAddressStr;


@end

@implementation YKActivityApplyVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"活动报名";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(ActivityApplyBackToUp:)];
    
    // 布局确认支付按钮
    [self layoutConfirmPayBtn];
    
    // 初始化tableView
    [self initTableView];
    

    
}



#pragma mark  ----  返回  -----
-(void)ActivityApplyBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ----  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.confirmPayBtn.mas_top);
    }];
    
    // 注册cell
    [self.tableView registerClass:[YKActivityIntroduceCell class] forCellReuseIdentifier:@"YKActivityIntroduceCell"];
    [self.tableView registerClass:[YKPayAmountCell class] forCellReuseIdentifier:@"YKPayAmountCell"];
    [self.tableView registerClass:[YKPayMethodCell class] forCellReuseIdentifier:@"YKPayMethodCell"];
    
}


#pragma mark  ----  tableView代理方法  -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CGSize size = CGSizeMake(230 * WScale, 0);
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15 * WScale]};
        CGRect rect = [self.middleTitleStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        
        CGSize size1 = CGSizeMake(300 * WScale, 0);
        NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
        CGRect rect1 = [self.middleAddressStr boundingRectWithSize:size1 options:NSStringDrawingUsesLineFragmentOrigin attributes:dic1 context:nil];
        return rect.size.height + rect1.size.height + 120 * WScale;
        
    }else if (indexPath.section == 1) {
        
        return 71 * WScale;
        
    }
    return 100 * WScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 47 * WScale;
    }else {
        return 10 * WScale;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {

        UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 47 * WScale)];
        gray.backgroundColor = YKGlobalBg;

        UIView *white = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 36 * WScale)];
        white.backgroundColor = [UIColor whiteColor];
        [gray addSubview:white];

        UILabel *label = [[UILabel alloc] init];
        label.textColor = YK656565;
        label.text = @"支付方式";
        label.font = [UIFont systemFontOfSize:14 * WScale];
        [white addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(white.mas_left).offset(15 * WScale);
            make.centerY.mas_equalTo(white.mas_centerY);
            make.width.mas_equalTo(130 * WScale);
            make.height.mas_equalTo(15 * WScale);
        }];

        return gray;
    }else {
        
        UIView *gray1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
        gray1.backgroundColor = YKGlobalBg;
        return gray1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        YKActivityIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKActivityIntroduceCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.titleLabel.text = @"骨盆矫正公开课第一期开课啦";
        cell.ownerLabel.text = @"康复师周琳（发起）";
        cell.timeLabel.text = @"2016-06-12  12: 23 ~ 2016-06-12  14: 00";
        cell.addressLabel.text = @"北京市朝阳区朝外大街26号朝外MEN写字中心B座2505";
        self.middleTitleStr = cell.titleLabel.text;
        self.middleAddressStr = cell.addressLabel.text;
        
        
        // 自适应titleLabel高度
        CGFloat titleH = [YKActivityIntroduceCell heightForTitleLabel:cell.titleLabel.text];
        [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(titleH + 2);
        }];
        // 自适应addressLabel高度
        CGFloat addressH = [YKActivityIntroduceCell heightForAddressLabel:cell.addressLabel.text];
        [cell.addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(addressH + 2);
        }];
        
        
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        YKPayAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPayAmountCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.payAmountLabel.text = @"¥ 999999K";
        
        
        return cell;
        
    }else if (indexPath.section == 2) {
        
        YKPayMethodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPayMethodCell"];
        
        
        if (indexPath.row == 0) {
            
            cell.payMethodImg.image = [UIImage imageNamed:@"微信支付"];
            cell.payMethodLabel.text = @"微信支付";
            
            
        }else {
            
            cell.payMethodImg.image = [UIImage imageNamed:@"支付宝支付"];
            cell.payMethodLabel.text = @"支付宝支付";
            
        }
        
        cell.payMethodIconImg.image = [UIImage imageNamed:@"支付方式未选中"];
        
        
        
        return cell;
    }
    
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 2) {
        
        NSArray *array = [tableView visibleCells];
        for (UITableViewCell *cell in array) {
            if ([cell isKindOfClass:[YKPayMethodCell class]]) {
                YKPayMethodCell *cell1 = (YKPayMethodCell *)cell;
                cell1.payMethodIconImg.image = [UIImage imageNamed:@"支付方式未选中"];
            }
        }
        YKPayMethodCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.payMethodIconImg.image = [UIImage imageNamed:@"支付方式选中"];
        self.recordPayMethod = cell.payMethodLabel.text;
    }
    
}



#pragma mark  ----  布局确认支付按钮  ------
-(void)layoutConfirmPayBtn
{
    self.confirmPayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.confirmPayBtn.backgroundColor = YK0faadd;
    self.confirmPayBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.confirmPayBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.confirmPayBtn setTitleColor:YKffffff forState:UIControlStateNormal];
    [self.confirmPayBtn addTarget:self action:@selector(confirmPayBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmPayBtn];
    [self.confirmPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(40 * WScale);
    }];
 
}

// 确认支付
-(void)confirmPayBtnAction:(UIButton *)sender
{
//    NSLog(@"--------%@",self.recordPayMethod);
    YKApplySucceedVC *VC = [[YKApplySucceedVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end

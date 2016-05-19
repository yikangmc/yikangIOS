//
//  YKSubActivityDetailVC.m
//  JJBetter
//
//  Created by yikang on 16/5/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKSubActivityDetailVC.h"  // 当前界面
#import "YKActivityTitleCell.h"
#import "YKLabelPostPeopleCell.h"
#import "YKActivityContentCell.h"
#import "YKActivityOwnerCell.h"

#import "YKActivityApplyVC.h"  // 其他界面


@interface YKSubActivityDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSString *middleTitleStr;
@property (nonatomic,copy)NSString *middleAddressStr;

@property (nonatomic,strong)UIButton *applyBtn;  // 报名按钮


@end

@implementation YKSubActivityDetailVC


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // 初始化tableView
    [self initTableView];
    
    // 布局报名按钮
    [self layoutApplyBtn];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    // 显示报名按钮状态
    self.applyBtn.backgroundColor = YK0faadd;  //f6f6f6
    [self.applyBtn setTitle:@"报名" forState:UIControlStateNormal];  //已报名  报名结束
    [self.applyBtn setTitleColor:YKffffff forState:UIControlStateNormal]; //323232 未知
    
}


#pragma mark  ----  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ScreenH - 245 * WScale - 40 * WScale)];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerClass:[YKActivityTitleCell class] forCellReuseIdentifier:@"YKActivityTitleCell"];
    [self.tableView registerClass:[YKLabelPostPeopleCell class] forCellReuseIdentifier:@"YKLabelPostPeopleCell"];
    [self.tableView registerClass:[YKActivityContentCell class] forCellReuseIdentifier:@"YKActivityContentCell"];
    [self.tableView registerClass:[YKActivityOwnerCell class] forCellReuseIdentifier:@"YKActivityOwnerCell"];
    
}


#pragma mark  ----  tableView代理方法  -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    return gray;
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
        return rect.size.height + rect1.size.height + 68 * WScale;

        
    }else if (indexPath.section == 1) {
        
        return 55 * WScale;
        
    }else if (indexPath.section == 2) {
        
        return 100 * WScale;
        
    }else if (indexPath.section == 3) {
        
        return 120 * WScale;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        YKActivityTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKActivityTitleCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.titleLabel.textColor = YK333333;  //999999结束
        cell.titleLabel.text = @"骨盆矫正公开课第一期开课啦骨盆矫正公开课第一期开课啦";
        cell.chargeLabel.textColor = YKe82c2c;  //999999结束
        cell.chargeLabel.text = @"¥ 999999K";
        cell.timeLabel.text = @"04月12日 星期四 12：23";
        cell.addressLabel.text = @"北京市朝阳区朝外大街26号朝外MEN写字中心B座2505";
        cell.endImageView.hidden = NO;
        self.middleTitleStr = cell.titleLabel.text;
        self.middleAddressStr = cell.addressLabel.text;
        
        // 自适应titleLabel高度
        CGFloat titleH = [YKActivityTitleCell heightForTitleLabel:cell.titleLabel.text];
        [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(titleH + 2);
        }];
        // 自适应addressLabel高度
        CGFloat addressH = [YKActivityTitleCell heightForAddressLabel:cell.addressLabel.text];
        [cell.addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(addressH + 2);
        }];

        
        
        return cell;
        
        
    }else if (indexPath.section == 1) {
        
        YKLabelPostPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKLabelPostPeopleCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.getYesLabel.text = @"获4567支持";
        NSArray *arr = @[@"",@"",@"",@"",@"",@"",@""];
        [cell creatImageViewWithArray:arr];
        
        // 将支持数设置为红色
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cell.getYesLabel.text];
        [str addAttribute:NSForegroundColorAttributeName value:YKff2e2e range:NSMakeRange(1 , cell.getYesLabel.text.length - 3)];
        cell.getYesLabel.attributedText = str;
        
        
        
        return cell;
        
    }else if (indexPath.section == 2) {
    
        YKActivityContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKActivityContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        
        return cell;
        
    }else if (indexPath.section == 3) {
        
        YKActivityOwnerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKActivityOwnerCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        cell.nameLabel.text = @"康复师周琳";
        cell.hostCountLabel.text = @"发起活动12场";
        [cell.focusBtn setBackgroundImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        [cell.focusBtn addTarget:self action:@selector(activityDetailfocusBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }
    
    
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}



#pragma mark  ----  关注  -----
-(void)activityDetailfocusBtn:(UIButton *)sender
{
    if (sender.selected) {
        
        [sender setBackgroundImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        
    }else{
        
        [sender setBackgroundImage:[UIImage imageNamed:@"已关注"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
}


#pragma mark  ----  布局报名按钮  -----
-(void)layoutApplyBtn
{
    self.applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyBtn.frame = CGRectMake(0, ScreenH - 285 * WScale , ScreenW, 40 * WScale);
    self.applyBtn.titleLabel.font = [UIFont systemFontOfSize:16 * WScale];
    [self.applyBtn addTarget:self action:@selector(applyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.applyBtn];

}

// 报名
-(void)applyBtnAction:(UIButton *)sender
{
    YKActivityApplyVC *VC = [[YKActivityApplyVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end

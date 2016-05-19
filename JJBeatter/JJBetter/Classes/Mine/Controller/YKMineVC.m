//
//  YKMineVC.m
//  JJBetter
//
//  Created by 李洋 on 16/3/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMineVC.h"
#import "YKLoginVC.h"
#import "YKAccountTool.h"
#import "YKAccount.h"
#import <MJExtension.h>
#import "YKBrowser.h"
#import "QRCodeGenerator.h"
#import "YKSetUpVC.h"
#import "YKResetDoctorVC.h"
#import "YKResetRecoverVC.h"
#import "YKResetNurseVC.h"


@interface YKMineVC ()

///** 和启动图片一样的图片，此图显示的时候去判断到哪个页面 */
//@property (nonatomic, strong) UIImageView  *bigImageView;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 职位 */
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
/** 邀请码 */
@property (weak, nonatomic) IBOutlet UILabel *invitationCodeLabel;
/** 患者数 */
@property (weak, nonatomic) IBOutlet UILabel *diseaseNumsLabel;
/** 审核中 */
@property (weak, nonatomic) IBOutlet UIImageView *verifyImageView;
/** 职位审核 */
@property (nonatomic,strong)NSNumber *positionAuditStatus;

@property (nonatomic, strong) UIImage *qrImage;


@end

@implementation YKMineVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle: style]) {
        self = [[UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil] instantiateInitialViewController];
    }
    return self;
}


#pragma mark  --------  ViewDidLoad -----------
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = YKGlobalBg;
    self.navigationItem.title = @"我的";
    self.headerImageView.layer.cornerRadius = 35;
    
    
    // 设置按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(setUpAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    //监测网络
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//                
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                [UIAlertTool AlertWithViewController:self withMessage:@"当前网络状态没有连接"];
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                
//                break;
//            default:
//                break;
//        }
//    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    // 在进入本页面时，先把老的用户信息填上
    [self setUserInfo];
    
}


#pragma mark --------- 在进入本页面时，先把老的用户信息填上 -------
- (void)setUserInfo
{
    // 获取个人信息
    [[HandleInformation sharedDataHandle] getMyInforWithBlock:^(NSString *isSuccess) {
        
        if ([isSuccess isEqualToString:@"加载个人信息成功"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                YKAccount *model = [[YKAccount alloc] initWithDict:[HandleInformation sharedDataHandle].MyInformationDic];
                [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"defaultUserHeader"]];
                self.nameLabel.text = model.userName;
                if ([model.userPosition integerValue] == 0) {
                    self.positionLabel.text = @"医生";
                }else if ([model.userPosition integerValue] == 1) {
                    self.positionLabel.text = @"护士";
                }else if ([model.userPosition integerValue] == 2) {
                    self.positionLabel.text = @"康复师";
                }
                self.positionAuditStatus = model.positionAuditStatus;
                [[NSUserDefaults standardUserDefaults] setObject:self.positionLabel.text forKey:@"isWhichPosition"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                self.invitationCodeLabel.text = [NSString stringWithFormat:@"%@",model.invitationCode];
                self.qrImage = [QRCodeGenerator qrImageForString:model.invitationUrl imageSize:90.f]?[QRCodeGenerator qrImageForString:model.invitationUrl imageSize:900.f]:[UIImage imageNamed:@"mine_QRCode"];
                
                // 职位审核
                if ([self.positionAuditStatus integerValue] == 1) {
                    
                    self.verifyImageView.hidden = NO;
                    
                }else if ([self.positionAuditStatus integerValue] == 3) {
                    
                    [UIAlertTool AlertWithViewController:self withMessage:@"很抱歉，您的职位审核未通过！"];
                }
//                NSLog(@"%@",[HandleInformation sharedDataHandle].MyInformationDic);
            });
            
        }else {
            [MBProgressHUD showError:@"加载个人信息失败" toView:self.view];
        }
    }];
    
    // 请求我的患者数据
    [self requestMyPatientData];
    
}
// 请求我的患者数据
-(void)requestMyPatientData
{
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
            
            NSArray *array = json[@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.diseaseNumsLabel.text = [NSString stringWithFormat:@"%ld",array.count];
            });
        }
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark --------  设置  --------
-(void)setUpAction
{
    
    YKSetUpVC *VC = [[YKSetUpVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];

}


//- (void)cancelBigView {
//    [UIView animateWithDuration:0.4 animations:^{
//        self.bigImageView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self.bigImageView removeFromSuperview];
//    }];
//}

#pragma mark -------- tableView  ------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
        if ([self.positionLabel.text isEqualToString:@"医生"]) {
            
//            UIStoryboard *board = [UIStoryboard storyboardWithName:@"YKFinishInfor" bundle:[NSBundle mainBundle]];
//            YKResetNurseVC *VC = [board instantiateViewControllerWithIdentifier:@"YKResetNurseVC"];
//            [self.navigationController pushViewController:VC animated:YES];
            UIStoryboard *board = [UIStoryboard storyboardWithName:@"YKFinishInfor" bundle:[NSBundle mainBundle]];
            YKResetDoctorVC *VC = [board instantiateViewControllerWithIdentifier:@"YKResetDoctorVC"];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([self.positionLabel.text isEqualToString:@"护士"]) {
            
            UIStoryboard *board = [UIStoryboard storyboardWithName:@"YKFinishInfor" bundle:[NSBundle mainBundle]];
            YKResetNurseVC *VC = [board instantiateViewControllerWithIdentifier:@"YKResetNurseVC"];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([self.positionLabel.text isEqualToString:@"康复师"]) {
            
            UIStoryboard *board = [UIStoryboard storyboardWithName:@"YKFinishInfor" bundle:[NSBundle mainBundle]];
            YKResetRecoverVC *VC = [board instantiateViewControllerWithIdentifier:@"YKResetRecoverVC"];
            [self.navigationController pushViewController:VC animated:YES];
            
        }

    }else if (indexPath.section == 1 && indexPath.row == 1) {
        
        [YKBrowser showImage:self.qrImage];
        
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
//        YKMyPatientVC *VC = [[YKMyPatientVC alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
}


#pragma mark - lazy loading
//- (UIImageView *)bigImageView {
//    if (!_bigImageView) {
//        _bigImageView = [[UIImageView alloc] init];
//        _bigImageView.image = [UIImage yk_imageForDeviceWithName:@"lauchImage"];
//        _bigImageView.frame = [UIApplication sharedApplication].keyWindow.bounds;
//    }
//    return _bigImageView;
//}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end

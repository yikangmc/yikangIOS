//
//  YKPositionVC.m
//  JJBetter
//
//  Created by yikang on 16/4/2.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPositionVC.h"
#import "YKPickerView.h"


@interface YKPositionVC ()<YKPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

/** 下拉框 */
@property (nonatomic, strong)YKPickerView *pickerView;
/** pickerView出来时，后面灰灰的一层 */
@property (nonatomic, strong) UIView *blackView;
@property(nonatomic,strong)NSArray *arr1;



@end

@implementation YKPositionVC

#pragma mark  ----------  懒加载  -------------
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


#pragma mark  ---------  viewDidLoad  --------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"更改职位";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(positionBackToUp:)];
    
    self.arr1 = @[@"医生",@"护士",@"康复师"];
    self.pickerView.dataArr = [NSMutableArray arrayWithArray:self.arr1];
    
    // 添加pickerView
    [self.view addSubview:self.blackView];
    [self.view addSubview:self.pickerView];
    
    self.positionLabel.text = self.postion;
 
    // 初始化最下方的label
    [self initDownLabel];
    
}


// 初始化最下方的label
-(void)initDownLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 25)];
    label.center = CGPointMake(ScreenW / 2, ScreenH - 100);
    label.text = @"佳佳康复将在您提交申请后的 1-2 个工作日内与您联系";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.tableView addSubview:label];
    
}


// 返回
-(void)positionBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark   点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
     
        [self pickerViewAppear];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 15;
}


#pragma mark    提交申请
- (IBAction)submitApplyAction:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isWhichPosition"] isEqualToString:self.positionLabel.text]) {
        [UIAlertTool AlertWithViewController:self withMessage:@"已经为当前职位"];
        return;
    }
    if ([self.positionLabel.text isEqualToString:@"医生"]) {
        
        [self requestChangePositionWith:@0];
        
    }else if ([self.positionLabel.text isEqualToString:@"护士"]) {
        
        [self requestChangePositionWith:@1];
        
    }else if ([self.positionLabel.text isEqualToString:@"康复师"]) {
        
        [self requestChangePositionWith:@2];
    }
}


#pragma mark --------- pickerViewDelegate --------------
- (void)pickerViewDoneSelectorRow:(NSInteger)row title:(NSString *)title
{
    [self pickerViewDisappear];
    
    self.positionLabel.text = title;
    
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


#pragma mark  网络请求职位修改
-(void)requestChangePositionWith:(NSNumber *)numberPosition
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userPosition"] = numberPosition;
    
    paramDic[@"paramData"] = dic;
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
    paramDic[@"machineCode"] = [YKUUID getUUID];

    NSString *urlStr = [NSString stringWithFormat:@"%@00-17-13", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {

        if ([json[@"status"] isEqualToString:@"000000"]) {
            
            // 修改个人信息的一些参数
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
            dataDic[@"positionAuditStatus"] = @1;

            NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
            paramDic[@"paramData"] = dataDic;
            paramDic[@"appId"] = @"10000";
            paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
            paramDic[@"machineCode"] = [YKUUID getUUID];
            NSString *urlStr = [NSString stringWithFormat:@"%@00-17-12", URLSTR];
            
            [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
                
                if ([json[@"status"] isEqualToString:@"000000"]) {
                    
                    [MBProgressHUD showSuccess:@"提交成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                } else {
                    
                    [MBProgressHUD showError:json[@"message"] toView:self.view];
                }
                
            } failure:^(NSError *error) {
                
                [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
            }];
            
        }else {
            [MBProgressHUD showError:json[@"message"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
      
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end

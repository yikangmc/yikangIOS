//
//  YKResetDoctorVC.m
//  JJBetter
//
//  Created by yikang on 16/4/1.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKResetDoctorVC.h"
#import "YKNameVC.h"
#import "YKPositionVC.h"
#import "YKHospitalVC.h"
#import "YKPickerView.h"

#import "YKAccount.h"


@interface YKResetDoctorVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,YKPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView; // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; // 姓名
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel; // 所在医院
@property (weak, nonatomic) IBOutlet UILabel *officeLabel; // 科室


/** 下拉框 */
@property (nonatomic, strong)YKPickerView *pickerView;
/** pickerView出来时，后面灰灰的一层 */
@property (nonatomic, strong) UIView *blackView;

/** 图片的二进制数据 */
@property (nonatomic, strong) NSData *imageData;
/** 准备上传图片的URL */
@property (nonatomic, strong) NSString *photoUrl;
/** 职位审核 */
@property (nonatomic,strong)NSNumber *positionAuditStatus;



@end

@implementation YKResetDoctorVC


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


#pragma mark  ------------  viewDidLoad --------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"基本信息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(doctorBackToUp:)];
    self.headImageView.layer.cornerRadius = 35;
    
    // 添加pickerView
    [self.view addSubview:self.blackView];
    [self.view addSubview:self.pickerView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    // 在进入本页面时，先把老的用户信息填上
    [self setUserInfo];
    
}


#pragma mark --------- pickerViewDelegate --------------
- (void)pickerViewDoneSelectorRow:(NSInteger)row title:(NSString *)title
{
    [self pickerViewDisappear];
    self.officeLabel.text = title;
    if (![self.officeLabel.text isEqualToString:@"请选择"] && self.officeLabel.text.length) {
        
        // 保存到服务器
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        dataDic[@"offices"] = self.officeLabel.text;
        
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        paramDic[@"paramData"] = dataDic;
        paramDic[@"appId"] = @"10000";
        paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
        paramDic[@"machineCode"] = [YKUUID getUUID];
        NSString *urlStr = [NSString stringWithFormat:@"%@00-17-12", URLSTR];
        
        [MBProgressHUD showMessage:nil toView:self.view];
        [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
            [MBProgressHUD hideHUDForView:self.view];
            
            if ([json[@"status"] isEqualToString:@"000000"]) {
                
                [MBProgressHUD showSuccess:@"提交成功"];
            }
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
        }];
    
        
    }else {
        [UIAlertTool AlertWithViewController:self withMessage:@"保存失败，请重试"];
    }
    
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

// 返回
-(void)doctorBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --------- 在进入本页面时，先把老的用户信息填上 -------
- (void)setUserInfo
{
    // 获取个人信息
    [[HandleInformation sharedDataHandle] getMyInforWithBlock:^(NSString *isSuccess) {
        
        if ([isSuccess isEqualToString:@"加载个人信息成功"]) {
            
            YKAccount *model = [[YKAccount alloc] initWithDict:[HandleInformation sharedDataHandle].MyInformationDic];
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderImage_0"]];
            self.nameLabel.text = model.userName;
            self.hospitalLabel.text = model.hospital;
            self.officeLabel.text = model.offices;
            self.positionAuditStatus = model.positionAuditStatus;
            
            // 职位审核
            if ([self.positionAuditStatus integerValue] == 1) {
                
                UIImageView *view = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                view.backgroundColor = [UIColor clearColor];
                UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
                view.userInteractionEnabled = YES;
                [view addGestureRecognizer:tapGR];
                [self.tableView addSubview:view];
            }
            
        }else {
            [MBProgressHUD showError:@"加载个人信息失败" toView:self.view];
        }
    }];
    
}
-(void)tapGRAction:(UITapGestureRecognizer *)sender
{
    [UIAlertTool AlertWithViewController:self withMessage:@"职位在审核中，无法进行编辑"];
}


#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"选取照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
            
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [controller addAction:action1];
        [controller addAction:action2];
        [controller addAction:action3];
        [self presentViewController:controller animated:YES completion:nil];
        
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        
        YKNameVC *ykNameVC = [[YKNameVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController pushViewController:ykNameVC animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"YKFinishInfor" bundle:[NSBundle mainBundle]];
        YKPositionVC *VC = [board instantiateViewControllerWithIdentifier:@"YKPositionVC"];
        VC.postion = @"医生";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
        YKHospitalVC *ykHospitalVC = [[YKHospitalVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController pushViewController:ykHospitalVC animated:YES];
        
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        
        // 请求科室数据
        [self requestOfficesData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}


#pragma mark ----------  相册选取代理方法   -----------
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    imagePickerController.delegate = self;
    [[imagePickerController navigationBar] setBarTintColor:[UIColor whiteColor]];
    imagePickerController.navigationBar.tintColor = YK1f1f1f;
    imagePickerController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: YK1f1f1f, NSFontAttributeName: [UIFont boldSystemFontOfSize:18]};
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.showsCameraControls = YES;
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    UIImage *littleImage = [image yk_scaleToSize:CGSizeMake(480, 480)];
    UIImage *circleImage = [littleImage yk_circleImageBorderWidth:0.f borderColor:nil];
    self.imageData = UIImageJPEGRepresentation(circleImage, 0.1);
    

    // 提交图片
    if (self.imageData) {
        
        //发送图片
        YKFormData *formData = [[YKFormData alloc] init];
        formData.name = @"files";
        formData.data = self.imageData;
        formData.mimeType = @"image/jpeg";
        formData.filename = @"anyname.jpg";
        NSMutableArray *formDataArray = [NSMutableArray array];
        [formDataArray addObject:formData];
        [self sendPicture:formDataArray];

        
    }else {
        
        [UIAlertTool AlertWithViewController:self withMessage:@"选择失败，请重新选取"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//提交头像
- (void)sendPicture:(NSMutableArray *)formData {
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"fileGroup"] = @"headImage";
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
    paramDic[@"machineCode"] = [YKUUID getUUID];
    
    NSArray *formDataArray = [formData copy];
    
    NSString *urlString = [NSString stringWithFormat:@"%@fileUpload/imageFileUpload", URLSTR_FILE];
    
    [MBProgressHUD showMessage:@"正在提交..." toView:self.view];
    [YKHttpTool postWithURL:urlString params:paramDic formDataArray:formDataArray success:^(id json) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            
            self.photoUrl = json[@"data"][@"fileUrl"];
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.photoUrl]];

            // 保存到服务器
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
            dataDic[@"photoUrl"] = self.photoUrl;
            
            NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
            paramDic[@"paramData"] = dataDic;
            paramDic[@"appId"] = @"10000";
            paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
            paramDic[@"machineCode"] = [YKUUID getUUID];
            NSString *urlStr = [NSString stringWithFormat:@"%@00-17-12", URLSTR];
            
            [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
                
                if ([json[@"status"] isEqualToString:@"000000"]) {
                    
                    [MBProgressHUD showSuccess:@"提交成功"];
                    
                } else {
                    
                    [MBProgressHUD showError:json[@"message"] toView:self.view];
                }
            } failure:^(NSError *error) {
                
            }];
          
        }
        
    } failure:^(NSError *error) {

        [UIAlertTool AlertWithViewController:self withMessage:@"提交失败，请重新选取"];
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark  ---------  请求科室数据  -------
-(void)requestOfficesData
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userPosition"] = @0;
    
    paramDic[@"paramData"] = dic;
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
    paramDic[@"machineCode"] = [YKUUID getUUID];
    NSString *urlStr = [NSString stringWithFormat:@"%@00-24-01", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            
            NSArray *arr = json[@"data"];
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                [array addObject:dic[@"officeName"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // 显示选择框
                self.pickerView.dataArr = [NSMutableArray arrayWithArray:array];
                [self pickerViewAppear];
            });
        }
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"网络故障,请重新登录" toView:self.view];
        });
        
    }];
    
}








@end

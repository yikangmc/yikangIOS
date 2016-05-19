//
//  YKRecoverInfor.m
//  JJBetter
//
//  Created by yikang on 16/3/28.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKRecoverInfor.h"
#import "YKNameVC.h"
#import "YKAddressVC.h"
#import "YKGoodAtVC.h"
#import "YKGoodAtModel.h"
#import "YKPickerView.h"
#import "YKNavigationController.h"
#import "YKMineVC.h"


@interface YKRecoverInfor ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,YKPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView; // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; // 姓名
@property (weak, nonatomic) IBOutlet UILabel *workTypeLabel; // 工作方式
@property (weak, nonatomic) IBOutlet UILabel *addressLabel; // 地址
@property (weak, nonatomic) IBOutlet UILabel *goodAtLabel; // 擅长

/** 下拉框 */
@property (nonatomic, strong)YKPickerView *pickerView;
/** pickerView出来时，后面灰灰的一层 */
@property (nonatomic, strong) UIView *blackView;

/** 图片的二进制数据 */
@property (nonatomic, strong) NSData *imageData;
/** 准备上传图片的URL */
@property (nonatomic, strong) NSString *photoUrl;
@property(nonatomic,strong)NSArray *arr1;
/** 擅长数据 */
@property (nonatomic,strong)NSMutableArray *allGoodAtArr;
/** 擅长title */
@property (nonatomic,strong)NSMutableArray *allTitleArray;
/** 工作类型 */
@property (nonatomic,strong)NSNumber *workType;



@end

@implementation YKRecoverInfor


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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"完善基本信息";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(recoverBackToUp:)];
    self.headImageView.layer.cornerRadius = 35;

    self.arr1 = @[@"兼职",@"全职"];
    self.pickerView.dataArr = [NSMutableArray arrayWithArray:self.arr1];
    
    
    // 添加pickerView
    [self.view addSubview:self.blackView];
    [self.view addSubview:self.pickerView];
    
    
}
// 请求擅长数据
-(void)requestGoodAtData
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userPosition"] = @2;
    
    paramDic[@"paramData"] = dic;
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
    paramDic[@"machineCode"] = [YKUUID getUUID];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@00-23-01", URLSTR];
    
    [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            
            NSArray *arr = json[@"data"];
            self.allGoodAtArr = [NSMutableArray array];
            self.allTitleArray = [NSMutableArray array];
            
            for (NSDictionary *dic in arr) {
                YKGoodAtModel *model = [[YKGoodAtModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.allGoodAtArr addObject:model];
                [self.allTitleArray addObject:model.adeptName];
            }
        } else {
            [MBProgressHUD showError:json[@"message"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络故障,请重新登录" toView:self.view];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    // 请求擅长数据
    [self requestGoodAtData];
    // 界面传值
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    self.addressLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
    self.goodAtLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"GoodAt"];
}


#pragma mark --------- pickerViewDelegate --------------
- (void)pickerViewDoneSelectorRow:(NSInteger)row title:(NSString *)title
{
    [self pickerViewDisappear];
    
    self.workTypeLabel.text = title;
    
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
-(void)recoverBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
        UIActionSheet *getPhotoSheet = [[UIActionSheet alloc] initWithTitle:@"选择头像"delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
        [getPhotoSheet showInView:self.view];
        
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        
        YKNameVC *ykNameVC = [[YKNameVC alloc] init];
        ykNameVC.placeholderStr = @"填写您的名字";
        ykNameVC.title = @"填写名字";
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController pushViewController:ykNameVC animated:YES];
        
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
        [self pickerViewAppear];
        
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        
        YKAddressVC *ykAddressVC = [[YKAddressVC alloc] init];
        ykAddressVC.title = @"填写地址";
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController pushViewController:ykAddressVC animated:YES];
        
    }else if (indexPath.section == 2 && indexPath.row == 2) {
        
        YKGoodAtVC *VC = [[YKGoodAtVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstOrRe"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        VC.allGoodAtArr = [NSArray arrayWithArray:self.allGoodAtArr];
        VC.allGoodAtTitleArr = [NSArray arrayWithArray:self.allTitleArray];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}


#pragma mark - ActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//从相册选取
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    } else  if (buttonIndex != actionSheet.cancelButtonIndex) {//拍照
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
}


#pragma mark ----------  相册选取代理方法   -----------
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    imagePickerController.delegate = self;
    [[imagePickerController navigationBar] setBarTintColor:[UIColor whiteColor]];
    
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
    self.headImageView.image = circleImage;
    self.imageData = UIImageJPEGRepresentation(littleImage, 0.1);

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
        }
        
    } failure:^(NSError *error) {
        
        [UIAlertTool AlertWithViewController:self withMessage:@"选取失败，请重新选取"];
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark  ------  完成  ----------
- (IBAction)recoverFinishBtn:(id)sender
{
    if (![self checkInfomation]) {
        [UIAlertTool AlertWithViewController:self withMessage:@"您的信息不全，请补充"];
        return;
    }
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    dataDic[@"userName"] = self.nameLabel.text;
    dataDic[@"userPosition"] = @2;
    if ([self.workTypeLabel.text isEqualToString:@"兼职"]) {
        self.workType = @0;
    }else if ([self.workTypeLabel.text isEqualToString:@"全职"]) {
        self.workType = @1;
    }
    dataDic[@"jobCategory"] = self.workType;
    dataDic[@"addressDetail"] = self.addressLabel.text;
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"idGoodAt"];
    NSArray *arr = [str componentsSeparatedByString:@","];
    dataDic[@"adepts"] = arr;
    
    dataDic[@"photoUrl"] = self.photoUrl;
    dataDic[@"infoWrite"] = @1;
    
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
            [MBProgressHUD showSuccess:@"保存成功"];
            
            UIWindow *window  = [UIApplication sharedApplication].keyWindow;
            YKMineVC *VC = [[YKMineVC alloc] init];
            YKNavigationController *NC = [[YKNavigationController alloc] initWithRootViewController:VC];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"finishToMineForAutoLogin"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"autoLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            window.rootViewController = NC;
            
        } else {
            
            [MBProgressHUD showError:json[@"message"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
    }];
}

//检查是否都填了
- (BOOL)checkInfomation
{
    
    if (self.imageData && self.nameLabel.text.length && self.workTypeLabel.text.length && self.addressLabel.text.length && self.goodAtLabel.text.length && ![self.workTypeLabel.text isEqualToString:@"请选择"]) {
        return YES;
    }
    return NO;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

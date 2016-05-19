//
//  YKCertifiedVC.m
//  JJBetter
//
//  Created by yikang on 16/5/16.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKCertifiedVC.h"
#import "YKCertifiedView.h"


@interface YKCertifiedVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)YKCertifiedView *rootView;

/** 图片的二进制数据 */
@property (nonatomic, strong) NSData *imageData;
/** 准备上传图片的URL */
@property (nonatomic, strong) NSString *photoUrl;


@end

@implementation YKCertifiedVC


#pragma mark  ----  loadView  -----
-(void)loadView
{
    self.rootView = [[YKCertifiedView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"上传执业证书";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(CertifiedBackToUp:)];
    
    // 保存按钮
    [self initRightSaveBtn];
    
    // 添加点击事件
    [self.rootView.uploadingBtn addTarget:self action:@selector(uploadingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
-(void)CertifiedBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ----  上传执业证书  ----
-(void)uploadingBtnAction:(UIButton *)sender
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"选取照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 相册
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 拍照
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [controller addAction:action1];
    [controller addAction:action2];
    [controller addAction:action3];
    [self presentViewController:controller animated:YES completion:nil];
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

    self.imageData = UIImageJPEGRepresentation(littleImage, 0.1);
    // 赋值
    self.rootView.photoImageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark --------- 保存  ------------
-(void)initRightSaveBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 40, 20);
    btn.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:YK23149252Color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(certifiedSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
// 保存按钮
-(void)certifiedSaveBtn
{
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
        
    }
    
}
// 提交照片
- (void)sendPicture:(NSMutableArray *)formData {
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"fileGroup"] = @"headImage";
    paramDic[@"appId"] = @"10000";
    paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
    paramDic[@"machineCode"] = [YKUUID getUUID];
    
    NSArray *formDataArray = [formData copy];
    NSString *urlString = [NSString stringWithFormat:@"%@fileUpload/imageFileUpload", URLSTR_FILE];
    
    [YKHttpTool postWithURL:urlString params:paramDic formDataArray:formDataArray success:^(id json) {
        
        if ([json[@"status"] isEqualToString:@"000000"]) {
            
            [MBProgressHUD showSuccess:@"选取成功"];
            self.photoUrl = json[@"data"][@"fileUrl"];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"选取失败，请重新选取"];
    }];
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}






@end

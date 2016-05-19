//
//  YKIssueQuestionVC.m
//  JJBetter
//
//  Created by yikang on 16/5/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKIssueQuestionVC.h"
#import "YKIssueQuestionView.h"

#import "PictureViewController.h"

@interface YKIssueQuestionVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)YKIssueQuestionView *ykIssueQuestionView;
@property (nonatomic,strong)PictureViewController *pictureVC;

@property (nonatomic,strong)NSMutableArray *selectedImageArr;  // 存放已添加的照片数组


@end

@implementation YKIssueQuestionVC


#pragma mark  ----  lazyloading  ----
-(NSMutableArray *)selectedImageArr
{
    if (!_selectedImageArr) {
        _selectedImageArr = [NSMutableArray array];
    }
    return _selectedImageArr;
}

#pragma mark  ----  loadView  -----
-(void)loadView
{
    self.ykIssueQuestionView = [[YKIssueQuestionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ykIssueQuestionView;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"发布问题";
    
    // 初始化取消与发布button
    [self initCancelAndIssueBtn];
    
    
    // 布局添加照片
    self.pictureVC = [[PictureViewController alloc] init];
    [self addChildViewController:self.pictureVC];
    self.ykIssueQuestionView.frame = self.pictureVC.view.frame;
    [self.ykIssueQuestionView.whiteBackView addSubview:self.pictureVC.pictureCollectonView];
    
    
    // 显示默认标签
    self.ykIssueQuestionView.defaultLabel.text = @"运动康复康复";
    CGFloat width = [YKIssueQuestionView widthForDefaultLabel:self.ykIssueQuestionView.defaultLabel.text];
    [self.ykIssueQuestionView.defaultLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    
}


#pragma mark  ----  初始化取消与发布button  -----
-(void)initCancelAndIssueBtn
{
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(0, 0, 40, 20);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:YK1f1f1f forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    UIButton *issueBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    issueBtn.frame = CGRectMake(0, 0, 40, 20);
    [issueBtn setTitle:@"发布" forState:UIControlStateNormal];
    [issueBtn setTitleColor:YK0faadd forState:UIControlStateNormal];
    issueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [issueBtn addTarget:self action:@selector(issueBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:issueBtn];
    
    
}


#pragma mark  ----  取消与发布  -----
-(void)cancelBtn:(UIBarButtonItem *)sender
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"确定退出编辑吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [controller addAction:action];
    [controller addAction:action1];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)issueBtn:(UIBarButtonItem *)sender
{
    [self.selectedImageArr removeAllObjects];
    
    for (UIImage *image in self.pictureVC.itemsSectionPictureArray) {
        UIImage *littleImage = [image yk_scaleToSize:CGSizeMake(480 * WScale, 480 * WScale)];
        NSData  *imageData = UIImageJPEGRepresentation(littleImage, 0.1);
        
        // 提交图片
        if (imageData) {
            
            //发送图片
            YKFormData *formData = [[YKFormData alloc] init];
            formData.name = @"files";
            formData.data = imageData;
            formData.mimeType = @"image/jpeg";
            formData.filename = @"anyname.jpg";
            NSMutableArray *formDataArray = [NSMutableArray array];
            [formDataArray addObject:formData];
            [self sendPicture:formDataArray];
            
        }
    }
    
#warning  ------   继续后面操作----------------------------------------------------------------
    [MBProgressHUD showMessage:@"发布中" toView:self.ykIssueQuestionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.ykIssueQuestionView];
        if (self.pictureVC.itemsSectionPictureArray.count == self.selectedImageArr.count) {
            
            [MBProgressHUD showSuccess:@"发布成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else {
            
            [MBProgressHUD showError:@"有图片未上传成功，请重试" toView:self.view];
        }
        
    });
    
}

#pragma mark  ----  提交头像  -----
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
            NSString *photoUrl = json[@"data"][@"fileUrl"];
            
            // 添加照片
            [self.selectedImageArr addObject:photoUrl];
            
        }
        
    } failure:^(NSError *error) {
        
        //        [MBProgressHUD showError:@"照片上传失败，请重试" toView:self.view];
        
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}









@end

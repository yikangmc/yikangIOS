//
//  ViewController.m
//  类似QQ图片添加、图片浏览
//
//  Created by seven on 16/3/30.
//  Copyright © 2016年 QQpicture. All rights reserved.
//

#import "PictureViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PictureCollectionViewCell.h"
#import "PictureAddCell.h"
#import "ELCImagePickerController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/ALAsset.h>


@interface PictureViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MJPhotoBrowserDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign)BOOL isFour;

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.itemsSectionPictureArray = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(60 * HScale, 60 * HScale);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    if (ScreenW < 568) {
        layout.sectionInset = UIEdgeInsetsMake(8 , 10 , 8 ,28);
    }else {
        layout.sectionInset = UIEdgeInsetsMake(15 * HScale, 15 * WScale, 10 * HScale, 10 * WScale);
    }
    
    //创建 UICollectionView
    self.pictureCollectonView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 237 * HScale, self.view.frame.size.width, 80 * HScale) collectionViewLayout:layout];
    self.pictureCollectonView.backgroundColor = [UIColor whiteColor];
    [self.pictureCollectonView registerClass:[PictureCollectionViewCell class]forCellWithReuseIdentifier:@"cell"];
    [self.pictureCollectonView registerClass:[PictureAddCell class] forCellWithReuseIdentifier:@"addItemCell"];
    self.pictureCollectonView.delegate = self;
    self.pictureCollectonView.dataSource = self;
    
    [self.view addSubview:self.pictureCollectonView];
    
    self.isFour = NO;
}


#pragma mark - collectionView 调用方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isFour) {
        return self.itemsSectionPictureArray.count ;
    }else{
        return self.itemsSectionPictureArray.count +1;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == self.itemsSectionPictureArray.count) {

        PictureAddCell *addItemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addItemCell" forIndexPath:indexPath];
        
        if (self.isFour) {
            
            return nil;
        }else{
            
            return addItemCell;
        }
        
    }else
    {

        PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.imageView.image = self.itemsSectionPictureArray[indexPath.row];
        
        return cell;
    }
    
}

//用代理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.itemsSectionPictureArray.count) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"选取照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
            elcPicker.maximumImagesCount = 9 - self.itemsSectionPictureArray.count;
            elcPicker.returnsOriginalImage = YES;
            elcPicker.returnsImage = YES;
            elcPicker.onOrder = NO;
            elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
            elcPicker.imagePickerDelegate = self;
            [self presentViewController:elcPicker animated:YES completion:nil];
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                //设置拍照后的图片可被编辑
                picker.allowsEditing = YES;
                picker.sourceType = sourceType;
                
                picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                
                [self presentViewController:picker animated:YES completion:nil];
            }
            
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [controller addAction:action1];
        [controller addAction:action2];
        [controller addAction:action3];
        [self presentViewController:controller animated:YES completion:nil];
        
    }else {
        
        NSMutableArray *photoArray = [[NSMutableArray alloc] init];
        for (int i = 0;i< self.itemsSectionPictureArray.count; i ++) {
            UIImage *image = self.itemsSectionPictureArray[i];
            
            MJPhoto *photo = [MJPhoto new];
            photo.image = image;
            PictureCollectionViewCell *cell = (PictureCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            photo.srcImageView = cell.imageView;
            [photoArray addObject:photo];
        }
        
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.photoBrowserdelegate = self;
        browser.currentPhotoIndex = indexPath.row;
        browser.photos = photoArray;
        [browser show];
        
    }
}

-(void)deletedPictures:(NSSet *)set
{

    NSMutableArray *cellArray = [NSMutableArray array];
    
    for (NSString *index1 in set) {
        [cellArray addObject:index1];
    }
    
    if (cellArray.count == 0) {
        
    }else if (cellArray.count == 1 && self.itemsSectionPictureArray.count == 1) {
        NSIndexPath *indexPathTwo = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.itemsSectionPictureArray removeObjectAtIndex:indexPathTwo.row];
        [self.pictureCollectonView deleteItemsAtIndexPaths:@[indexPathTwo]];
    }else{
        
        for (int i = 0; i < cellArray.count-1; i++) {
            for (int j = 0; j < cellArray.count-1-i; j++) {
                if ([cellArray[j] intValue] < [cellArray[j+1] intValue]) {
                    NSString *temp = cellArray[j];
                    cellArray[j] = cellArray[j+1];
                    cellArray[j+1] = temp;
                }
            }
        }
        for (int b = 0; b < cellArray.count; b++) {
            int idexx = [cellArray[b] intValue]-1;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idexx inSection:0];
            
            [self.itemsSectionPictureArray removeObjectAtIndex:indexPath.row];
            [self.pictureCollectonView deleteItemsAtIndexPaths:@[indexPath]];
        }
    }
    if (self.itemsSectionPictureArray.count == 4) {
        self.isFour = YES;
    }else {
        self.isFour = NO;
    }
    [self.pictureCollectonView reloadData];

}


#pragma mark - 相册、相机调用方法
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    __weak PictureViewController *weak = self;
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSMutableArray *images = [NSMutableArray array];
        for (NSDictionary *dict in info) {
            if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
                if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                    UIImage* image = [dict objectForKey:UIImagePickerControllerOriginalImage];
                    [images addObject:image];
                }
            }
        }
        [weak.itemsSectionPictureArray addObjectsFromArray:images];
        if (weak.itemsSectionPictureArray.count == 4) {
            weak.isFour = YES;
        }else {
            weak.isFour = NO;
        }
        [weak.pictureCollectonView reloadData];
        [weak.view layoutIfNeeded];
    }];
    
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    __weak PictureViewController *weak = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [weak.itemsSectionPictureArray addObject:image];
        if (weak.itemsSectionPictureArray.count == 4) {
            weak.isFour = YES;
        }else {
            weak.isFour = NO;
        }
        [weak.pictureCollectonView reloadData];
        [weak.view layoutIfNeeded];
    }];
    
}



- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

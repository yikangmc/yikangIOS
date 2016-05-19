//
//  YKEditLabelVC.m
//  JJBetter
//
//  Created by yikang on 16/5/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKEditLabelVC.h"
#import "YKEditLabelSectionView.h"
#import "YKEditLabelSingleCell.h"

@interface YKEditLabelVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imagesSectionOneArray;
@property (nonatomic, strong) NSMutableArray *imagesSectionTwoArray;
@property (nonatomic, strong) NSMutableArray *cellAttributesArray;
@property (nonatomic, assign) CGPoint lastPressPoint;

/**
 * scrollerTimer
 */
@property (nonatomic, strong) NSTimer *scrollerTimer;
@property (nonatomic, assign) CGFloat scrollerValue;
@property (nonatomic, assign) BOOL isCanSort;//是否支持排序功能

//用于判断一、二分区是否有移动动画
@property (nonatomic, assign) BOOL isSorting;
@property (nonatomic, assign) BOOL sectionOneIsSort;
@property (nonatomic, assign) BOOL sectionTwoIsSort;


@end

@implementation YKEditLabelVC


#pragma mark  ----  lazyloading  ----
//- (NSMutableArray *)imagesSectionOneArray{
//    if (!_imagesSectionOneArray) {
//        self.imagesSectionOneArray = [NSMutableArray arrayWithCapacity:0];
//    }
//    return _imagesSectionOneArray;
//}
//
//- (NSMutableArray *)imagesSectionTwoArray{
//    if (!_imagesSectionTwoArray) {
//        self.imagesSectionTwoArray = [NSMutableArray arrayWithCapacity:0];
//    }
//    return _imagesSectionTwoArray;
//}

- (NSMutableArray *)cellAttributesArray{
    if (!_cellAttributesArray) {
        self.cellAttributesArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _cellAttributesArray;
}


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"编辑标签";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(EditLabelBackToUp:)];
    
    
    /// shang wo
#warning 
    self.automaticallyAdjustsScrollViewInsets = NO;
    _lastPressPoint = CGPointZero;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10 * WScale;
    layout.minimumInteritemSpacing = 5 * WScale;
    layout.itemSize = CGSizeMake(80 * WScale, 22 * WScale);
    layout.sectionInset = UIEdgeInsetsMake(15 * WScale, 10 * WScale, 15 * WScale, 10 * WScale);
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = YKGlobalBg;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerClass:[YKEditLabelSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YKEditLabelSectionView"];
    [self.collectionView registerClass:[YKEditLabelSingleCell class] forCellWithReuseIdentifier:@"YKEditLabelSingleCell"];
    
    
    self.imagesSectionOneArray = [NSMutableArray arrayWithObjects:@"脑外伤",@"脑",@"外伤",@"脑外",@"脑外伤外伤",@"脑外外伤伤",@"脑外伤",@"脑",@"外伤",@"脑外", nil];
    self.imagesSectionTwoArray = [NSMutableArray arrayWithObjects:@"神经康复脑外伤",@"神经康",@"神经康伤",@"神经",@"脑神经康复",@"神", nil];
    
    
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
-(void)EditLabelBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark  ----  collectionView代理方法  -----
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.imagesSectionOneArray.count;
    }
    return self.imagesSectionTwoArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenW, 40 * WScale);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YKEditLabelSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YKEditLabelSingleCell" forIndexPath:indexPath];

    cell.hidden = NO;
    if (indexPath.section == 0) {

        cell.cellLabel.text = [NSString stringWithFormat:@"%@",self.imagesSectionOneArray[indexPath.row]];
        if (self.isCanSort) {
            [cell.redMoveBtn setBackgroundImage:[UIImage imageNamed:@"编辑标签删除"] forState:UIControlStateNormal];
        }else {
            [cell.redMoveBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        
        if (_sectionOneIsSort && indexPath.row + 1 == self.imagesSectionOneArray.count) {
            cell.hidden = YES;
        }
        
    }else{

        cell.cellLabel.text = [NSString stringWithFormat:@"%@",self.imagesSectionTwoArray[indexPath.row]];
        [cell.redMoveBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_sectionTwoIsSort && indexPath.row + 1 == self.imagesSectionTwoArray.count) {
            cell.hidden = YES;
        }
    }
    
    for (UIGestureRecognizer *gesture in cell.gestureRecognizers) {
        if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [cell removeGestureRecognizer:gesture];
        }
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    [cell addGestureRecognizer:longPress];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {

        YKEditLabelSectionView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"YKEditLabelSectionView" forIndexPath:indexPath];


        if (indexPath.section == 0) {
            
            reusableView.titleLabel.text = @"我的标签";
            reusableView.subTitleLabel.text = @"";
            if (self.isCanSort) {
                [reusableView.editBtn setTitle:@"完成" forState:UIControlStateNormal];
            }else{
                [reusableView.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
            }

            [reusableView.editBtn addTarget:self action:@selector(editRedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            reusableView.titleLabel.text = @"所有标签";
            reusableView.subTitleLabel.text = @"点击以下标签，加入我的标签";
            [reusableView.editBtn setTitle:@"" forState:UIControlStateNormal];
            
        }
        return reusableView;
    }
    return nil;
}


#pragma mark  ----  红色编辑button事件  ----
-(void)editRedBtnAction:(UIButton *)sender
{
    if ( self.isCanSort) {
        self.isCanSort = NO;
        [sender setTitle:@"编辑" forState:UIControlStateNormal];

    }else {
        self.isCanSort = YES;
        [sender setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    [self.collectionView reloadData];
    sender.selected = !sender.selected;

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isCanSort) {
        [self startMoveClickedCellAtIndexpath:indexPath];
        return;
    }
}


//长按拖动排序
- (void)longPressGesture:(UILongPressGestureRecognizer *)sender
{
    if (!_isCanSort) {
        return;
    }
    YKEditLabelSingleCell *cell = (YKEditLabelSingleCell *)sender.view;
    [self.collectionView bringSubviewToFront:cell];
    NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:cell];
    [self.collectionView bringSubviewToFront:cell];
    BOOL isChanged = NO;
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.lastPressPoint = [sender locationInView:self.collectionView];
    }else if (sender.state == UIGestureRecognizerStateChanged){
        [self.cellAttributesArray removeAllObjects];
        for (int i = 0;i < self.imagesSectionOneArray.count; i++) {
            [self.cellAttributesArray addObject:[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
        }
        for (int i = 0;i < self.imagesSectionTwoArray.count; i++) {
            [self.cellAttributesArray addObject:[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1]]];
        }
        
        [self scrollerCollectionView:[sender locationInView:self.view]];
        cell.center = [sender locationInView:self.collectionView];
        
        for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
            if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexPath != attributes.indexPath) {
                isChanged = YES;
                //对数组中存放的元素重新排序
                if (cellIndexPath.section == attributes.indexPath.section) {
                    if (cellIndexPath.section == 0) {
                        NSString *imageStr = self.imagesSectionOneArray[cellIndexPath.row];
                        [self.imagesSectionOneArray removeObjectAtIndex:cellIndexPath.row];
                        [self.imagesSectionOneArray insertObject:imageStr atIndex:attributes.indexPath.row];
                        
                    }else{
                        NSString *imageStr = self.imagesSectionTwoArray[cellIndexPath.row];
                        [self.imagesSectionTwoArray removeObjectAtIndex:cellIndexPath.row];
                        [self.imagesSectionTwoArray insertObject:imageStr atIndex:attributes.indexPath.row];
                    }
                    [self.collectionView moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
                }else{
                    if (cellIndexPath.section == 0) {//一区移动到二区
                        NSString *imageStr = self.imagesSectionOneArray[cellIndexPath.row];
                        [self.imagesSectionOneArray removeObjectAtIndex:cellIndexPath.row];
                        [self.imagesSectionTwoArray insertObject:imageStr atIndex:attributes.indexPath.row];
                        
                    }else{//二区移动到一区
                        NSString *imageStr = self.imagesSectionTwoArray[cellIndexPath.row];
                        [self.imagesSectionTwoArray removeObjectAtIndex:cellIndexPath.row];
                        [self.imagesSectionOneArray insertObject:imageStr atIndex:attributes.indexPath.row];
                        
                    }
                    [self.collectionView moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
                    
                }
                
                
            }
        }
        
    }else if (sender.state == UIGestureRecognizerStateEnded) {
        if (!isChanged) {
            cell.center = [self.collectionView layoutAttributesForItemAtIndexPath:cellIndexPath].center;
        }
        NSLog(@"排序后---%ld--%ld",self.imagesSectionOneArray.count,self.imagesSectionTwoArray.count);
    }
    
    
}

//点击时排序
- (void)startMoveClickedCellAtIndexpath:(NSIndexPath *)indexPath
{
    if (_isSorting) {
        return;
    }
    _isSorting = YES;
    YKEditLabelSingleCell *movedCell = (YKEditLabelSingleCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *endAttributes = nil;
    NSIndexPath *endIndexPath = nil;
    if (indexPath.section == 0) {
        _sectionOneIsSort = NO;
        _sectionTwoIsSort = YES;
        [self.imagesSectionTwoArray addObject:[self.imagesSectionOneArray objectAtIndex:indexPath.row]];
        endIndexPath = [NSIndexPath indexPathForItem:_imagesSectionTwoArray.count - 1 inSection:1];
        [self.collectionView insertItemsAtIndexPaths:@[endIndexPath]];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }else{
        _sectionOneIsSort = YES;
        _sectionTwoIsSort = NO;
        [self.imagesSectionOneArray addObject:[self.imagesSectionTwoArray objectAtIndex:indexPath.row]];
        endIndexPath = [NSIndexPath indexPathForItem:_imagesSectionOneArray.count - 1 inSection:0];
        [self.collectionView insertItemsAtIndexPaths:@[endIndexPath]];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }
    endAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:endIndexPath];
    YKEditLabelSingleCell __weak *endCell = (YKEditLabelSingleCell *)[self.collectionView cellForItemAtIndexPath:endIndexPath];
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        movedCell.center = endAttributes.center;
    } completion:^(BOOL finished) {
        endCell.hidden = NO;
        movedCell.hidden = YES;
        weakSelf.sectionOneIsSort = NO;
        weakSelf.sectionTwoIsSort = NO;
        if (indexPath.section == 0) {
            [weakSelf.imagesSectionOneArray removeObjectAtIndex:indexPath.row];
            [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }else{
            [weakSelf.imagesSectionTwoArray removeObjectAtIndex:indexPath.row];
            [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            
        }
        weakSelf.isSorting = NO;
    }];
}





//自动滑动collectionView
- (void)scrollerCollectionView:(CGPoint)point
{
    if (point.y <= 10 + 64.0) {
        _scrollerValue = -1.0;
    }else if (point.y >= ScreenH - 20.0){
        _scrollerValue = 1.0;
    }else{
        if (_scrollerTimer) {
            [_scrollerTimer invalidate];
            _scrollerTimer = nil;
        }
        return;
    }
    if (!_scrollerTimer) {
        _scrollerTimer = [NSTimer scheduledTimerWithTimeInterval:0.007 target:self selector:@selector(startScrollerCollectionView) userInfo:nil repeats:YES];
        [_scrollerTimer setFireDate:[NSDate distantPast]];
    }
    
}

- (void)startScrollerCollectionView
{
    CGPoint point = self.collectionView.contentOffset;
    if (point.y + _scrollerValue <= 0 || point.y + _scrollerValue + self.collectionView.bounds.size.height >= self.collectionView.contentSize.height) {
        [_scrollerTimer invalidate];
        _scrollerTimer = nil;
        return;
    }
    point = CGPointMake(point.x, point.y + _scrollerValue);
    self.collectionView.contentOffset = point;
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}







@end

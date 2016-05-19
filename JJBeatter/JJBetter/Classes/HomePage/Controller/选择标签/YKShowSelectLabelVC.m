//
//  YKShowSelectLabelVC.m
//  JJBetter
//
//  Created by yikang on 16/4/27.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKShowSelectLabelVC.h"
#import "YKShowSelectLabelItem.h"
#import "CollectionReusableView.h"


@interface YKShowSelectLabelVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *selectLabelArray;


@end

@implementation YKShowSelectLabelVC


#pragma mark  ----  loadView  ------
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"选择标签";
    
    // 初始化取消与保存button
    [self initCancelAndSaveBtn];
    
    
    // 初始化collectionView
    [self initCollectionView];
    
    
    self.selectLabelArray = [NSMutableArray arrayWithObjects:@"运动康复",@"瘦身",@"动康复",@"运动康复", nil];
}


#pragma mark  ----  初始化取消与保存button  -----
-(void)initCancelAndSaveBtn
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
    [issueBtn setTitle:@"保存" forState:UIControlStateNormal];
    [issueBtn setTitleColor:YK0faadd forState:UIControlStateNormal];
    issueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [issueBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:issueBtn];
    
    
}


#pragma mark  ----  取消与保存  -----
-(void)cancelBtn:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)saveBtn:(UIBarButtonItem *)sender
{
    
    if (self.block) {
        self.block((NSArray *)self.selectLabelArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark  ----  初始化collectionView  -----
-(void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10 * WScale;
    layout.minimumInteritemSpacing = 5 * WScale;
    if (ScreenH < 568) {
        layout.itemSize = CGSizeMake(69 , 18);
    }else{
        layout.itemSize = CGSizeMake(80 * WScale, 22 * HScale);
        
    }
    layout.sectionInset = UIEdgeInsetsMake(15 * HScale, 10 * WScale, 15 * HScale, 10 * WScale);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.collectionView.backgroundColor = YKf6f6f6;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // 注册
    [self.collectionView registerClass:[YKShowSelectLabelItem class] forCellWithReuseIdentifier:@"YKShowSelectLabelItem"];
    [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.width.mas_equalTo(self.view.mas_width);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    

}


#pragma mark  ----  collectionView代理方法  -----
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    YKShowSelectLabelItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"YKShowSelectLabelItem" forIndexPath:indexPath];
    
    [item.labelBtn addTarget:self action:@selector(labelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [item.labelBtn setTitle:[NSString stringWithFormat:@"慢性肠胃炎%ld",indexPath.row] forState:UIControlStateNormal];



    
    return item;
}

// 返回section的view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionReusableView *head = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
    head.imageView.backgroundColor = YKf6f6f6;
    head.label.text = [NSString stringWithFormat:@"运动康复"];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKdcdcdc;
    [head addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(head.mas_top);
        make.left.mas_equalTo(head.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(head.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(1);
    }];
    return head;
    
}

// 返回section的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenW, 35 * HScale);
}


#pragma mark  ----  点击label添加事件  -----
-(void)labelBtnAction:(UIButton *)sender
{

    if (sender.selected) {

        [sender setTitleColor:YK323232 forState:UIControlStateNormal];
        sender.backgroundColor = YKdcdcdc;
        NSLog(@"0");
    }else{
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = YK0faadd;
        NSLog(@"1");

    }
    sender.selected = !sender.selected;
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}








@end

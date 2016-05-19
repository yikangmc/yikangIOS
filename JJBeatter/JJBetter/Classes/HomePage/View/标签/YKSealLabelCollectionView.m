//
//  YKSealLabelCollectionView.m
//  JJBetter
//
//  Created by yikang on 16/4/20.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKSealLabelCollectionView.h"
#import "YKAllLabelItem.h"

#define LCollectionCellMargin 15

static NSString *const cellIdentifier = @"cells";


@interface YKSealLabelCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,strong)UIImageView *bottomView; // 白色箭头


@end

@implementation YKSealLabelCollectionView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self allViews];
    }
    return self;
}


- (void)allViews
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 37 * WScale) collectionViewLayout:flowLayout];
    collection.dataSource = self;
    collection.delegate = self;
    collection.backgroundColor = YKf6f6f6;
    collection.showsHorizontalScrollIndicator = NO;
    collection.showsVerticalScrollIndicator = NO;
    
    [collection registerClass:[YKAllLabelItem class] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:collection];
    self.flowLayout = flowLayout;
    self.collection = collection;
    
    UIImageView *bottomView = [[UIImageView alloc] init];
    bottomView.image = [UIImage imageNamed:@"向上白色箭头"];
    [self.collection addSubview:bottomView];
    self.bottomView = bottomView;
    
    
}

-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
    self.collection.frame = self.bounds;
    self.bottomView.frame = CGRectMake(25 * WScale,  CGRectGetMaxY(self.collection.frame) - 6 * WScale, 15 * WScale, 6 * WScale);
    [self.collection reloadData];
}

- (CGFloat)sizeForTitle:(NSString *)title
{
    return [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]}].width + LCollectionCellMargin;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [self sizeForTitle:self.titles[indexPath.row]];
    return CGSizeMake(width, 37 * WScale);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YKAllLabelItem *cell = (YKAllLabelItem *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setTitleName:self.titles[indexPath.row]];
    
    
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YKAllLabelItem *cell = (YKAllLabelItem *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(YKTitleLabelView:didSelectedItem:)])
    {
        [self.delegate YKTitleLabelView:self didSelectedItem:(int)indexPath.row];
    }
    
    // 字体变化与滑到中间
    NSArray *arr = [self.collection visibleCells];
    for (YKAllLabelItem *itme in arr) {
        itme.titleLabel.textColor = YK656565;
        itme.titleLabel.font = [UIFont systemFontOfSize:13 * WScale];

    }
    cell.titleLabel.textColor = YK0faadd;
    cell.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    // 白色箭头移动
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.x = cell.frame.origin.x + cell.width / 2 - 10;
    }];
    
}







@end

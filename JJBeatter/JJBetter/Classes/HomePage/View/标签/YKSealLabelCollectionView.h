//
//  YKSealLabelCollectionView.h
//  JJBetter
//
//  Created by yikang on 16/4/20.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKSealLabelCollectionView;


@protocol YKLableTitleClickedDelegate <NSObject>

// 回调点击事件
@optional
- (void)YKTitleLabelView:(YKSealLabelCollectionView *)titleLabelView didSelectedItem:(int)index;

@end

@interface YKSealLabelCollectionView : UIView

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) id<YKLableTitleClickedDelegate> delegate;


@end

//
//  YKIdentityCertifiedCell.h
//  JJBetter
//
//  Created by yikang on 16/5/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKTwoChangeOneView;

@interface YKIdentityCertifiedCell : UITableViewCell

@property (nonatomic,strong)YKTwoChangeOneView *leftTwoChangeOneView;
@property (nonatomic,strong)YKTwoChangeOneView *centerTwoChangeOneView;
@property (nonatomic,strong)YKTwoChangeOneView *rightTwoChangeOneView;
@property (nonatomic,strong)UIButton *certifiedMoreBtn;  // 认证说明



@end

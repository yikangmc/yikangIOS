//
//  YKMyPatientView.h
//  JJBetter
//
//  Created by yikang on 16/4/4.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKTwoLabelImageView;

@interface YKMyPatientView : UIView

@property (nonatomic,strong)UIView *twoView;

@property (nonatomic,strong)YKTwoLabelImageView *centerView;
@property (nonatomic,strong)YKTwoLabelImageView *leftView;
@property (nonatomic,strong)YKTwoLabelImageView *rightView;

@property (nonatomic,strong)UIImageView *leftImageView;
@property (nonatomic,strong)UIImageView *rightImageView;




@end

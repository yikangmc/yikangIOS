//
//  YKActivityDetailView.h
//  JJBetter
//
//  Created by yikang on 16/5/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKActivityDetailView : UIView


@property (nonatomic,strong)UIImageView *activityImageView;


/** 分享弹框 */
@property (nonatomic,strong)UIView *grayBackView;  // 后面灰色View
@property (nonatomic,strong)UIView *shareBackView;  // 自定义分享弹框
@property (nonatomic,strong)UIButton *weiboBtn;
@property (nonatomic,strong)UIButton *weixinBtn;
@property (nonatomic,strong)UIButton *weixinCircleBtn;
@property (nonatomic,strong)UIButton *reportBtn;
@property (nonatomic,strong)UIButton *cancleBtn;

/** 分享弹框*/
-(void)creatShareAlertView;




@end

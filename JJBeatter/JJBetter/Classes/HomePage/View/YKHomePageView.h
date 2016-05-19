//
//  YKHomePageView.h
//  JJBetter
//
//  Created by yikang on 16/4/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKHomePageView : UIView

/** 分享弹框 */
@property (nonatomic,strong)UIView *grayBackView;  // 后面灰色View
@property (nonatomic,strong)UIView *shareBackView;  // 自定义分享弹框
@property (nonatomic,strong)UIButton *weiboBtn;
@property (nonatomic,strong)UIButton *weixinBtn;
@property (nonatomic,strong)UIButton *weixinCircleBtn;
@property (nonatomic,strong)UIButton *reportBtn;
@property (nonatomic,strong)UIButton *cancleBtn;


/** 点击搜索的button(透明看不到) */
@property (nonatomic,strong)UIButton *searchBtn;


/** 分享弹框*/
-(void)creatShareAlertView;




@end

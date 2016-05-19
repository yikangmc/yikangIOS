//
//  YKBaseVC.h
//  JJBetter
//
//  Created by 李洋 on 16/3/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKBaseVC : UIViewController

/** 出错的图片 */
@property (nonatomic, strong) UIImageView *errorImageView;
/** 返回为空时的出错label */
@property (nonatomic, strong) UILabel *errorLabel;
/** 是不是没有网络 */
@property (nonatomic, assign) BOOL isError;
/** 返回的数据是不是为空 */
@property (nonatomic, assign) BOOL isNil;
/** 出现错误的时候 子类重写此方法 */
- (void)taped:(UIGestureRecognizer *)tap;
/** 点击手势 */
@property (nonatomic, strong) UITapGestureRecognizer *tap;




@end

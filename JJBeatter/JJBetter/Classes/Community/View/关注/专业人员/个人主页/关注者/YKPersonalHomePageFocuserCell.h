//
//  YKPersonalHomePageFocuserCell.h
//  JJBetter
//
//  Created by yikang on 16/5/16.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKPersonalHomePageFocuserCell : UITableViewCell


@property (nonatomic,strong)UIImageView *headImageView;  // 头像
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标
@property (nonatomic,strong)UIButton *focusBtn;  // 关注

/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;



@end

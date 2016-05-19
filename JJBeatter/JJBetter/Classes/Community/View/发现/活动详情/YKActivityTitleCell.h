//
//  YKActivityTitleCell.h
//  JJBetter
//
//  Created by yikang on 16/5/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKActivityTitleCell : UITableViewCell


@property (nonatomic,strong)UILabel *titleLabel;  // 标题
@property (nonatomic,strong)UILabel *timeLabel;  // 时间
@property (nonatomic,strong)UILabel *addressLabel;  // 地址
@property (nonatomic,strong)UILabel *chargeLabel;  // 价格
@property (nonatomic,strong)UIImageView *endImageView;  // 已结束图标


/** 标题自适应高度 */
+(CGFloat)heightForTitleLabel:(NSString *)titleLabel;


/** 地址自适应高度 */
+(CGFloat)heightForAddressLabel:(NSString *)addressLabel;



@end

//
//  YKActivityIntroduceCell.h
//  JJBetter
//
//  Created by yikang on 16/5/9.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKActivityIntroduceCell : UITableViewCell


@property (nonatomic,strong)UILabel *titleLabel;  // 标题
@property (nonatomic,strong)UILabel *ownerLabel;  // 发布者
@property (nonatomic,strong)UILabel *timeLabel;  // 时间
@property (nonatomic,strong)UILabel *addressLabel;  // 地址


/** 标题自适应高度 */
+(CGFloat)heightForTitleLabel:(NSString *)titleLabel;


/** 地址自适应高度 */
+(CGFloat)heightForAddressLabel:(NSString *)addressLabel;




@end

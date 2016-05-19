//
//  YKMyActivityCell.h
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKMyActivityCell : UITableViewCell

@property (nonatomic,strong)UIImageView *activityImg;  // 活动图片
@property (nonatomic,strong)UILabel *timeLabel;  // 活动时间
@property (nonatomic,strong)UILabel *titleLabel;  // 标题
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标



@end

//
//  YKFocusCollectionCell.h
//  JJBetter
//
//  Created by yikang on 16/5/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKFocusCollectionCell : UITableViewCell


@property (nonatomic,strong)UIImageView *headImageView;  // 头像
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标
@property (nonatomic,strong)UILabel *timeLabel;  // 时间
@property (nonatomic,strong)UIImageView *pictureImageView;  // 图片
@property (nonatomic,strong)UILabel *titleLabel;  // 标题

/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;



@end

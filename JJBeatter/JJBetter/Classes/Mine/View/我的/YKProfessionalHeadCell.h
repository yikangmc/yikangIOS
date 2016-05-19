//
//  YKProfessionalHeadCell.h
//  JJBetter
//
//  Created by yikang on 16/5/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKProfessionalHeadCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headImageView;  // 头像
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标
@property (nonatomic,strong)UILabel *positionLabel;  // 职位

/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;


@end

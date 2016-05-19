//
//  YKMyFocusCell.h
//  JJBetter
//
//  Created by yikang on 16/5/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKMyFocusCell : UITableViewCell

@property (nonatomic,strong)UIImageView *photoImageView;  // 收藏图片
@property (nonatomic,strong)UILabel *titleLabel;  // 收藏标题
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标

/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;



@end

//
//  YKProfessionListCell.h
//  JJBetter
//
//  Created by yikang on 16/5/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKProfessionListCell : UITableViewCell


@property (nonatomic,strong)UIImageView *photoImageView;  // 图片
@property (nonatomic,strong)UILabel *titleLabel;  // 标题
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标
@property (nonatomic,strong)UILabel *contentLabel;  // 内容


/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;




@end

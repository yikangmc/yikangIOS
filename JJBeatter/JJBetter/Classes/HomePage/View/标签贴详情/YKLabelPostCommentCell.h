//
//  YKLabelPostCommentCell.h
//  JJBetter
//
//  Created by yikang on 16/4/26.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKLabelPostCommentCell : UITableViewCell


@property (nonatomic,strong)UIImageView *headImageView;  // 头像
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标
@property (nonatomic,strong)UILabel *timeLabel;  // 时间
@property (nonatomic,strong)UILabel *contentLabel;  // 内容


/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;


/** 计算评论的高度 */
+(CGFloat)heightForPostCommentLabel:(NSString *)commentLabel;




@end

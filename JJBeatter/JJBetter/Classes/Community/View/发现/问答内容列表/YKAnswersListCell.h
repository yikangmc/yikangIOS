//
//  YKAnswersListCell.h
//  JJBetter
//
//  Created by yikang on 16/5/6.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKAnswersListCell : UITableViewCell


@property (nonatomic,strong)UILabel *titleLabel;  // 标题
@property (nonatomic,strong)UIImageView *tagImageView;  // 标记是否有图片
@property (nonatomic,strong)UIImageView *headImageView;  // 头像
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UILabel *timeLabel;  // 时间
@property (nonatomic,strong)UILabel *getAnswerLabel;  // 获得回答数


/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;






@end

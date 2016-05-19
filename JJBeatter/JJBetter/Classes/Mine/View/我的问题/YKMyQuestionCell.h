//
//  YKMyQuestionCell.h
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKMyQuestionCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLabel;  // 问题标题
@property (nonatomic,strong)UILabel *labelLabel;  // 标签
@property (nonatomic,strong)UILabel *timeLabel;  // 时间
@property (nonatomic,strong)UIButton *commentBtn;  // 评论button
@property (nonatomic,strong)UILabel *commentLabel;  // 评论label

/** 标签自适应宽度 */
+(CGFloat)widthForLabelLabel:(NSString *)labelLabel;



@end

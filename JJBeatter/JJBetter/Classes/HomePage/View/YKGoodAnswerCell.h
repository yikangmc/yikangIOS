//
//  YKGoodAnswerCell.h
//  JJBetter
//
//  Created by yikang on 16/4/22.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKGoodAnswerCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLabel;  // 标题
@property (nonatomic,strong)UIImageView *tagImageView;  // 标记内容是否含图片
@property (nonatomic,strong)UIImageView *headImageView;  // 头像
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标
@property (nonatomic,strong)UILabel *timeLabel;  // 回答时间
@property (nonatomic,strong)UILabel *contentLabel;  // 内容
@property (nonatomic,strong)UIButton *seeContentBtn;  // 查看全部
@property (nonatomic,strong)UILabel *getYesLabel;  // 获得赞同

/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;



@end

//
//  YKProfessionDetailCell.h
//  JJBetter
//
//  Created by yikang on 16/5/6.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKProfessionDetailCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLabel;  // 标题
@property (nonatomic,strong)UIButton *collectBtn;  // 收藏
@property (nonatomic,strong)UIImageView *headImageView;  // 头像
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标
@property (nonatomic,strong)UILabel *timeLabel;  // 时间
@property (nonatomic,strong)UILabel *contentLabel;  // 内容
@property (nonatomic,strong)UIButton *likeBtn;  // 喜欢button
@property (nonatomic,strong)UILabel *likeLabel;  // 喜欢label
@property (nonatomic,strong)UIButton *commentBtn;  // 评论button
@property (nonatomic,strong)UILabel *commentLabel;  // 评论label
@property (nonatomic,strong)UIButton *moreImageBtn;  // 更多button(分享)
@property (nonatomic,strong)UIButton *moreLabelBtn;  // 更多button


/** 标题自适应高度 */
+(CGFloat)heightForTitleLabel:(NSString *)titleLabel;


/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;


/** 计算帖子内容的高度 */
+(CGFloat)heightForPostContentLabel:(NSString *)contentLabel;


/** 添加一个方法(添加标签) */
-(void)creatLabelWithArray:(NSArray *)dataArr;




@end

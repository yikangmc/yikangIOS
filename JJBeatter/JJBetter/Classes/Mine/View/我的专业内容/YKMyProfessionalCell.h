//
//  YKMyProfessionalCell.h
//  JJBetter
//
//  Created by yikang on 16/5/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKMyProfessionalCell : UITableViewCell

@property (nonatomic,strong)UIImageView *photoImageView;  // 图片
@property (nonatomic,strong)UILabel *titleLabel;  // 专业内容标题
@property (nonatomic,strong)UIButton *likeBtn;  // 喜欢button
@property (nonatomic,strong)UILabel *likeLabel;  // 喜欢label
@property (nonatomic,strong)UIButton *commentBtn;  // 评论button
@property (nonatomic,strong)UILabel *commentLabel;  // 评论label



@end

//
//  YKPersonalHomePagePostNoImgCell.h
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKPersonalHomePagePostNoImgCell : UITableViewCell


@property (nonatomic,strong)UILabel *contentLabel;  // 内容
@property (nonatomic,strong)UIButton *moreContentBtn;  // 更多
@property (nonatomic,strong)UILabel *timeLabel;  //时间
@property (nonatomic,strong)UIButton *likeBtn;  // 喜欢button
@property (nonatomic,strong)UILabel *likeLabel;  // 喜欢label
@property (nonatomic,strong)UIButton *commentBtn;  // 评论button
@property (nonatomic,strong)UILabel *commentLabel;  // 评论label


/** 添加一个方法(添加标签) */
-(void)creatLabelWithArray:(NSArray *)dataArr;





@end

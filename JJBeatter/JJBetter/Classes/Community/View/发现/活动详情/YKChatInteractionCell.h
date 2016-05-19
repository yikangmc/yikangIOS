//
//  YKChatInteractionCell.h
//  JJBetter
//
//  Created by yikang on 16/5/8.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKChatInteractionCell : UITableViewCell


@property (nonatomic,strong)UIImageView *headImageView;  // 头像
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UILabel *chatContentLabel;  // 聊天内容
@property (nonatomic,strong)UILabel *timeLabel;  // 时间


/** 聊天内容自适应高度 */
+(CGFloat)heightForChatContentLabel:(NSString *)chatContentLabel;




@end

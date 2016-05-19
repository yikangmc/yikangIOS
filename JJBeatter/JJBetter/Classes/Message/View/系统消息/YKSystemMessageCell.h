//
//  YKSystemMessageCell.h
//  JJBetter
//
//  Created by yikang on 16/5/11.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKSystemMessageCell : UITableViewCell


@property (nonatomic,strong)UIImageView *systemImageView;  // 图片
@property (nonatomic,strong)UILabel *titleLabel;  // 标题
@property (nonatomic,strong)UILabel *messageLabel;  //信息
@property (nonatomic,strong)UILabel *timeLabel;  // 时间


@end

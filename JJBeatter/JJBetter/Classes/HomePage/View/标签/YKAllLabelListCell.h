//
//  YKAllLabelListCell.h
//  JJBetter
//
//  Created by yikang on 16/4/21.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKAllLabelListCell : UITableViewCell


@property (nonatomic,strong)UIImageView *photoImageView;  // 子标签图片
@property (nonatomic,strong)UILabel *titleLabel;  // 子标签
@property (nonatomic,strong)UILabel *postsLabel;  // 帖子数
@property (nonatomic,strong)UILabel *updateLabel;  // 更新时间
@property (nonatomic,strong)UILabel *focusLabel;  // 关注数



@end

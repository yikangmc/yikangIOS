//
//  YKSearchResultPeopleCell.h
//  JJBetter
//
//  Created by yikang on 16/5/10.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKSearchResultPeopleCell : UITableViewCell


@property (nonatomic,strong)UIImageView *headImageView;  // 头像
@property (nonatomic,strong)UILabel *nameLabel;  // 名字
@property (nonatomic,strong)UIImageView *typeImageView;  // 类型图标

/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel;


/** 添加一个类方法(添加标签) */
-(void)creatLabelWithArray:(NSArray *)dataArr;




@end

//
//  AddressTableViewCell.h
//  YouthFountain
//
//  Created by 马文帅 on 15/7/2.
//  Copyright (c) 2015年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKAddressTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *subTitleLable;

+ (id)cellInitWithTable:(UITableView *)tableView;

- (void)refreshWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end

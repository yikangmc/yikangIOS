//
//  YKActivityIntroduceCell.m
//  JJBetter
//
//  Created by yikang on 16/5/9.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKActivityIntroduceCell.h"

@implementation YKActivityIntroduceCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allViews];
    }
    return self;
    
}


-(void)allViews
{
    // 上面
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(36 * WScale);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = YK505050;
    label.text = @"活动介绍";
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.width.mas_equalTo(130 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKf0f0f0;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    
    // 下面
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = YK333333;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.top.mas_equalTo(line.mas_bottom).offset(13 * WScale);
        make.width.mas_equalTo(345 * WScale);
    }];
    
    
    self.ownerLabel = [[UILabel alloc] init];
    self.ownerLabel.textColor = YK656565;
    self.ownerLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.ownerLabel];
    [self.ownerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(13 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(14 * WScale);
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = YK656565;
    self.timeLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.ownerLabel.mas_bottom).offset(6 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(14 * WScale);
    }];
    
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.textColor = YK656565;
    self.addressLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(6 * WScale);
        make.width.mas_equalTo(345 * WScale);
    }];
    
    
    
    
}


/** 标题自适应高度 */
+(CGFloat)heightForTitleLabel:(NSString *)titleLabel
{
    CGSize size = CGSizeMake(345 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15 * WScale]};
    CGRect rect = [titleLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
    
}


/** 地址自适应高度 */
+(CGFloat)heightForAddressLabel:(NSString *)addressLabel
{
    CGSize size = CGSizeMake(345 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
    CGRect rect = [addressLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
    
}









- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}







@end

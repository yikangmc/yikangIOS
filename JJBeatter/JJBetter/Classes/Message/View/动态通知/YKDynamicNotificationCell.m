//
//  YKDynamicNotificationCell.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKDynamicNotificationCell.h"

@implementation YKDynamicNotificationCell


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
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK505050;
    self.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(9 * WScale);
        make.width.mas_equalTo(150 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.textColor = YK656565;
    self.timeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.width.mas_equalTo(150 * WScale);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = YK656565;
    self.contentLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(13 * WScale);
        make.width.mas_equalTo(345 * WScale);
    }];
    
    
    
    
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}






@end

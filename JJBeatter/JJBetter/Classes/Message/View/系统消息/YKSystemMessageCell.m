//
//  YKSystemMessageCell.m
//  JJBetter
//
//  Created by yikang on 16/5/11.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKSystemMessageCell.h"

@implementation YKSystemMessageCell


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
    self.systemImageView = [[UIImageView alloc] init];
    self.systemImageView.clipsToBounds = YES;
    self.systemImageView.layer.cornerRadius = 45 * WScale / 2;
    [self.contentView addSubview:self.systemImageView];
    [self.systemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.width.mas_equalTo(45 * WScale);
        make.height.mas_equalTo(self.systemImageView.mas_width);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK333333;
    self.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.systemImageView.mas_top).offset(6 * WScale);
        make.width.mas_equalTo(200 * WScale);
        make.left.mas_equalTo(self.systemImageView.mas_right).offset(17 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.textColor = YK656565;
    self.messageLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.systemImageView.mas_bottom).offset(-2 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10 * WScale);
        make.left.mas_equalTo(self.systemImageView.mas_right).offset(17 * WScale);
        make.height.mas_equalTo(14 * WScale);
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.textColor = YK656565;
    self.timeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(12 * WScale);
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

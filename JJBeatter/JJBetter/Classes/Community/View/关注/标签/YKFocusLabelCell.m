//
//  YKFocusLabelCell.m
//  JJBetter
//
//  Created by yikang on 16/5/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKFocusLabelCell.h"

@implementation YKFocusLabelCell


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
    self.pictureImageView = [[UIImageView alloc] init];
    self.pictureImageView.clipsToBounds = YES;
    self.pictureImageView.layer.cornerRadius = 4 * WScale;
    [self.contentView addSubview:self.pictureImageView];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(41 * WScale);
        make.height.mas_equalTo(self.pictureImageView.mas_width);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK505050;
    self.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.pictureImageView.mas_right).offset(15 * WScale);
        make.height.mas_equalTo(15 * WScale);
        make.width.mas_equalTo(250 * WScale);
    }];
    
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.clipsToBounds = YES;
    self.countLabel.layer.cornerRadius = 13 * WScale;
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.backgroundColor = YK0faadd;
    self.countLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self.contentView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-17 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(26 * WScale);
        make.height.mas_equalTo(self.countLabel.mas_width);
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

//
//  YKMessageCell.m
//  JJBetter
//
//  Created by yikang on 16/5/10.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMessageCell.h"

@implementation YKMessageCell


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
    
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(13 * WScale);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    self.customLabel = [[UILabel alloc] init];
    self.customLabel.textColor = YK505050;
    self.customLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.customLabel];
    [self.customLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(150);
    }];
    
    
    self.boolImageView = [[UIImageView alloc] init];
    self.boolImageView.image = [UIImage imageNamed:@"未查看"];
    self.boolImageView.hidden = YES;
    [self.contentView addSubview:self.boolImageView];
    [self.boolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-28 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(7 * WScale);
        make.height.mas_equalTo(self.boolImageView.mas_width);
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

//
//  YKMyInforCell.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyInforCell.h"

@implementation YKMyInforCell


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
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 31 * WScale;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(62 * WScale);
        make.height.mas_equalTo(self.headImageView.mas_width);
    }];
    
    
    self.boolOnlineLabel = [[UILabel alloc] init];
    self.boolOnlineLabel.textColor = YK333333;
    self.boolOnlineLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.boolOnlineLabel];
    [self.boolOnlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(16 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-50 * WScale);
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

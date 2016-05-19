//
//  YKPersonalHomePageInforCell.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPersonalHomePageInforCell.h"

@implementation YKPersonalHomePageInforCell


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
    self.headImageView.layer.cornerRadius = 62 * WScale / 2;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.width.mas_equalTo(62 * WScale);
        make.height.mas_equalTo(self.headImageView.mas_width);
    }];
    
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.focusBtn];
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-25 * WScale);
        make.width.mas_equalTo(58 * WScale);
        make.height.mas_equalTo(20 * WScale);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK333333;
    self.nameLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(15 * WScale);
        make.height.mas_equalTo(16 * WScale);
        make.right.mas_equalTo(self.focusBtn.mas_left).offset(-15 * WScale);
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

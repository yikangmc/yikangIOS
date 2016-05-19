//
//  YKPayMethodCell.m
//  JJBetter
//
//  Created by yikang on 16/5/9.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPayMethodCell.h"

@implementation YKPayMethodCell


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
    self.payMethodImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.payMethodImg];
    [self.payMethodImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(18 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(47 * WScale);
        make.height.mas_equalTo(self.payMethodImg.mas_width);
    }];
    
    
    self.payMethodLabel = [[UILabel alloc] init];
    self.payMethodLabel.textColor = YK505050;
    self.payMethodLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.payMethodLabel];
    [self.payMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.payMethodImg.mas_right).offset(10 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(15 * WScale);
        make.width.mas_equalTo(150 );
    }];
    
    
    self.payMethodIconImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.payMethodIconImg];
    [self.payMethodIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-18 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(19 * WScale);
        make.height.mas_equalTo(self.payMethodIconImg.mas_width);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(1);
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

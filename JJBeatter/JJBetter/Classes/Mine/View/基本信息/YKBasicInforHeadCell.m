//
//  YKBasicInforHeadCell.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKBasicInforHeadCell.h"

@implementation YKBasicInforHeadCell


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
    UILabel *label = [[UILabel alloc] init];
    label.text = @"头像";
    label.textColor = YK333333;
    label.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(150 * WScale);
        make.height.mas_equalTo(16 * WScale);
    }];
    
    
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 30 * WScale;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(60 * WScale);
        make.height.mas_equalTo(self.headImageView.mas_width);
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

//
//  YKFocusAddLabelCell.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKFocusAddLabelCell.h"

@implementation YKFocusAddLabelCell


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
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"专业内容列表添加"];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(138 * WScale);
        make.width.mas_equalTo(18 * WScale);
        make.height.mas_equalTo(iconImageView.mas_width);
    }];
    
    
    self.addMoreLabel = [[UILabel alloc] init];
    self.addMoreLabel.textColor = YK656565;
    self.addMoreLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.addMoreLabel];
    [self.addMoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(iconImageView.mas_right).offset(10 * WScale);
        make.width.mas_equalTo(150 * WScale);
        make.height.mas_equalTo(14 * WScale);
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

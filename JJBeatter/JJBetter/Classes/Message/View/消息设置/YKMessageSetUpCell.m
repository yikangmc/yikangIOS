//
//  YKMessageSetUpCell.m
//  JJBetter
//
//  Created by yikang on 16/5/11.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMessageSetUpCell.h"

@implementation YKMessageSetUpCell


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
    
    self.customLabel = [[UILabel alloc] init];
    self.customLabel.textColor = YK505050;
    self.customLabel.font = [UIFont systemFontOfSize:14 ];
    [self.contentView addSubview:self.customLabel];
    [self.customLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 );
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
    
    
    self.customSwitch = [[UISwitch alloc] init];
    self.customSwitch.onTintColor = YK0faadd;
    [self.contentView addSubview:self.customSwitch];
    [self.customSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 );
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

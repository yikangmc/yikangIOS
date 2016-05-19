//
//  YKPayAmountCell.m
//  JJBetter
//
//  Created by yikang on 16/5/9.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPayAmountCell.h"

@implementation YKPayAmountCell


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
    label.text = @"支付金额";
    label.textColor = YK656565;
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(15 * WScale);
        make.width.mas_equalTo(100 * WScale);
    }];
    
    
    self.payAmountLabel = [[UILabel alloc] init];
    self.payAmountLabel.textAlignment = NSTextAlignmentRight;
    self.payAmountLabel.textColor = YKe82c2c;
    self.payAmountLabel.font = [UIFont systemFontOfSize:16 * WScale];
    [self.contentView addSubview:self.payAmountLabel];
    [self.payAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(17 * WScale);
        make.left.mas_equalTo(label.mas_right).offset(20 * WScale);
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

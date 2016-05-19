//
//  YKPersonalHomePagePersonContentCell.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPersonalHomePagePersonContentCell.h"

@implementation YKPersonalHomePagePersonContentCell


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
    label.textColor = YK333333;
    label.font = [UIFont systemFontOfSize:15 * WScale];
    label.text = @"个人简介";
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(39 * WScale);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.top.mas_equalTo(label.mas_bottom);
        make.height.mas_equalTo(1 * WScale);
    }];
    
    
    self.introduceLabel = [[UILabel alloc] init];
    self.introduceLabel.numberOfLines = 0;
    self.introduceLabel.textColor = YK636363;
    self.introduceLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.introduceLabel];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(11 * WScale);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(345 * WScale);
    }];
    
    
    
}


/** 计算个人简介高度 */
+(CGFloat)heightForIntroduceLabel:(NSString *)introduceLabel
{
    CGSize size = CGSizeMake(345 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14 * WScale]};
    CGRect rect = [introduceLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat countH = introduceLabel.length / 26 + 1;
    return rect.size.height + countH * 3 * WScale;
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end

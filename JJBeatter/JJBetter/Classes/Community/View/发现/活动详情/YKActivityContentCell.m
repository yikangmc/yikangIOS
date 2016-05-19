//
//  YKActivityContentCell.m
//  JJBetter
//
//  Created by yikang on 16/5/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKActivityContentCell.h"

@implementation YKActivityContentCell


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
    
    // 上面
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(36 * WScale);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = YK505050;
    label.text = @"活动介绍";
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.width.mas_equalTo(130 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKf0f0f0;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.width.mas_equalTo(355 * WScale);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
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

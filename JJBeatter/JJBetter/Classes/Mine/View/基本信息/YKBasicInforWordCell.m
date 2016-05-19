//
//  YKBasicInforWordCell.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKBasicInforWordCell.h"

@implementation YKBasicInforWordCell


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
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK505050;
    self.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(90 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    self.inforLabel = [[UILabel alloc] init];
    self.inforLabel.textAlignment = NSTextAlignmentRight;
    self.inforLabel.textColor = YK656565;
    self.inforLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self.contentView addSubview:self.inforLabel];
    [self.inforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.height.mas_equalTo(13 * WScale);
    }];

    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(1 * WScale);
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

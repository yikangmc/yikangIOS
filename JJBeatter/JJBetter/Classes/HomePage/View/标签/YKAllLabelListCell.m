//
//  YKAllLabelListCell.m
//  JJBetter
//
//  Created by yikang on 16/4/21.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKAllLabelListCell.h"

@implementation YKAllLabelListCell


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
    
    self.photoImageView = [[UIImageView alloc] init];
    self.photoImageView.clipsToBounds = YES;
    self.photoImageView.layer.cornerRadius = 4 * WScale;
    [self.contentView addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(15 * WScale);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(50 * WScale);
        make.width.mas_equalTo(self.photoImageView.mas_height);
    }];

    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    self.titleLabel.textColor = YK333333;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.photoImageView.mas_right).offset(12.5 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20 * WScale);
        make.width.mas_equalTo(100 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    self.postsLabel = [[UILabel alloc] init];
    self.postsLabel.font = [UIFont systemFontOfSize:12 * WScale];
    self.postsLabel.textColor = YK656565;
    [self.contentView addSubview:self.postsLabel];
    [self.postsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabel.mas_leading);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(7.5 * WScale);
        make.width.mas_equalTo(100 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
    self.updateLabel = [[UILabel alloc] init];
    self.updateLabel.font = [UIFont systemFontOfSize:11 * WScale];
    self.updateLabel.textColor = YK656565;
    self.updateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.updateLabel];
    [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset( - 15 * WScale);
        make.top.mas_equalTo(self.photoImageView.mas_top).offset(5 * WScale);
        make.width.mas_equalTo(150 * WScale);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    self.focusLabel = [[UILabel alloc] init];
    self.focusLabel.font = [UIFont systemFontOfSize:11 * WScale];
    self.focusLabel.textColor = YK0faadd;
    self.focusLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.focusLabel];
    [self.focusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.updateLabel.mas_trailing);
        make.top.mas_equalTo(self.updateLabel.mas_bottom).offset(7.5 * WScale);
        make.width.mas_equalTo(100 * WScale);
        make.height.mas_equalTo(12 * WScale);
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

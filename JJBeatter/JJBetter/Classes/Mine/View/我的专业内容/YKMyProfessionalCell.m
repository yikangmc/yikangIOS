//
//  YKMyProfessionalCell.m
//  JJBetter
//
//  Created by yikang on 16/5/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyProfessionalCell.h"

@implementation YKMyProfessionalCell


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
    [self.contentView addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15 * WScale);
        make.height.mas_equalTo(40 * WScale);
        make.width.mas_equalTo(self.photoImageView.mas_height);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = YK505050;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.photoImageView.mas_right).offset(10 * WScale);
        make.centerY.mas_equalTo(self.photoImageView.mas_centerY);
        make.height.mas_equalTo(40 * WScale);
        make.width.mas_equalTo(280 * WScale);
    }];
  
    
    // 喜欢与评论(从右向左布局)
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.text = @"999999";
    self.commentLabel.textColor = YK505050;
    self.commentLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.width.mas_equalTo(45 * WScale);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setBackgroundImage: [UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.commentLabel.mas_left).offset(-5 * WScale);
        make.centerY.mas_equalTo(self.commentLabel.mas_centerY);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(10);
    }];
    
    
    self.likeLabel = [[UILabel alloc] init];
    self.likeLabel.textColor = YK505050;
    self.likeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.likeLabel];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.commentBtn.mas_left).offset(-14 * WScale);
        make.width.mas_equalTo(45 * WScale);
        make.centerY.mas_equalTo(self.commentLabel.mas_centerY);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setBackgroundImage: [UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.likeLabel.mas_left).offset(-6 * WScale);
        make.centerY.mas_equalTo(self.commentLabel.mas_centerY);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(9);
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

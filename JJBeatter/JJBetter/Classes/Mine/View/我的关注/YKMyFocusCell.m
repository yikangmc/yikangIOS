//
//  YKMyFocusCell.m
//  JJBetter
//
//  Created by yikang on 16/5/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyFocusCell.h"

@implementation YKMyFocusCell


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
        make.top.mas_equalTo(self.contentView.mas_top).offset(10 * WScale);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(40 * WScale);
        make.width.mas_equalTo(self.photoImageView.mas_height);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK505050;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.photoImageView.mas_right).offset(11 * WScale);
        make.top.mas_equalTo(self.photoImageView.mas_top).offset(1 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(16 * WScale);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK646464;
    self.nameLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabel.mas_leading);
        make.bottom.mas_equalTo(self.photoImageView.mas_bottom).offset(-1 * WScale);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    self.typeImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeImageView];
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(2.5 * WScale);
        make.height.mas_equalTo(14 * WScale);
        make.width.mas_equalTo(self.typeImageView.mas_height);
        self.typeImageView.clipsToBounds = YES;
        self.typeImageView.layer.cornerRadius = 7 * WScale ;
    }];
    
}

// 名字自适应宽度
+(CGFloat)widthForNameLabel:(NSString *)nameLabel
{
    
    CGSize size = CGSizeMake(0, 12 * WScale);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:11 * WScale]};
    CGRect rect = [nameLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end

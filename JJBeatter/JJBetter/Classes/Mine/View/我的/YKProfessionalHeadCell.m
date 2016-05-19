//
//  YKProfessionalHeadCell.m
//  JJBetter
//
//  Created by yikang on 16/5/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKProfessionalHeadCell.h"

@implementation YKProfessionalHeadCell


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
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 31 * WScale;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(62 * WScale);
        make.height.mas_equalTo(self.headImageView.mas_width);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK333333;
    self.nameLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(13 * WScale);
        make.height.mas_equalTo(16 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(26 * WScale);
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
    
    
    self.positionLabel = [[UILabel alloc] init];
    self.positionLabel.textColor = YK333333;
    self.positionLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.positionLabel];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel.mas_leading);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10 * WScale);
        make.width.mas_equalTo(100 * WScale);
        make.height.mas_equalTo(14 * WScale);
    }];
    
    
    
}

// 名字自适应宽度
+(CGFloat)widthForNameLabel:(NSString *)nameLabel
{
    
    CGSize size = CGSizeMake(0, 16 * WScale);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15 * WScale]};
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

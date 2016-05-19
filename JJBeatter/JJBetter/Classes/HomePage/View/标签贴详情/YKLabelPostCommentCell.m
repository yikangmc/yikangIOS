//
//  YKLabelPostCommentCell.m
//  JJBetter
//
//  Created by yikang on 16/4/26.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKLabelPostCommentCell.h"

@implementation YKLabelPostCommentCell



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
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(22 * WScale);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(28 * WScale);
        make.width.mas_equalTo(self.headImageView.mas_height);
        self.headImageView.clipsToBounds = YES;
        self.headImageView.layer.cornerRadius = 14 * WScale;
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK505050;
    self.nameLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(20 * WScale);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(8 * WScale);
        make.height.mas_equalTo(13 * WScale);
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
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = YK787878;
    self.timeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel.mas_leading);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(6 * WScale);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = YK656565;
    self.contentLabel.font = [UIFont systemFontOfSize:13 * WScale];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel.mas_leading);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(12 * WScale);
        make.width.mas_equalTo(310 * WScale);
    }];
    
    
}




/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel
{
    CGSize size = CGSizeMake(0, 13 * WScale);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12 * WScale]};
    CGRect rect = [nameLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
    
}



/** 计算评论的高度 */
+(CGFloat)heightForPostCommentLabel:(NSString *)commentLabel
{
    CGSize size = CGSizeMake(310 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
    CGRect rect = [commentLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
    
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end

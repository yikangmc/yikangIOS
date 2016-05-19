//
//  YKActivityTitleCell.m
//  JJBetter
//
//  Created by yikang on 16/5/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKActivityTitleCell.h"

@implementation YKActivityTitleCell


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
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(17 * WScale);
        make.width.mas_equalTo(230 * WScale);
    }];
    
    
    self.chargeLabel = [[UILabel alloc] init];
    self.chargeLabel.font = [UIFont systemFontOfSize:16 * WScale];
    self.chargeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.chargeLabel];
    [self.chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(17 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(17 * WScale);
        make.width.mas_equalTo(100 * WScale);
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = YK656565;
    self.timeLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(14 * WScale);
        make.height.mas_equalTo(14 * WScale);
    }];
    
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.textColor = YK656565;
    self.addressLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(5 * WScale);
        make.width.mas_equalTo(300 * WScale);
    }];
    
    
    self.endImageView = [[UIImageView alloc] init];
    self.endImageView.hidden = YES;
    self.endImageView.image = [UIImage imageNamed:@"已结束"];
    [self.contentView addSubview:self.endImageView];
    [self.endImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.top.mas_equalTo(self.chargeLabel.mas_bottom).offset(5 * WScale);
        make.width.mas_equalTo(71 * WScale);
        make.height.mas_equalTo(61 * WScale);
    }];
    
    
    
}



/** 标题自适应高度 */
+(CGFloat)heightForTitleLabel:(NSString *)titleLabel
{
    CGSize size = CGSizeMake(230 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15 * WScale]};
    CGRect rect = [titleLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;

}


/** 地址自适应高度 */
+(CGFloat)heightForAddressLabel:(NSString *)addressLabel
{
    CGSize size = CGSizeMake(300 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
    CGRect rect = [addressLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
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

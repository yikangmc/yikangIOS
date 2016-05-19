//
//  YKGoodAnswerCell.m
//  JJBetter
//
//  Created by yikang on 16/4/22.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKGoodAnswerCell.h"

@implementation YKGoodAnswerCell


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
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(15 * WScale);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.width.mas_equalTo(313 * WScale);
        make.height.mas_equalTo(16 * WScale);
    }];
    
    
    self.tagImageView = [[UIImageView alloc] init];
    self.tagImageView.image = [UIImage imageNamed:@"屏幕快照-"];
    self.tagImageView.hidden = YES;
    [self.contentView addSubview:self.tagImageView];
    [self.tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.height.mas_equalTo(17 * WScale);
        make.width.mas_equalTo(self.tagImageView.mas_height);
    }];
    
    
    self.headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8 * WScale);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(28 * WScale);
        make.width.mas_equalTo(self.headImageView.mas_height);
        self.headImageView.clipsToBounds = YES;
        self.headImageView.layer.cornerRadius = 14 * WScale;
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK646464;
    self.nameLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(8 * WScale);
        make.centerY.mas_equalTo(self.headImageView.mas_centerY);
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
    self.timeLabel.textColor = YK656565;
    self.timeLabel.font = [UIFont systemFontOfSize:10 * WScale];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeImageView.mas_right).offset(12 * WScale);
        make.centerY.mas_equalTo(self.typeImageView.mas_centerY);
        make.width.mas_equalTo(150 * WScale);
        make.height.mas_equalTo(11 * WScale);
    }];
    
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = YK636363;
    self.contentLabel.font = [UIFont systemFontOfSize:13 * WScale];
    self.contentLabel.numberOfLines = 5;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.headImageView.mas_leading);
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(14 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(90 * WScale);
    }];
    
    
    self.seeContentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.seeContentBtn.titleLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.seeContentBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [self.seeContentBtn setTitleColor:YK0faadd forState:UIControlStateNormal];
    [self.contentLabel addSubview:self.seeContentBtn];
    [self.seeContentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentLabel.mas_right).offset(-4 * WScale);
        make.bottom.mas_equalTo(self.contentLabel.mas_bottom);
        make.width.mas_equalTo(55 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
    self.getYesLabel = [[UILabel alloc] init];
    self.getYesLabel.textColor = YK4f4f4f;
    self.getYesLabel.textAlignment = NSTextAlignmentCenter;
    self.getYesLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self.contentView addSubview:self.getYesLabel];
    [self.getYesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(25 * WScale);
        make.width.mas_equalTo(150 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
}



/** 名字自适应宽度 */
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

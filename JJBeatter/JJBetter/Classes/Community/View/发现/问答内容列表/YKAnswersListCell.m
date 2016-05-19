//
//  YKAnswersListCell.m
//  JJBetter
//
//  Created by yikang on 16/5/6.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKAnswersListCell.h"

@implementation YKAnswersListCell


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
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(90 * WScale);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK515151;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [topView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(18 * WScale);
        make.top.mas_equalTo(topView.mas_top).offset(19 * WScale);
        make.width.mas_equalTo(313 * WScale);
        make.height.mas_equalTo(16 * WScale);
    }];
    
    
    self.tagImageView = [[UIImageView alloc] init];
    self.tagImageView.image = [UIImage imageNamed:@"问答内容列表标记图"];
    self.tagImageView.hidden = YES;
    [topView addSubview:self.tagImageView];
    [self.tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.height.mas_equalTo(17 * WScale);
        make.width.mas_equalTo(self.tagImageView.mas_height);
    }];
    
    
    self.headImageView = [[UIImageView alloc] init];
    [topView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(6 * WScale);
        make.left.mas_equalTo(topView.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(23 * WScale);
        make.width.mas_equalTo(self.headImageView.mas_height);
        self.headImageView.clipsToBounds = YES;
        self.headImageView.layer.cornerRadius = 23 * WScale / 2;
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK656565;
    self.nameLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [topView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(6 * WScale);
        make.centerY.mas_equalTo(self.headImageView.mas_centerY);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = YK797979;
    self.timeLabel.font = [UIFont systemFontOfSize:10 * WScale];
    [topView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(20 * WScale);
        make.height.mas_equalTo(11 * WScale);
        make.width.mas_equalTo(100 * WScale);
    }];
    
    
    self.getAnswerLabel = [[UILabel alloc] init];
    self.getAnswerLabel.textAlignment = NSTextAlignmentRight;
    self.getAnswerLabel.textColor = YK787878;
    self.getAnswerLabel.font = [UIFont systemFontOfSize:10 * WScale];
    [topView addSubview:self.getAnswerLabel];
    [self.getAnswerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView.mas_right).offset(-9 * WScale);
        make.centerY.mas_equalTo(self.headImageView.mas_centerY);
        make.height.mas_equalTo(11 * WScale);
    }];
    
    
    UIView *gray = [[UIView alloc] init];
    gray.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:gray];
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(25 * WScale);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(10 * WScale);
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








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end

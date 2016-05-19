//
//  YKMyQuestionCell.m
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyQuestionCell.h"

@implementation YKMyQuestionCell


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
    self.titleLabel.textColor = YK333333;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(14 * WScale);
        make.height.mas_equalTo(16 * WScale);
    }];
    
    
    self.labelLabel = [[UILabel alloc] init];
    self.labelLabel.backgroundColor = YKf0f0f0;
    self.labelLabel.textAlignment = NSTextAlignmentCenter;
    self.labelLabel.textColor = YK323232;
    self.labelLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self.contentView addSubview:self.labelLabel];
    [self.labelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(9 * WScale);
        make.height.mas_equalTo(19 * WScale);
    }];
    
    
    // 评论(从右向左布局)
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.text = @"999999";
    self.commentLabel.textColor = YK505050;
    self.commentLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labelLabel.mas_centerY);
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
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.textColor = YK505050;
    self.timeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.commentBtn.mas_left).offset(-14 * WScale);
        make.centerY.mas_equalTo(self.commentLabel.mas_centerY);
        make.width.mas_equalTo(150 * WScale);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
}



/** 标签自适应宽度 */
+(CGFloat)widthForLabelLabel:(NSString *)labelLabel
{
    
    CGSize size = CGSizeMake(0, 19 * WScale);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12 * WScale]};
    CGRect rect = [labelLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width + 15 * WScale;
    
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end

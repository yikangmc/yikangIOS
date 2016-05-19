//
//  YKChatInteractionCell.m
//  JJBetter
//
//  Created by yikang on 16/5/8.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKChatInteractionCell.h"

@implementation YKChatInteractionCell


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
    self.headImageView.layer.cornerRadius = 30 * WScale / 2;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(11 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(16 * WScale);
        make.width.mas_equalTo(30 * WScale);
        make.height.mas_equalTo(self.headImageView.mas_width);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK787878;
    self.nameLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(6 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20 * WScale);
        make.height.mas_equalTo(14 * WScale);
        make.width.mas_equalTo(200 * WScale);
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.textColor = YK787878;
    self.timeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(25 * WScale);
        make.height.mas_equalTo(12 * WScale);
        make.width.mas_equalTo(100 * WScale);
    }];
    
    
    self.chatContentLabel = [[UILabel alloc] init];
    self.chatContentLabel.numberOfLines = 0;
    self.chatContentLabel.textColor = YK505050;
    self.chatContentLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.chatContentLabel];
    [self.chatContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5 * WScale);
        make.width.mas_equalTo(280 * WScale);
    }];
    
}


/** 聊天内容自适应高度 */
+(CGFloat)heightForChatContentLabel:(NSString *)chatContentLabel
{
    CGSize size = CGSizeMake(280 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
    CGRect rect = [chatContentLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
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

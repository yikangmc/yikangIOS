//
//  YKProfessionDetailCell.m
//  JJBetter
//
//  Created by yikang on 16/5/6.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKProfessionDetailCell.h"

@implementation YKProfessionDetailCell



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
    
    UIView *gray = [[UIView alloc] init];
    gray.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:gray];
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(10 * HScale);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = YK333333;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10 * WScale);
        make.top.mas_equalTo(gray.mas_bottom).offset(16 * HScale);
        make.width.mas_equalTo(250 * WScale);
    }];
    
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.collectBtn];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.top.mas_equalTo(gray.mas_bottom).offset(13 * HScale);
        if (ScreenH < 568) {
            make.width.mas_equalTo(34);
            make.height.mas_equalTo(17);
        }else {
            make.width.mas_equalTo(41 * WScale);
            make.height.mas_equalTo(20 * HScale);
        }
    }];
    
    
    self.headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10 * HScale);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10 * WScale);
        make.height.mas_equalTo(23 * HScale);
        make.width.mas_equalTo(self.headImageView.mas_height);
        self.headImageView.clipsToBounds = YES;
        self.headImageView.layer.cornerRadius = 23 * HScale / 2;
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK656565;
    self.nameLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(12 * WScale);
        make.centerY.mas_equalTo(self.headImageView.mas_centerY);
    }];
    
    
    self.typeImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeImageView];
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(2.5 * WScale);
        make.height.mas_equalTo(14 * HScale);
        make.width.mas_equalTo(self.typeImageView.mas_height);
        self.typeImageView.clipsToBounds = YES;
        self.typeImageView.layer.cornerRadius = 7 * HScale ;
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = YK656565;
    self.timeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageView.mas_centerY);
        make.left.mas_equalTo(self.typeImageView.mas_right).offset(11 * WScale);
        make.height.mas_equalTo(12 * HScale);
    }];

    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = YK333333;
    self.contentLabel.font = [UIFont systemFontOfSize:13 * WScale];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(10 * HScale);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(345 * WScale);
        make.height.mas_equalTo(0);
    }];
    
    
    // 喜欢与评论(从左向右布局)
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setBackgroundImage: [UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(30 * WScale);
        if (ScreenH < 568) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(42);
        }else{
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(50 * HScale);
        }
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(9);
    }];
    
    
    self.likeLabel = [[UILabel alloc] init];
    self.likeLabel.textColor = YK505050;
    self.likeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.likeLabel];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.likeBtn.mas_right).offset(6 * WScale);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.height.mas_equalTo(12 * HScale);
    }];
    
    
    UIView *one = [[UIView alloc] init];
    one.backgroundColor = YKf0f0f0;
    [self.contentView addSubview:one];
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenW / 3);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(18 * HScale);
    }];
    
    
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setBackgroundImage: [UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(one.mas_right).offset(40 * WScale);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(10);
    }];
    
    
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.textColor = YK505050;
    self.commentLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentBtn.mas_right).offset(5 * WScale);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.height.mas_equalTo(12 * HScale);
    }];
    
    
    UIView *two = [[UIView alloc] init];
    two.backgroundColor = YKf0f0f0;
    [self.contentView addSubview:two];
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenW * 2 / 3);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(18 * HScale);
        
    }];
    
    
    self.moreImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreImageBtn setBackgroundImage:[UIImage imageNamed:@"更多点"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.moreImageBtn];
    [self.moreImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(two.mas_right).offset(40 * WScale);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.width.mas_equalTo(13 * WScale);
        make.height.mas_equalTo(2 * HScale);
    }];
    
    
    self.moreLabelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.moreLabelBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreLabelBtn setTitleColor:YK656565 forState:UIControlStateNormal];
    self.moreLabelBtn.titleLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.moreLabelBtn];
    [self.moreLabelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moreImageBtn.mas_right).offset(5 * WScale);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.height.mas_equalTo(12 * HScale);
        make.width.mas_equalTo(25 * WScale);
    }];
    
    
}




/** 标题自适应高度 */
+(CGFloat)heightForTitleLabel:(NSString *)titleLabel
{
    CGSize size = CGSizeMake(250 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15 * WScale]};
    CGRect rect = [titleLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}


/** 名字自适应宽度 */
+(CGFloat)widthForNameLabel:(NSString *)nameLabel
{
    CGSize size = CGSizeMake(0, 15 * HScale);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14 * WScale]};
    CGRect rect = [nameLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}


/** 计算帖子内容的高度 */
+(CGFloat)heightForPostContentLabel:(NSString *)contentLabel
{
    CGSize size = CGSizeMake(345 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
    CGRect rect = [contentLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}


// 添加一个方法(添加标签)
-(void)creatLabelWithArray:(NSArray *)dataArr{
    
    UIView *view = [[UIView alloc] init];
    //    view.backgroundColor = [UIColor yellowColor];
    int width = 0;
    
    // 创建button
    for (int i = 0; i < dataArr.count ; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = YKf0f0f0;
        label.textColor = YK323232;
        label.text = dataArr[i];
        label.font = [UIFont systemFontOfSize:12 * WScale];
        label.textAlignment = NSTextAlignmentCenter;
        // 设置边框
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 1 * WScale;
        
        CGSize size = CGSizeMake(0, 13 * HScale);
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12 * WScale]};
        CGRect rect = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        
        if (iPhone4) {
            label.frame = CGRectMake((width + 12) * WScale , 2 * HScale, rect.size.width + 7 , 26 * HScale);
            width = width + rect.size.width + 26;
        }else if (iPhone5) {
            label.frame = CGRectMake((width + 10) * WScale , 2 * HScale, (rect.size.width + 16 ) * WScale, 23 * HScale);
            width = width + rect.size.width + 22;
        }else if (iPhone6) {
            label.frame = CGRectMake((width + 10) * WScale , 2 * HScale, (rect.size.width + 8 ) * WScale, 23 * HScale);
            width = width + rect.size.width + 13;
        }else {
            label.frame = CGRectMake((width + 10) * WScale , 2 * HScale, (rect.size.width + 3 ) * WScale, 23 * HScale);
            width = width + rect.size.width + 10;
        }
        
        [view addSubview:label];
        
    }
    view.clipsToBounds = YES;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        if (ScreenH < 568) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(15 * HScale);
        }else{
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10 * HScale);
        }
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10 * WScale);
        make.height.mas_equalTo(30 * HScale);
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

//
//  YKEssenceCell.m
//  JJBetter
//
//  Created by yikang on 16/4/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKEssenceCell.h"

@implementation YKEssenceCell


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
    
    // 上半部分
    UIView *topView = [[UIView alloc] init];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(33 * WScale);
    }];
    
    
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"精华内容"];
    [topView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(20 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.height.mas_equalTo(13 * WScale);
        make.width.mas_equalTo(iconImg.mas_height);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = YK333333;
    label.text = @"精华内容";
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(6 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.width.mas_equalTo(130 * WScale);
        make.height.mas_equalTo(topView.mas_height);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKf0f0f0;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.width.mas_equalTo(355 * WScale);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    
    // 下半部分
    self.headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(15 * WScale);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(40 * WScale);
        make.width.mas_equalTo(self.headImageView.mas_height);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK505050;
    self.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(11 * WScale);
        make.top.mas_equalTo(line.mas_bottom).offset(16 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK646464;
    self.nameLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabel.mas_leading);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
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

    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = YK636363;
    self.contentLabel.font = [UIFont systemFontOfSize:13 * WScale];
    self.contentLabel.numberOfLines = 4;
    self.contentLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.headImageView.mas_leading);
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(13 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(74 * WScale);
    }];
    
    
    self.seeContentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.seeContentBtn.titleLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.seeContentBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [self.seeContentBtn setTitleColor:YK0faadd forState:UIControlStateNormal];
    [self.contentLabel addSubview:self.seeContentBtn];
    [self.seeContentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentLabel.mas_right).offset(-4 * WScale);
        make.bottom.mas_equalTo(self.contentLabel.mas_bottom).offset(-2 * WScale);
        make.width.mas_equalTo(55 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
    // 喜欢与评论(从左向右布局)
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setBackgroundImage: [UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(30 * WScale);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(53 * WScale);
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
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    UIView *one = [[UIView alloc] init];
    one.backgroundColor = YKf0f0f0;
    [self.contentView addSubview:one];
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenW / 3);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(18 * WScale);
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
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    UIView *two = [[UIView alloc] init];
    two.backgroundColor = YKf0f0f0;
    [self.contentView addSubview:two];
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenW * 2 / 3);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(18 * WScale);
        
    }];
    
    
    self.moreImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreImageBtn setBackgroundImage:[UIImage imageNamed:@"更多点"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.moreImageBtn];
    [self.moreImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(two.mas_right).offset(40 * WScale);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.width.mas_equalTo(13 * WScale);
        make.height.mas_equalTo(2 * WScale);
    }];
    
    
    self.moreLabelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.moreLabelBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreLabelBtn setTitleColor:YK656565 forState:UIControlStateNormal];
    self.moreLabelBtn.titleLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.moreLabelBtn];
    [self.moreLabelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moreImageBtn.mas_right).offset(5 * WScale);
        make.centerY.mas_equalTo(self.likeBtn.mas_centerY);
        make.height.mas_equalTo(12 * WScale);
        make.width.mas_equalTo(25 * WScale);
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


-(void)creatLabelWithArray:(NSArray *)dataArr{
    
    UIView *view=[[UIView alloc]init];
    int width = 0;
    
    // 创建button
    for (int i = 0; i <dataArr.count ; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = YKf0f0f0;
        label.textColor = YK323232;
        label.text = dataArr[i];
        label.font = [UIFont systemFontOfSize:12 * WScale];
        label.textAlignment = NSTextAlignmentCenter;
        // 设置边框
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 1 * WScale;
        
        CGSize size = CGSizeMake(0, 13 * WScale);
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12 * WScale]};
        CGRect rect = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        
        if (iPhone4) {
            label.frame = CGRectMake((width + 12) * WScale , 2 * HScale, rect.size.width + 7 , 26 * WScale);
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
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10 * WScale);
        make.height.mas_equalTo(30 * WScale);
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

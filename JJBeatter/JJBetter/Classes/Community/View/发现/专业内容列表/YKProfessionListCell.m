//
//  YKProfessionListCell.m
//  JJBetter
//
//  Created by yikang on 16/5/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKProfessionListCell.h"

@implementation YKProfessionListCell


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
    // 上面
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(80 * WScale);
    }];
    
    
    self.photoImageView = [[UIImageView alloc] init];
    [topView addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.height.mas_equalTo(50 * WScale);
        make.width.mas_equalTo(self.photoImageView.mas_height);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = YK333333;
    self.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [topView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.photoImageView.mas_right).offset(10 * WScale);
        make.top.mas_equalTo(topView.mas_top).offset(22 * WScale);
        make.right.mas_equalTo(topView.mas_right);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK656565;
    self.nameLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [topView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
    self.typeImageView = [[UIImageView alloc] init];
    [topView addSubview:self.typeImageView];
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(2.5 * WScale);
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.height.mas_equalTo(14 * WScale);
        make.width.mas_equalTo(self.typeImageView.mas_height);
        self.typeImageView.clipsToBounds = YES;
        self.typeImageView.layer.cornerRadius = 7 * WScale ;
    }];
    
    
    // 线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKf0f0f0;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.top.mas_equalTo(topView.mas_bottom);
        make.height.mas_equalTo(1 * WScale);
    }];
    
    
    // 下面
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(80 * WScale);
    }];
    
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = YK656565;
    self.contentLabel.numberOfLines = 3;
    self.contentLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [bottomView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(15 * WScale);
        make.top.mas_equalTo(bottomView.mas_top).offset(13 * WScale);
        make.right.mas_equalTo(bottomView.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(48 * WScale);
    }];
    
    
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(bottomView.mas_bottom);
        make.height.mas_equalTo(10 * WScale);
    }];
    
    
    
}




// 名字自适应宽度
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

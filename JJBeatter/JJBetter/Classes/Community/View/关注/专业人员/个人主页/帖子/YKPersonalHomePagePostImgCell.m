
//
//  YKPersonalHomePagePostImgCell.m
//  JJBetter
//
//  Created by yikang on 16/5/17.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPersonalHomePagePostImgCell.h"

@implementation YKPersonalHomePagePostImgCell


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
        make.height.mas_equalTo(10 * WScale);
    }];

    // 四张图片
    self.photoImg1 = [[UIImageView alloc] init];
    self.photoImg1.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.photoImg1];
    self.photoImg2 = [[UIImageView alloc] init];
    self.photoImg2.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.photoImg2];
    self.photoImg3 = [[UIImageView alloc] init];
    self.photoImg3.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.photoImg3];
    self.photoImg4 = [[UIImageView alloc] init];
    self.photoImg4.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.photoImg4];
    [self.photoImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gray.mas_bottom).offset(10 * WScale);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(self.photoImg1.mas_width);
    }];
    [self.photoImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoImg1.mas_top);
        make.left.mas_equalTo(self.photoImg1.mas_right).offset(21 * WScale / 2);
        make.width.mas_equalTo(self.photoImg1.mas_width);
        make.height.mas_equalTo(self.photoImg1.mas_height);
    }];
    [self.photoImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoImg1.mas_top);
        make.left.mas_equalTo(self.photoImg2.mas_right).offset(21 * WScale / 2);
        make.width.mas_equalTo(self.photoImg1.mas_width);
        make.height.mas_equalTo(self.photoImg1.mas_height);
    }];
    [self.photoImg4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoImg1.mas_top);
        make.left.mas_equalTo(self.photoImg3.mas_right).offset(21 * WScale / 2);
        make.right.mas_equalTo(self.contentView.mas_right).offset( - 15 * WScale);
        make.width.mas_equalTo(self.photoImg1.mas_width);
        make.height.mas_equalTo(self.photoImg1.mas_height);
    }];
    
    self.photoImg1.backgroundColor = [UIColor yellowColor];
    self.photoImg2.backgroundColor = [UIColor yellowColor];
    self.photoImg3.backgroundColor = [UIColor yellowColor];
    self.photoImg4.backgroundColor = [UIColor yellowColor];
    
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = YK333333;
    self.contentLabel.font = [UIFont systemFontOfSize:13 * WScale];
    self.contentLabel.numberOfLines = 4;
    self.contentLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoImg1.mas_bottom).offset(10 * WScale);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(345 * WScale);
        make.height.mas_equalTo(74 * WScale);
    }];
    
    
    self.moreContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreContentBtn.titleLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.moreContentBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreContentBtn setTitleColor:YK0faadd forState:UIControlStateNormal];
    [self.contentLabel addSubview:self.moreContentBtn];
    [self.moreContentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentLabel.mas_right).offset(-11 * WScale);
        make.bottom.mas_equalTo(self.contentLabel.mas_bottom).offset(-2 * WScale);
        make.width.mas_equalTo(40 * WScale);
        make.height.mas_equalTo(13 * WScale);
        
    }];
    
    
    // 喜欢与评论(从右向左布局)
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.text = @"999999";
    self.commentLabel.textColor = YK505050;
    self.commentLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(52 * WScale);
        make.right.mas_equalTo(self.photoImg4.mas_right);
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
    
    
    self.likeLabel = [[UILabel alloc] init];
    self.likeLabel.textColor = YK505050;
    self.likeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.likeLabel];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.commentBtn.mas_left).offset(-14 * WScale);
        make.width.mas_equalTo(45 * WScale);
        make.centerY.mas_equalTo(self.commentLabel.mas_centerY);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setBackgroundImage: [UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.likeLabel.mas_left).offset(-6 * WScale);
        make.centerY.mas_equalTo(self.commentLabel.mas_centerY);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(9);
    }];
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = YK656565;
    self.timeLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.width.mas_equalTo(100 * WScale);
        make.centerY.mas_equalTo(self.commentLabel.mas_centerY);
        make.height.mas_equalTo(12 * WScale);
    }];
    
    
}



/** 添加一个方法(添加标签) */
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

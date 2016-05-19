//
//  YKFourModuleCell.m
//  JJBetter
//
//  Created by yikang on 16/4/18.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKFourModuleCell.h"

@implementation YKFourModuleCell


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
    
    self.contentView.backgroundColor = YKGlobalBg;
    
    // 布局图片
    self.YKOneImageView = [[UIImageView alloc] init];
    self.YKOneImageView.image = [UIImage imageNamed:@"发现界面专业内容"];
    self.YKOneImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.YKOneImageView];
    
    self.YKTwoImageView = [[UIImageView alloc] init];
    self.YKTwoImageView.image = [UIImage imageNamed:@"发现界面专业内容"];
    self.YKTwoImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.YKTwoImageView];
    
    
    [self.YKOneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10 * WScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10 * WScale);
        make.right.mas_equalTo(self.YKTwoImageView.mas_left).offset(-10 * WScale);
        make.width.mas_equalTo(self.YKTwoImageView.mas_width);
        
    }];
    [self.YKTwoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.YKOneImageView.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.left.mas_equalTo(self.YKOneImageView.mas_right).offset(10 * WScale);
        make.width.mas_equalTo(self.YKOneImageView.mas_width);
        make.height.mas_equalTo(self.YKOneImageView.mas_height);
    }];
    
    
    
    // 布局图片上面的文字
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"这里有你需要的专业内容";
    label1.numberOfLines = 0;
    label1.textColor = YKffffff;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:14 * WScale];
    [self.YKOneImageView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.YKOneImageView.mas_centerY);
        make.left.mas_equalTo(self.YKOneImageView.mas_left).offset(20 * WScale);
        make.right.mas_equalTo(self.YKOneImageView.mas_right).offset(- 20 * WScale);
    }];

    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"留下你的问题康复师精心解答";
    label2.numberOfLines = 0;
    label2.textColor = YKffffff;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:14 * WScale];
    [self.YKTwoImageView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.YKTwoImageView.mas_centerY);
        make.left.mas_equalTo(self.YKTwoImageView.mas_left).offset(20 * WScale);
        make.right.mas_equalTo(self.YKTwoImageView.mas_right).offset(- 20 * WScale);
    }];
    
    
    
    
}









- (void)awakeFromNib
{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end

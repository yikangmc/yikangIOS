//
//  YKHotLabelItem.m
//  JJBetter
//
//  Created by yikang on 16/4/19.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKHotLabelItem.h"

@implementation YKHotLabelItem


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}


-(void)allViews
{
    
    UIImageView *image = [[UIImageView alloc] init];
    image.clipsToBounds = YES;
    image.layer.cornerRadius = 3 * WScale;
    image.image = [UIImage imageNamed:@"热门标签背景图"];
    [self.contentView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    
    self.hotItemLabel = [[UILabel alloc] init];
    self.hotItemLabel.textColor = [UIColor whiteColor];
    self.hotItemLabel.numberOfLines = 0;
    self.hotItemLabel.textAlignment = NSTextAlignmentCenter;
    self.hotItemLabel.font = [UIFont systemFontOfSize:11 * WScale];
    [image addSubview:self.hotItemLabel];
    [self.hotItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(image.mas_centerX);
        make.centerY.mas_equalTo(image.mas_centerY);
        make.left.mas_equalTo(image.mas_left).offset(2 * WScale);
        make.right.mas_equalTo(image.mas_right).offset(-2 * WScale);
    }];
    
    
    
}




@end

//
//  YKEditLabelSingleCell.m
//  JJBetter
//
//  Created by yikang on 16/5/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKEditLabelSingleCell.h"

@implementation YKEditLabelSingleCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self allViews];
        
    }
    return self;
}


-(void)allViews
{
    
    self.cellLabel = [[UILabel alloc] init];
    self.cellLabel.textAlignment = NSTextAlignmentCenter;
    self.cellLabel.backgroundColor = YKdcdcdc;
    self.cellLabel.textColor = YK323232;
    self.cellLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self.contentView addSubview:self.cellLabel];
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    
    self.cellImageView = [[UIImageView alloc] init];
    self.cellImageView.backgroundColor = [UIColor clearColor];
    [self.cellLabel addSubview:self.cellImageView];
    [self.cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cellLabel.mas_left);
        make.right.mas_equalTo(self.cellLabel.mas_right);
        make.top.mas_equalTo(self.cellLabel.mas_top);
        make.bottom.mas_equalTo(self.cellLabel.mas_bottom);
    }];
    
    
    self.redMoveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.redMoveBtn];
    [self.redMoveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cellImageView.mas_right).offset(-13 / 2 * WScale);
        make.top.mas_equalTo(self.cellImageView.mas_top).offset(-13 / 2 * WScale);
        make.height.mas_equalTo(13 * WScale);
        make.width.mas_equalTo(self.redMoveBtn.mas_height);
    }];
    
    
    
}







@end

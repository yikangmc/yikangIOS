//
//  CollectionReusableView.m
//  JJBetter
//
//  Created by yikang on 16/4/27.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 35 * HScale)];
    [self addSubview:self.imageView];
    
    self.label = [[UILabel alloc] init];
    self.label.textColor = YK1f1f1f;
    self.label.font = [UIFont systemFontOfSize:14 * WScale];
    [self.imageView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_left).offset(15 * WScale);
        make.bottom.mas_equalTo(self.imageView.mas_bottom);
        make.height.mas_equalTo(15 * HScale);
    }];
    
    
}









@end

//
//  YKShowSelectLabelItem.m
//  JJBetter
//
//  Created by yikang on 16/4/27.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKShowSelectLabelItem.h"

@implementation YKShowSelectLabelItem


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}



-(void)allViews
{

    self.labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.labelBtn.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height );
    self.labelBtn.clipsToBounds = YES;
    self.labelBtn.layer.cornerRadius = 4;
    [self.labelBtn setTitleColor:YK323232 forState:UIControlStateNormal];
    self.labelBtn.backgroundColor = YKdcdcdc;
    self.labelBtn.titleLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self.contentView addSubview:self.labelBtn];
    
    
}












@end

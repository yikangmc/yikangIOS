//
//  YKAllLabelItem.m
//  JJBetter
//
//  Created by yikang on 16/4/20.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKAllLabelItem.h"

@interface YKAllLabelItem ()

@end

@implementation YKAllLabelItem


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self allViews];
    }
    return self;
}


- (void)allViews
{
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = YK656565;
    [titleLabel setFont:[UIFont systemFontOfSize:13 * WScale]];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // 可以设置选中的状态
//    UIView *selectView = [[UIView alloc] init];
//    selectView.backgroundColor = [UIColor redColor];
//    self.selectedBackgroundView = selectView;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.titleLabel.frame = CGRectMake(0, 0, width, height);
}

-(void)setTitleName:(NSString *)titleName
{
    if (self.titleName != titleName) {
        _titleName = titleName;
        [_titleLabel setText:titleName];
    }
}



@end

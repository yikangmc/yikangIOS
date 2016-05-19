//
//  YKTwoLabelImageView.m
//  JJBetter
//
//  Created by yikang on 16/4/4.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKTwoLabelImageView.h"

@implementation YKTwoLabelImageView



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}


-(void)allViews
{
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 2 / 3)];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.userInteractionEnabled = YES;
    [self addSubview:self.numberLabel];
    
    
    self.wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 2 / 3, self.frame.size.width, self.frame.size.height / 3)];
    self.wordLabel.textAlignment = NSTextAlignmentCenter;
    self.wordLabel.userInteractionEnabled = YES;
    [self addSubview:self.wordLabel];
    
    
}




@end

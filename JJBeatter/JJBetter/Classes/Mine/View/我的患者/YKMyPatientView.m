//
//  YKMyPatientView.m
//  JJBetter
//
//  Created by yikang on 16/4/4.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKMyPatientView.h"
#import "YKTwoLabelImageView.h"

@implementation YKMyPatientView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}


// 布局子视图
-(void)allViews
{
    // 上面视图
    UIView *oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 165 * WScale)];
    oneView.backgroundColor = YK23149252Color;
    [self addSubview:oneView];
    
    
    self.centerView = [[YKTwoLabelImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, oneView.frame.size.height / 2)];
    self.centerView.center = CGPointMake(oneView.frame.size.width / 2, oneView.frame.size.height / 2);
    self.centerView.numberLabel.font = [UIFont systemFontOfSize:60 * WScale];
    self.centerView.numberLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.centerView.wordLabel.font = [UIFont systemFontOfSize:13 * WScale];
    self.centerView.wordLabel.textColor = [UIColor colorWithRed:254/255.0 green:254/255.0 blue:254/255.0 alpha:1.0];
    self.centerView.wordLabel.text = @"患者总数";
    [oneView addSubview:self.centerView];
    
    
    
    // 下面视图
    self.twoView = [[UIView alloc] initWithFrame:CGRectMake(0, 165 * WScale, ScreenW, 63 * WScale)];
    self.twoView.backgroundColor = [UIColor colorWithRed:23/255.0 green:149/255.0 blue:252/255.0 alpha:1.0];
    self.twoView.alpha = 0.86;
    [self addSubview:self.twoView];
    
    
    self.leftView = [[YKTwoLabelImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW / 3, self.twoView.frame.size.height * 2/ 3)];
    self.leftView.center = CGPointMake(self.twoView.frame.size.width / 4, self.twoView.frame.size.height / 2);
    self.leftView.userInteractionEnabled = YES;
    self.leftView.numberLabel.font = [UIFont systemFontOfSize:24 * WScale];
    self.leftView.numberLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.leftView.wordLabel.text = @"仅注册患者";
    self.leftView.wordLabel.font = [UIFont systemFontOfSize:10 * WScale];
    self.leftView.wordLabel.textColor = [UIColor colorWithRed:254/255.0 green:254/255.0 blue:254/255.0 alpha:1.0];
    [self.twoView addSubview:self.leftView];
    
    
    self.rightView = [[YKTwoLabelImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW / 3 , self.twoView.frame.size.height * 2/ 3)];
    self.rightView.center = CGPointMake(self.twoView.frame.size.width * 3 / 4, self.twoView.frame.size.height / 2);
    self.rightView.userInteractionEnabled = YES;
    self.rightView.numberLabel.font = [UIFont systemFontOfSize:24 * WScale];
    self.rightView.numberLabel.textColor = [UIColor colorWithRed:254/255.0 green:254/255.0 blue:254/255.0 alpha:1.0];
    self.rightView.wordLabel.text = @"服务中患者";
    self.rightView.wordLabel.font = [UIFont systemFontOfSize:10 * WScale];
    self.rightView.wordLabel.textColor = [UIColor colorWithRed:254/255.0 green:254/255.0 blue:254/255.0 alpha:1.0];
    [self.twoView addSubview:self.rightView];
    
    
    // 下面小三角
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10 * WScale, 10 * WScale)];
    self.leftImageView.center = CGPointMake(self.twoView.frame.size.width / 4, self.twoView.frame.size.height - 10 + 6);
    self.leftImageView.image = [UIImage imageNamed:@"sanjiao"];
    [self.twoView addSubview:self.leftImageView];
    
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10 * WScale, 10 * WScale)];
    self.rightImageView.center = CGPointMake(self.twoView.frame.size.width * 3/ 4, self.twoView.frame.size.height - 10 + 6);
    self.rightImageView.hidden = YES;
    self.rightImageView.image = [UIImage imageNamed:@"sanjiao"];
    [self.twoView addSubview:self.rightImageView];
    
    
    
}









@end

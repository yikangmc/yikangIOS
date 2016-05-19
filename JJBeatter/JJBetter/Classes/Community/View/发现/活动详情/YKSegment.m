//
//  YKSegment.m
//  JJBetter
//
//  Created by yikang on 16/5/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKSegment.h"

@implementation YKSegment

#pragma mark  ----  初始化  -----
- (id)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (NSMutableArray *)buttonList
{
    if (!_buttonList)
    {
        _buttonList = [NSMutableArray array];
    }
    return _buttonList;
}

- (NSMutableArray *)titleList
{
    if (!_titleList)
    {
        _titleList = [NSMutableArray array];
    }
    return _titleList;
}

-(void)commonInit
{
    //按钮名称
    NSMutableArray *titleList = [[NSMutableArray alloc]initWithObjects:@"活动详情",@"聊天互动", nil];
    
    self.titleList = titleList;
    
    [self createItem:self.titleList];
    
    [self buttonList];
}

+ (instancetype)initWithTitleList:(NSMutableArray *)titleList
{
    YKSegment *segment = [[YKSegment alloc]initWithTitleList:titleList];
    segment.titleList = titleList;
    return segment;
}



- (void)createItem:(NSMutableArray *)item
{
    
    int count = (int)self.titleList.count;
    CGFloat marginX = (ScreenW - count * 60 * WScale)/(count + 1);
    for (int i = 0; i<count; i++) {
        
        NSString *temp = [self.titleList objectAtIndex:i];
        //按钮的X坐标计算，i为列数
        CGFloat buttonX = marginX + i * (60 * WScale + marginX);
        
        UIButton *buttonItem = [[UIButton alloc] initWithFrame:CGRectMake(80 * WScale + i * 185 * WScale, 0, 70 * WScale, self.frame.size.height)];
        //设置
        buttonItem.tag = i + 1;
        buttonItem.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
        [buttonItem setTitle:temp forState:UIControlStateNormal];
        [buttonItem setTitleColor:YK333333 forState:UIControlStateNormal];
        [buttonItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem];
        
        [_buttonList addObject:buttonItem];
        
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = 80 + i;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"活动详情%d",i]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(buttonItem.mas_left).offset(-9 * WScale);
            make.centerY.mas_equalTo(buttonItem.mas_centerY);
            make.width.mas_equalTo(16 * WScale);
            make.height.mas_equalTo(imageView.mas_width);
        }];
        
        //第一个按钮默认被选中
        if (i == 0) {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"活动详情（点击）%d",i]];
            CGFloat firstX = buttonX ;
            [buttonItem setTitleColor:YK1795fc forState:UIControlStateNormal];
            [self creatBanner:firstX];
        }
        
        buttonX += marginX;
    }
    
}

-(void)creatBanner:(CGFloat)firstX
{
    //初始化
    CALayer *LGLayer = [[CALayer alloc] init];
    LGLayer.backgroundColor = YK0faadd.CGColor;
    LGLayer.frame = CGRectMake(firstX, self.frame.size.height - 2, 135 * WScale, 2);
    // 设定它的frame
    [self.layer addSublayer:LGLayer]; // 增加到UIView的layer上面
    self.LGLayer = LGLayer;
    
}

-(void)buttonClick:(id)sender
{
    //获取被点击按钮
    UIButton *btn = (UIButton *)sender;
    
    [btn setTitleColor:YK1795fc forState:UIControlStateNormal];
    
    UIButton *bt1 = (UIButton *)[self viewWithTag:1];
    UIButton *bt2 = (UIButton *)[self viewWithTag:2];
    
    CGFloat bannerX = btn.center.x;
    
    [self bannerMoveTo:bannerX];
    
    switch (btn.tag) {
        case 1:
            [self didSelectButton:bt1];
            [self.delegate scrollToPage:0];
            break;
        case 2:
            [self didSelectButton:bt2];
            [self.delegate scrollToPage:1];
            break;
            
        default:
            break;
    }
    
    
}

-(void)moveToOffsetX:(CGFloat)offsetX
{
    
    UIButton *bt1 = (UIButton *)[self viewWithTag:1];
    UIButton *bt2 = (UIButton *)[self viewWithTag:2];
    
    CGFloat bannerX = bt1.center.x;
    CGFloat offSet = offsetX;
    CGFloat addX = offSet / ScreenW * (bt2.center.x - bt1.center.x);
    
    bannerX += addX - 15 * WScale;
    
    [self bannerMoveTo:bannerX];
    
    CGFloat off = offsetX / ScreenW;
    if (off == 0) {
        [self didSelectButton:bt1];
    }else if (off == 1){
        [self didSelectButton:bt2];
    }
    
}

-(void)bannerMoveTo:(CGFloat)bannerX
{
    //基本动画，移动到点击的按钮下面
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    pathAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(bannerX, 100)];
    //组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:pathAnimation, nil];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.duration = 0.3;
    //设置代理
    animationGroup.delegate = self;
    //1.3设置动画执行完毕后不删除动画
    animationGroup.removedOnCompletion=NO;
    //1.4设置保存动画的最新状态
    animationGroup.fillMode=kCAFillModeForwards;
    
    //监听动画
    [animationGroup setValue:@"animationStep1" forKey:@"animationName"];
    //动画加入到changedLayer上
    [_LGLayer addAnimation:animationGroup forKey:nil];
}


//点击按钮后改变字体颜色
-(void)didSelectButton:(UIButton*)Button
{
    
    UIButton *bt1 = (UIButton *)[self viewWithTag:1];
    UIButton *bt2 = (UIButton *)[self viewWithTag:2];
    
    UIImageView *imageView1 = [self viewWithTag:80];
    UIImageView *imageView2 = [self viewWithTag:81];
    
    UIButton *btn = Button;
    
    switch (btn.tag) {
        case 1:
            imageView1.image = [UIImage imageNamed:@"活动详情（点击）0"];
            imageView2.image = [UIImage imageNamed:@"活动详情1"];
            [bt1 setTitleColor:YK1795fc forState:UIControlStateNormal];
            [bt2 setTitleColor:YK333333 forState:UIControlStateNormal];
            break;
        case 2:
            imageView1.image = [UIImage imageNamed:@"活动详情0"];
            imageView2.image = [UIImage imageNamed:@"活动详情（点击）1"];
            [bt1 setTitleColor:YK333333 forState:UIControlStateNormal];
            [bt2 setTitleColor:YK1795fc forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}








@end

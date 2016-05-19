//
//  YKGoodAtVC.h
//  JJBetter
//
//  Created by yikang on 16/4/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "BtnView.h"

@implementation BtnView

-(UIView *)creatBtnWithArray:(NSArray *)dataArr{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 30 * WScale, ScreenW, (ScreenH - 30 * WScale) * WScale)];
    view.backgroundColor = [UIColor clearColor];
    int width = 0;
    int height = 0;
    self.number = 0;
    int han = 0;

    // 创建button
    for (int i = 0; i <dataArr.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
        CGSize titleSize = [dataArr[i] boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 * WScale]} context:nil].size;
        titleSize.width += 25;
        
        // 自动的折行
        han = han + titleSize.width + 25 * WScale;
        if (han > [[UIScreen mainScreen]bounds].size.width) {
            han = 0;
            han = han + titleSize.width + 25 * WScale;
            height++;
            width = 0;
            width = width+titleSize.width + 10 * WScale;
            self.number = 0;
            button.frame = CGRectMake(10, 10 + 40 * height, titleSize.width + 10, 25);
        }else{
            button.frame = CGRectMake(width + 10 + (self.number * 10), 10 + 40 * height, titleSize.width + 10, 25);
            width = width + titleSize.width + 10 * WScale;
        }
        self.number++;
        button.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
        
        // 设置边框
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 2;
        button.layer.borderWidth = 0.5;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){23/255.0,149/255.0,252/255.0,1});
        [button.layer setBorderColor:color];
        
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:YK23149252Color forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitle:dataArr[i] forState:UIControlStateNormal];
        [view addSubview:button];
        
    }
    
    return view;
    
}






@end




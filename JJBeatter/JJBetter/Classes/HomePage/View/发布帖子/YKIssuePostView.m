//
//  YKIssuePostView.m
//  JJBetter
//
//  Created by yikang on 16/4/27.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKIssuePostView.h"

@interface YKIssuePostView ()

@property (nonatomic,strong)UILabel *label;  // 为帖子添加标签

@end

@implementation YKIssuePostView

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
    
    self.whiteBackView = [[UIView alloc] init];
    self.whiteBackView.backgroundColor = [UIColor whiteColor];
    self.whiteBackView.userInteractionEnabled = YES;
    [self addSubview:self.whiteBackView];
    [self.whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10 * HScale);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(315 * HScale);
    }];
    
    // 输入框
    self.textView = [[UITextView alloc] init];
    self.textView.textColor = YK505050;
    self.textView.font = [UIFont systemFontOfSize:13 * WScale];
    self.textView.userInteractionEnabled = YES;
    self.textView.backgroundColor = [UIColor whiteColor];
    [self.whiteBackView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteBackView.mas_top).offset(15 * HScale);
        make.left.mas_equalTo(self.whiteBackView.mas_left).offset(19 * WScale);
        make.right.mas_equalTo(self.whiteBackView.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(210 * HScale);
    }];
    
    
    self.label = [[UILabel alloc] init];
    self.label.text = @"为帖子添加标签";
    self.label.textColor = YK1f1f1f;
    self.label.font = [UIFont systemFontOfSize:13 * WScale];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteBackView.mas_bottom).offset(19 * HScale);
        make.left.mas_equalTo(self.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(14 * HScale);
    }];
    
    
    // 添加标签
    self.addLabelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addLabelBtn setBackgroundImage:[UIImage imageNamed:@"添加标签"] forState:UIControlStateNormal];
    [self addSubview:self.addLabelBtn];
    [self.addLabelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_bottom).offset(17 * HScale);
        make.left.mas_equalTo(self.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(14 * HScale);
        make.width.mas_equalTo(self.addLabelBtn.mas_height);
    }];
    
    
}


// 添加一个方法(添加标签)
-(void)creatLabelViewWithArray:(NSArray *)dataArr
{
    int number = 0;
    int width = 0;
    
    for (int i = 0; i < dataArr.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.text = dataArr[i];
        label.textColor = YK323232;
        label.backgroundColor = YKdcdcdc;
        label.font = [UIFont systemFontOfSize:12 * WScale];
        label.textAlignment = NSTextAlignmentCenter;

        // 获取字体宽度
        CGSize size = CGSizeMake(0, 14 * HScale);
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12 * WScale]};
        CGRect rect = [dataArr[i] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        number++;
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.label.mas_bottom).offset(14 * HScale);
            make.width.mas_equalTo(rect.size.width + 10);
            make.left.mas_equalTo(self.mas_left).offset(width + 5 + (number * 10));
            make.height.mas_equalTo(20 * HScale);
            
        }];
        width = width + rect.size.width + 10;
        
        if (i == dataArr.count - 1) {
            [self.addLabelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(120 * WScale);
                make.top.mas_equalTo(self.label.mas_top);
            }];
        }
        
    }
}






-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView endEditing:YES];
}



@end

//
//  YKIntroduceView.m
//  JJBetter
//
//  Created by yikang on 16/5/16.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKIntroduceView.h"

@interface YKIntroduceView ()<UITextViewDelegate>

@property (nonatomic,strong)UILabel *label;  // 已输入字数显示

@end

@implementation YKIntroduceView


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
    self.backgroundColor = YKGlobalBg;
    
    UIView *white = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 156 * WScale)];
    white.backgroundColor = [UIColor whiteColor];
    [self addSubview:white];

    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.text = @"简单的介绍下自己吧~";
    self.textView.textColor = YK505050;
    self.textView.font = [UIFont systemFontOfSize:12 * WScale];
    [white addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(white.mas_top).offset(1 * WScale);
        make.left.mas_equalTo(white.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(white.mas_right).offset(-15 * WScale);
        make.height.mas_equalTo(90 * WScale);
    }];
    
    
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentRight;
    self.label.text = @"已输入0/30字";
    self.label.textColor = YK505050;
    self.label.font = [UIFont systemFontOfSize:12 * WScale];
    [white addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(white.mas_right).offset(-15 * WScale);
        make.bottom.mas_equalTo(white.mas_bottom).offset(-9 * WScale);
        make.width.mas_equalTo(200 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
}


// textView代理方法
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.textView.text isEqualToString:@"简单的介绍下自己吧~"]) {
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length < 1) {
        textView.text = @"简单的介绍下自己吧~";
    }
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length > 30) {
        
        // 将超出限制数设置为红色
        self.label.text = [NSString stringWithFormat:@"已输入%ld/30字",self.textView.text.length];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.label.text];
        [str addAttribute:NSForegroundColorAttributeName value:YKff2e2e range:NSMakeRange(3 , self.label.text.length - 7)];
        self.label.attributedText = str;
        
    }else {
        
        self.label.text = [NSString stringWithFormat:@"已输入%ld/30字",self.textView.text.length];
    }
    
}





@end

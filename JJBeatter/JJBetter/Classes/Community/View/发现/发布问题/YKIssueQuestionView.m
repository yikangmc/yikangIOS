//
//  YKIssueQuestionView.m
//  JJBetter
//
//  Created by yikang on 16/5/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKIssueQuestionView.h"

@interface YKIssueQuestionView ()<UITextViewDelegate>
@property (nonatomic,strong)UILabel *label;  // 问题默认标签
@end

@implementation YKIssueQuestionView


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
    UIView *topWhite = [[UIView alloc] init];
    topWhite.backgroundColor = [UIColor whiteColor];
    [self addSubview:topWhite];
    [topWhite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top).offset(10 * HScale);
        make.height.mas_equalTo(45 * HScale);
    }];
    
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(24 * WScale, 0, 350 * WScale, 45 * HScale)];
    self.textField.textColor = YK505050;
    self.textField.font = [UIFont systemFontOfSize:13 * WScale];
    self.textField.placeholder = @"填写你的问题（必填）";
    self.textField.backgroundColor = [UIColor whiteColor];
    [topWhite addSubview:self.textField];
    
    
    self.whiteBackView = [[UIView alloc] init];
    self.whiteBackView.backgroundColor = [UIColor whiteColor];
    self.whiteBackView.userInteractionEnabled = YES;
    [self addSubview:self.whiteBackView];
    [self.whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topWhite.mas_bottom).offset(10 * HScale);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(315 * HScale);
    }];
    
    
    // 输入框
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.text = @"填写你的问题描述（选填）";
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
    self.label.text = @"问题默认标签";
    self.label.textColor = YK323232;
    self.label.font = [UIFont systemFontOfSize:12 * WScale];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteBackView.mas_bottom).offset(19 * HScale);
        make.left.mas_equalTo(self.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
    // 添加默认标签
    self.defaultLabel = [[UILabel alloc] init];
    self.defaultLabel.textAlignment = NSTextAlignmentCenter;
    self.defaultLabel.textColor = [UIColor whiteColor];
    self.defaultLabel.font = [UIFont systemFontOfSize:12 * WScale];
    self.defaultLabel.backgroundColor = YK0faadd;
    [self addSubview:self.defaultLabel];
    [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.label.mas_left);
        make.top.mas_equalTo(self.label.mas_bottom).offset(8 * WScale);
        make.height.mas_equalTo(20 * WScale);
    }];

    
    
}


/** 默认标签自适应宽度 */
+(CGFloat)widthForDefaultLabel:(NSString *)defaultLabel
{
    CGSize size = CGSizeMake(0, 15 * WScale);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12 * WScale]};
    CGRect rect = [defaultLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width + 10 * WScale;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}


// textView代理方法
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.textView.text isEqualToString:@"填写你的问题描述（选填）"]) {
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length < 1) {
        textView.text = @"填写你的问题描述（选填）";
    }
}







@end

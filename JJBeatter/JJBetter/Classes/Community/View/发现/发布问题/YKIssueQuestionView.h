//
//  YKIssueQuestionView.h
//  JJBetter
//
//  Created by yikang on 16/5/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKIssueQuestionView : UIView

@property (nonatomic,strong)UITextField *textField;  //问题输入框
@property (nonatomic,strong)UIView *whiteBackView;  // 方便添加照片布局外部调用
@property (nonatomic,strong)UITextView *textView;  // 输入内容（描述）
@property (nonatomic,strong)UILabel *defaultLabel;  // 默认标签

/** 默认标签自适应宽度 */
+(CGFloat)widthForDefaultLabel:(NSString *)defaultLabel;



@end

//
//  YKIssuePostView.h
//  JJBetter
//
//  Created by yikang on 16/4/27.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKIssuePostView : UIView


@property (nonatomic,strong)UIView *whiteBackView;
@property (nonatomic,strong)UITextView *textView;  // 输入内容
@property (nonatomic,strong)UIButton *addLabelBtn;  // 添加标签



// 添加一个方法(添加标签)
-(void)creatLabelViewWithArray:(NSArray *)dataArr;





@end

//
//  YKUpdateWordSpace.m
//  JJBetter
//
//  Created by yikang on 16/4/22.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKUpdateWordSpace.h"

@implementation YKUpdateWordSpace


/**
 *  调整行间距
 */
+(void)updateLineSpaceWithLabel:(UILabel *)label
                     
{
    if (label.text.length) {
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:label.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:3 * WScale];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [label.text length])];
        [label setAttributedText:attributedString1];
        [label sizeToFit];
    }
    
}



@end

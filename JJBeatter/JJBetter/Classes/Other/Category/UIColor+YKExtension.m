//
//  UIColor+YKExtension.m
//  deals
//
//  Created by 马文帅 on 5/31/15.
//  Copyright (c) 2015 yikang. All rights reserved.
//

#import "UIColor+YKExtension.h"

@implementation UIColor (YKExtension)

+ (UIColor *)yk_colorWithHex:(NSInteger)hexColor {
    return [UIColor colorWithRed:((hexColor & 0xFF0000) >> 16)/255.0
                           green:((hexColor & 0x00FF00) >> 8) /255.0
                            blue:( hexColor & 0x0000FF)       /255.0
                           alpha:1.0];
}
@end

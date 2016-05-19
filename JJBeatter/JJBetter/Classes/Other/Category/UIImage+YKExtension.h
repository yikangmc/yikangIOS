//
//  UIImage+YKExtension.h
//  deals
//
//  Created by 李洋 on 5/31/15.
//  Copyright (c) 2015 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage (YKExtension)

+ (instancetype)yk_imageForDeviceWithName:(NSString *)fileName;


- (UIImage *)yk_scaleToSize:(CGSize)size;


- (UIImage *)yk_circleImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


@end


//
//  UIImage+YKExtension.m
//  deals
//
//  Created by 李洋 on 5/31/15.
//  Copyright (c) 2015 yikang. All rights reserved.
//
#import "UIImage+YKExtension.h"

@implementation UIImage (YKExtension)


typedef NS_ENUM(NSInteger, DeviceClass) {
    DeviceClass_iPhone,
    DeviceClass_iPhone5,
    DeviceClass_iPhone6,
    DeviceClass_iPhone6plus,
    DeviceClass_unknown
};

DeviceClass currentDeviceClass() {

    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat greaterPixelDimension = screenHeight > screenWidth ? screenHeight : screenWidth;

    switch ((NSInteger)greaterPixelDimension) {
        case 480:
            return DeviceClass_iPhone;
            break;
        case 568:
            return DeviceClass_iPhone5;
            break;
        case 667:
            return DeviceClass_iPhone6;
            break;
        case 736:
            return DeviceClass_iPhone6plus;
            break;
        default:
            return DeviceClass_unknown;
            break;
    }
}


+ (instancetype )yk_imageForDeviceWithName:(NSString *)fileName
{
    UIImage *result = nil;
    NSString *nameWithSuffix = [fileName stringByAppendingString:[UIImage yk_magicSuffixForDevice]];

    result = [UIImage imageNamed:nameWithSuffix];

    if (!result) {
        result = [UIImage imageNamed:fileName];
    }
    return result;
}

#pragma mark - private methods
+ (NSString *)yk_magicSuffixForDevice
{
    switch (currentDeviceClass()) {
        case DeviceClass_iPhone:
            return @"_480h";
            break;
        case DeviceClass_iPhone5:
            return @"_568h"; //只是个命名约定
            break;
        case DeviceClass_iPhone6:
            return @"_667h"; //只是个命名约定
            break;
        case DeviceClass_iPhone6plus:
            return @"_736h"; //主要是防止以后出现其他尺寸不同的@3x的设备，不然可以和不带后缀的放一起
            break;
        case DeviceClass_unknown:
        default:
            return @"";
            break;
    }
}

- (UIImage *)yk_scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)yk_circleImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    CGFloat imageW = self.size.width + 2 * borderWidth;
    CGFloat imageH = self.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 大圆
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 画图
    [self drawInRect:CGRectMake(borderWidth, borderWidth, self.size.width, self.size.height)];
    
    // 取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end

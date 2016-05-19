//
// QR Code Generator - generates UIImage from NSString
//
// Copyright (C) 2012 http://moqod.com Andrew Kopanev <andrew@moqod.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal 
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
// of the Software, and to permit persons to whom the Software is furnished to do so, 
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all 
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.
//

#import "QRCodeGenerator.h"
#import <qrencode.h>

enum {
	qr_margin = 3
};

@implementation QRCodeGenerator

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size {
	unsigned char *data = 0;
	int width;
	data = code->data;
	width = code->width;
	float zoom = (double)size / (code->width + 2.0 * qr_margin);
	CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
	
	// draw
	CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
	for(int i = 0; i < width; ++i) {
		for(int j = 0; j < width; ++j) {
			if(*data & 1) {
                
				rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
				CGContextAddRect(ctx, rectDraw);
			}
			++data;
		}
	}
	CGContextFillPath(ctx);
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size {
	if (![string length]) {
		return nil;
	}
	/*
    typedef enum {
        QR_ECLEVEL_L = 0, ///< lowest
        QR_ECLEVEL_M,
        QR_ECLEVEL_Q,
        QR_ECLEVEL_H      ///< highest
     } QRecLevel;
     这个枚举，很清楚把，最高，缺省率可以高达30%，就是你选择了最高编码等级，所以我们就可以在二维码中间贴上一张 图片也不影响使用，但是如果你选择最低的，那么缺省只能达到5左右，但是越低，扫瞄速度越快，越高，意味着你的二维码也越复杂，增加扫瞄难度，所以如何权衡，看自己
     */
	QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_M, QR_MODE_8, 1);
	if (!code) {
		return nil;
	}
	
	// create context
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
	
	CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
	CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
	CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
	
	// draw QR on this context	
	[QRCodeGenerator drawQRCode:code context:ctx size:size];
	
	// get image
	CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
	UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
	
	// some releases
	CGContextRelease(ctx);
	CGImageRelease(qrCGImage);
	CGColorSpaceRelease(colorSpace);
	QRcode_free(code);
	
	return qrImage;
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size centerImage:(UIImage *)centerImage {
    if (![string length]) {
        return nil;
    }
    /*
     typedef enum {
     QR_ECLEVEL_L = 0, ///< lowest
     QR_ECLEVEL_M,
     QR_ECLEVEL_Q,
     QR_ECLEVEL_H      ///< highest
     } QRecLevel;
     这个枚举，很清楚把，最高，缺省率可以高达30%，就是你选择了最高编码等级，所以我们就可以在二维码中间贴上一张 图片也不影响使用，但是如果你选择最低的，那么缺省只能达到5左右，但是越低，扫瞄速度越快，越高，意味着你的二维码也越复杂，增加扫瞄难度，所以如何权衡，看自己
     */
    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_Q, QR_MODE_8, 1);
    if (!code) {
        return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    // draw QR on this context
    [QRCodeGenerator drawQRCode:code context:ctx size:size];
    
    //中间加个图片
    CGFloat width = size*0.3;
    CGRect rect = CGRectMake(size/2-width/2, size/2-width/2, width, width);
    
    CGContextDrawImage(ctx, rect, [centerImage CGImage]);
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
}

@end

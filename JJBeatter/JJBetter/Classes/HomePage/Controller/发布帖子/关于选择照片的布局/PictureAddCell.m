//
//  PictureAddCell.m
//  类似QQ图片添加、图片浏览
//
//  Created by seven on 16/3/31.
//  Copyright © 2016年 QQpicture. All rights reserved.
//

#import "PictureAddCell.h"

@implementation PictureAddCell


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.addImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.addImageView];

    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addImageView.frame = CGRectMake(0, 0, 60 * HScale, 60 * HScale);
    self.addImageView.image = [UIImage imageNamed:@"添加照片.png"];
    
}




@end

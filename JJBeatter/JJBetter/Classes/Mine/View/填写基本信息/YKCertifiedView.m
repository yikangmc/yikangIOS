//
//  YKCertifiedView.m
//  JJBetter
//
//  Created by yikang on 16/5/16.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKCertifiedView.h"

@implementation YKCertifiedView


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
    
    UIView *white = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 260 * WScale)];
    white.backgroundColor = [UIColor whiteColor];
    [self addSubview:white];
    
    
    self.photoImageView = [[UIImageView alloc] init];
    self.photoImageView.backgroundColor = [UIColor yellowColor];
    [white addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(white.mas_top).offset(10 * WScale);
        make.left.mas_equalTo(white.mas_left).offset(20 * WScale);
        make.right.mas_equalTo(white.mas_right).offset(-20 * WScale);
        make.bottom.mas_equalTo(white.mas_bottom).offset(-11 * WScale);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请上传真实、清晰度较高的执业证书图片，有助于加大您审核的通过率~";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = YKb2b2b2;
    label.font = [UIFont systemFontOfSize:12 * WScale];
    label.numberOfLines = 0;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-27 * WScale);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(265 * WScale);
        make.height.mas_equalTo(30 * WScale);
    }];
    
    
    self.uploadingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.uploadingBtn setBackgroundImage:[UIImage imageNamed:@"globalButtonbg"] forState:UIControlStateNormal];
    [self.uploadingBtn setTitle:@"上传执业证书" forState:UIControlStateNormal];
    self.uploadingBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.uploadingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.uploadingBtn];
    [self.uploadingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(25 * WScale);
        make.right.mas_equalTo(self.mas_right).offset(-25 * WScale);
        make.height.mas_equalTo(35 * WScale);
        make.bottom.mas_equalTo(label.mas_top).offset(-8 * WScale);
    }];
    
    
}




@end

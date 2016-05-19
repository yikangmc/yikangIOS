//
//  YKBaseVC.m
//  JJBetter
//
//  Created by 李洋 on 16/3/15.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKBaseVC.h"

@interface YKBaseVC ()
@property (nonatomic, strong) UILabel *warnLabel;
@end

@implementation YKBaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = YKGlobalBg;
    [self setupErrorView];
    
    
}

/** 布局错误view */
- (void)setupErrorView {
    [self.view addSubview:self.errorImageView];
    [self.view addSubview:self.errorLabel];
}

- (void)setIsError:(BOOL)isError
{
    _isError = isError;
    self.errorImageView.hidden = !isError;
    self.errorLabel.hidden = !isError;
    if (isError) {
        [self.view addGestureRecognizer:self.tap];
        self.errorLabel.text = @"网络不给力，请检查网络后点击刷新";
        self.errorImageView.image = [UIImage imageNamed:@"error_image"];
    } else {
        [self.view removeGestureRecognizer:self.tap];
    }
    
}


- (void)setIsNil:(BOOL)isNil
{
    _isNil = isNil;
    self.errorImageView.hidden = !isNil;
    self.errorLabel.hidden = !isNil;
    if (isNil) {
        [self.view addGestureRecognizer:self.tap];
        self.errorLabel.text = @"您暂时没有该项数据";
        self.errorImageView.image = [UIImage imageNamed:@"error_noData"];
    } else {
        [self.view removeGestureRecognizer:self.tap];
    }
}

- (void)taped:(UIGestureRecognizer *)tap {
    
}

#pragma mark - lazy loading
- (UILabel *)warnLabel {
    if (!_warnLabel) {
        _warnLabel = [[UILabel alloc] init];
        _warnLabel.center = CGPointMake(self.view.center.x, self.view.frame.size.height-50);
        _warnLabel.bounds = CGRectMake(0, 0, 100, 30);
        _warnLabel.backgroundColor = [UIColor blackColor];
        _warnLabel.alpha = 0.7;
        _warnLabel.layer.cornerRadius = 10;
    }
    return _warnLabel;
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
    }
    return _tap;
}

- (UIImageView *)errorImageView {
    if (!_errorImageView) {
        _errorImageView = [[UIImageView alloc] init];
        _errorImageView.center = CGPointMake(self.view.center.x, self.view.center.y-80);
        _errorImageView.bounds = CGRectMake(0, 0, 110, 140);
        _errorImageView.hidden = YES;
        _errorImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _errorImageView;
}

- (UILabel *)errorLabel {
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.view.center.y-20, self.view.frame.size.width-80, 60)];
        _errorLabel.textColor = [UIColor lightGrayColor];
        _errorLabel.numberOfLines = 0;
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.font = [UIFont systemFontOfSize:15];
        _errorLabel.hidden = YES;
    }
    return _errorLabel;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}








@end


//
//  YKProfessionDetailView.m
//  JJBetter
//
//  Created by yikang on 16/5/6.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKProfessionDetailView.h"

@implementation YKProfessionDetailView


// 分享弹框
-(void)creatShareAlertView
{
    
    self.grayBackView = [[UIView alloc] init];
    self.grayBackView.backgroundColor = [UIColor blackColor];
    self.grayBackView.hidden = YES;
    self.grayBackView.alpha = 0.2;
    [self addSubview:self.grayBackView];
    [self.grayBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    
    // 分享弹框
    self.shareBackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame)+ 64, ScreenW, 234 * WScale)];
    self.shareBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.shareBackView];
    
    
    UILabel *shareLabel = [[UILabel alloc] init];
    shareLabel.text = @"分享这个专业内容";
    shareLabel.textColor = YK333333;
    shareLabel.font = [UIFont systemFontOfSize:15 * WScale];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareBackView addSubview:shareLabel];
    [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shareBackView.mas_top).offset(15 * WScale);
        make.centerX.mas_equalTo(self.shareBackView.mas_centerX);
        make.height.mas_equalTo(16 * WScale);
    }];
    
    
    // 需要分享的社交平台 (微信)
    self.weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weixinBtn setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [self.shareBackView addSubview:self.weixinBtn];
    [self.weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shareBackView.mas_centerX);
        make.top.mas_equalTo(shareLabel.mas_bottom).offset(20 * WScale);
        make.height.mas_equalTo(46 * WScale);
        make.width.mas_equalTo(self.weixinBtn.mas_height);
    }];
    
    UILabel *weixinLabel = [[UILabel alloc] init];
    weixinLabel.text = @"微信好友";
    weixinLabel.textColor = YK646464;
    weixinLabel.font = [UIFont systemFontOfSize:13 * WScale];
    weixinLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareBackView addSubview:weixinLabel];
    [weixinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shareBackView.mas_centerX);
        make.top.mas_equalTo(self.weixinBtn.mas_bottom).offset(7.5 * WScale);
        make.height.mas_equalTo(14 * WScale);
    }];
    
    
    // 微博
    self.weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weiboBtn setBackgroundImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
    [self.shareBackView addSubview:self.weiboBtn];
    [self.weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shareBackView.mas_left).offset(62 * WScale);
        make.top.mas_equalTo(self.weixinBtn.mas_top);
        make.height.mas_equalTo(46 * WScale);
        make.width.mas_equalTo(self.weiboBtn.mas_height);
    }];
    
    UILabel *weiboLabel = [[UILabel alloc] init];
    weiboLabel.text = @"新浪微博";
    weiboLabel.textColor = YK646464;
    weiboLabel.font = [UIFont systemFontOfSize:13 * WScale];
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareBackView addSubview:weiboLabel];
    [weiboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.weiboBtn.mas_centerX);
        make.top.mas_equalTo(self.weiboBtn.mas_bottom).offset(7.5 * WScale);
        make.height.mas_equalTo(14 * WScale);
    }];
    
    
    // 微信朋友圈
    self.weixinCircleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weixinCircleBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈"] forState:UIControlStateNormal];
    [self.shareBackView addSubview:self.weixinCircleBtn];
    [self.weixinCircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.shareBackView.mas_right).offset(-62 * WScale);
        make.top.mas_equalTo(self.weixinBtn.mas_top);
        make.height.mas_equalTo(46 * WScale);
        make.width.mas_equalTo(self.weixinCircleBtn.mas_height);
    }];
    
    UILabel *weixinCircleLabel = [[UILabel alloc] init];
    weixinCircleLabel.text = @"微信朋友圈";
    weixinCircleLabel.textColor = YK646464;
    weixinCircleLabel.font = [UIFont systemFontOfSize:13 * WScale];
    weixinCircleLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareBackView addSubview:weixinCircleLabel];
    [weixinCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.weixinCircleBtn.mas_centerX);
        make.top.mas_equalTo(self.weixinCircleBtn.mas_bottom).offset(7.5 * WScale);
        make.height.mas_equalTo(14 * WScale);
    }];
    
    
    // 举报 与 取消
    self.reportBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.reportBtn.backgroundColor = YKf6f6f6;
    [self.reportBtn setTitle:@"举报" forState:UIControlStateNormal];
    [self.reportBtn setTitleColor:YKff2e2e forState:UIControlStateNormal];
    self.reportBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.shareBackView addSubview:self.reportBtn];
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shareBackView.mas_centerX);
        make.top.mas_equalTo(weixinLabel.mas_bottom).offset(16 * WScale);
        make.left.mas_equalTo(self.shareBackView.mas_left).offset(25 * WScale);
        make.right.mas_equalTo(self.shareBackView.mas_right).offset(-25 * WScale);
        make.height.mas_equalTo(35 * WScale);
    }];
    
    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancleBtn.backgroundColor = YKf6f6f6;
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:YK505050 forState:UIControlStateNormal];
    self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.shareBackView addSubview:self.cancleBtn];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shareBackView.mas_centerX);
        make.top.mas_equalTo(self.reportBtn.mas_bottom).offset(10 * WScale);
        make.left.mas_equalTo(self.shareBackView.mas_left).offset(25 * WScale);
        make.right.mas_equalTo(self.shareBackView.mas_right).offset(-25 * WScale);
        make.height.mas_equalTo(35 * WScale);
    }];
    
    
    
}






@end

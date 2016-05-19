//
//  YKPickerView.h
//  YouthFountain_Server
//
//  Created by 李洋 on 16/3/2.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YKPickerViewDelegate <NSObject>

// 协议
- (void)pickerViewDoneSelectorRow:(NSInteger)row title:(NSString *)title;
- (void)pickerViewCancel;

@end

@interface YKPickerView : UIView

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) id <YKPickerViewDelegate> delegate;


@end

//
//  PickerChoiceView.h
//  JJBetter
//
//  Created by yikang on 16/3/28.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TFPickerDelegate <NSObject>

@optional;
- (void)PickerSelectorIndixString:(NSString *)str;

@end

typedef NS_ENUM(NSInteger, ARRAYTYPE) {
    GenderArray,
    HeightArray,
    weightArray,
    DeteArray
};

@interface PickerChoiceView : UIView

@property (nonatomic, assign) ARRAYTYPE arrayType;

@property (nonatomic, strong) NSArray *customArr;

@property (nonatomic,strong)UILabel *selectLb;

@property (nonatomic,assign)id<TFPickerDelegate>delegate;

@end

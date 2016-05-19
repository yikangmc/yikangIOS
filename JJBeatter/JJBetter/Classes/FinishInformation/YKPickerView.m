//
//  YKPickerView.m
//  YouthFountain_Server
//
//  Created by 李洋 on 16/3/2.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPickerView.h"
#import "UIColor+YKExtension.h"

@interface YKPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation YKPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.toolBar];
        [self addSubview:self.pickerView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
}


#pragma mark - UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArr.count;
}


#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30 * WScale;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100 * WScale, 20 * WScale)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:20 * WScale];
    lab.text = self.dataArr[row];

    return lab;
}


#pragma mark - lazy loading
- (UIToolbar *)toolBar
{
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] init];
        _toolBar.frame = CGRectMake(0, 0, self.frame.size.width, 40 * WScale);
        _toolBar.backgroundColor = [UIColor yk_colorWithHex:0xf0f0f1];
        UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cenceled)];
        
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *item3=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
        
        _toolBar.items = @[item1, item2, item3];
    }
    return _toolBar;
}

- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, 40 * WScale, self.frame.size.width, 162 * WScale);
        _pickerView.backgroundColor = [UIColor yk_colorWithHex:0xd2d5da];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}

- (void)cenceled
{
    if ([self.delegate respondsToSelector:@selector(pickerViewCancel)]) {
        [self.delegate pickerViewCancel];
    }
}

- (void)done
{
    if ([self.delegate respondsToSelector:@selector(pickerViewDoneSelectorRow:title:)]) {
        NSInteger currentRow = [self.pickerView selectedRowInComponent:0];
        [self.delegate pickerViewDoneSelectorRow:currentRow title:self.dataArr[currentRow]];
    }
}






@end

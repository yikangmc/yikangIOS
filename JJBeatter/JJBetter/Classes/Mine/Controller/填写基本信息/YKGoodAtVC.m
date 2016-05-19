//
//  YKGoodAtVC.m
//  JJBetter
//
//  Created by yikang on 16/4/5.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKGoodAtVC.h"
#import "YKGoodAtModel.h"
#import "BtnView.h"

@interface YKGoodAtVC ()

// 存放选择的标签(id)
@property (nonatomic,strong)NSMutableArray *selectButtonArr;
// 存放选择的标签(名字)
@property (nonatomic,strong)NSMutableArray *selectTitleArr;


@end

@implementation YKGoodAtVC


#pragma mark  ------  懒加载  --------
-(NSMutableArray *)selectButtonArr
{
    if (!_selectButtonArr) {
        _selectButtonArr = [NSMutableArray array];
    }
    return _selectButtonArr;
}
-(NSMutableArray *)selectTitleArr
{
    if (!_selectTitleArr) {
        _selectTitleArr = [NSMutableArray array];
    }
    return _selectTitleArr;
}


#pragma mark  ------  viewDidLoad  -------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goodAtBackToUp:)];
    
    // 保存按钮
    [self initRightSaveBtn];
    
    // 布局标签
    [self layoutButton];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, 0, 0);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
    
}

// 返回
-(void)goodAtBackToUp:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  ------  布局标签  ----------
-(void)layoutButton
{
    // 类名加方法返回一个自定义的view
    BtnView *object = [[BtnView alloc] init];
    UIView *view = [object creatBtnWithArray:self.allGoodAtTitleArr];
    // 对这个view上btn添加相应的事件
    for (UIButton *btn in view.subviews) {
        
        [btn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:view];
    
    // 创建最上方字体label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 * WScale, ScreenW, 20 * WScale)];
    label.backgroundColor = [UIColor clearColor];
    label.text = self.promptStr;
    label.font = [UIFont systemFontOfSize:14 * WScale];
    label.textColor = YK646464;
    [self.view addSubview:label];
    
}

// 相应事件
- (void)handleButton:(UIButton *)button{
    button.selected = !button.selected;
    
    if (button.selected) {
        
        for (YKGoodAtModel *model in self.allGoodAtArr) {
            if ([button.titleLabel.text isEqualToString:model.adeptName]) {
                NSString *String = [NSString stringWithFormat:@"%@",model.adeptId];
                [self.selectTitleArr addObject:model.adeptName];
                [self.selectButtonArr addObject:String];
            }
        }
        button.backgroundColor = YK23149252Color;
    }else{
        for (YKGoodAtModel *model in self.allGoodAtArr) {
            if ([button.titleLabel.text isEqualToString:model.adeptName]) {
                NSString *String = [NSString stringWithFormat:@"%@",model.adeptId];
                [self.selectTitleArr addObject:model.adeptName];
                [self.selectButtonArr removeObject:String];
            }
        }
        button.backgroundColor = [UIColor whiteColor];
    }
}


#pragma mark  ---------  保存  ------------
-(void)initRightSaveBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 40, 20);
    btn.titleLabel.font = [UIFont systemFontOfSize:15 * WScale];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:YK23149252Color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goodAtSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
// 保存按钮
-(void)goodAtSaveBtn
{
    if (self.selectButtonArr.count > 4) {
        [UIAlertTool AlertWithViewController:self withMessage:@"最多只能选择四项"];
        return;
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstOrRe"]) {
        
        NSString *string = [self.selectTitleArr componentsJoinedByString:@","];
        NSString *newStr = [string stringByReplacingOccurrencesOfString:@"," withString:@"  "];
        NSString *idStr = [self.selectButtonArr componentsJoinedByString:@","];
        [[NSUserDefaults standardUserDefaults] setObject:newStr forKey:@"GoodAt"];
        [[NSUserDefaults standardUserDefaults] setObject:idStr forKey:@"idGoodAt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        
        // 保存到服务器
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        dataDic[@"adepts"] = self.selectButtonArr;
        
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        paramDic[@"paramData"] = dataDic;
        paramDic[@"appId"] = @"10000";
        paramDic[@"accessTicket"] = [[NSUserDefaults standardUserDefaults] objectForKey:AccessTicket];
        paramDic[@"machineCode"] = [YKUUID getUUID];
        NSString *urlStr = [NSString stringWithFormat:@"%@00-17-12", URLSTR];
        
        [YKHttpTool postWithURL:urlStr params:paramDic success:^(id json) {
            
            if ([json[@"status"] isEqualToString:@"000000"]) {
                
                [MBProgressHUD showSuccess:@"提交成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            } else {
                
                [MBProgressHUD showError:json[@"message"] toView:self.view];
            }
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"网络故障,请重试" toView:self.view];
        }];
    }
    
}






@end

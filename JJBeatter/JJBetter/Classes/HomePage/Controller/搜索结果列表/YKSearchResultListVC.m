//
//  YKSearchResultListVC.m
//  JJBetter
//
//  Created by yikang on 16/5/10.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKSearchResultListVC.h"
#import "YKSearchResultPeopleCell.h"

@interface YKSearchResultListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITextField *textField;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)NSMutableArray *boolArray;  // 用来判断是否展开cell
@property (nonatomic,strong)NSMutableArray *footerArr;  // 存放可点击footer字段

@end

@implementation YKSearchResultListVC


#pragma mark  ----  loadView  -----
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 布局最上方搜索框
    [self layoutSearchUI];
    
    // 初始化tableView
    [self initTableView];
    
    self.footerArr = [NSMutableArray arrayWithObjects:@"更多相关专业人员",@"更多相关专业内容",@"更多相关问答", nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    
}


#pragma mark  ----  初始化tableView  ----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerClass:[YKSearchResultPeopleCell class] forCellReuseIdentifier:@"YKSearchResultPeopleCell"];
    
    
}


#pragma mark  ----  tableView代理方法  ----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.boolArray[section]  isEqual: @"yes"]) {
        return [self.allArray[section] count];
    }else{
        if ([self.allArray[section] count] > 3) {
            return 3;
        }else {
            return [self.allArray[section] count];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 78 * WScale;
    }
    return 44 * WScale;
    
}
// header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 46 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 46 * WScale)];
    gray.backgroundColor = YKGlobalBg;
    
    UIView *white = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * WScale, ScreenW, 35 * WScale)];
    white.backgroundColor = [UIColor whiteColor];
    [gray addSubview:white];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45 * WScale, ScreenW, 1)];
    line.backgroundColor = YKGlobalBg;
    [gray addSubview:line];
    
    NSArray *arr = @[@"相关专业人员",@"相关专业内容",@"相关问答"];
    UILabel *label = [[UILabel alloc] init];
    label.text = arr[section];
    label.textColor = YK656565;
    label.font = [UIFont systemFontOfSize:14 * WScale];
    [white addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(white.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(white.mas_centerY);
        make.height.mas_equalTo(white.mas_height);
        make.width.mas_equalTo(white.mas_width);
    }];
    
    
    return gray;

}
// footer
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 44 * WScale;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *white = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 44 * WScale)];
    white.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:self.footerArr[section] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [button setTitleColor:YK00aadd forState:UIControlStateNormal];
    [button addTarget:self action:@selector(moreContentAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section;
    [white addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(white.mas_centerY);
        make.left.mas_equalTo(white.mas_left).offset(15 * WScale);
        make.height.mas_equalTo(white.mas_height);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKGlobalBg;
    [white addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(white.mas_left);
        make.right.mas_equalTo(white.mas_right);
        make.top.mas_equalTo(white.mas_top);
        make.height.mas_equalTo(1);
    }];
    
    return white;
}
-(void)moreContentAction:(UIButton *)sender
{
    if ([self.boolArray[sender.tag]  isEqual: @"no"]) {
        
        self.boolArray[sender.tag] = @"yes";
        if (sender.tag == 0) {
            self.footerArr[0] = @"收起";
        }else if (sender.tag == 1) {
            self.footerArr[1] = @"收起";
        }else {
            self.footerArr[2] = @"收起";
        }
        [self.tableView reloadData];
        
    }else {
        
        self.boolArray[sender.tag] = @"no";
        if (sender.tag == 0) {
            self.footerArr[0] = @"更多相关专业人员";
        }else if (sender.tag == 1) {
            self.footerArr[1] = @"更多相关专业内容";
        }else {
            self.footerArr[2] = @"更多相关问答";
        }
        [self.tableView reloadData];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {

        YKSearchResultPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKSearchResultPeopleCell"];
        
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
        cell.nameLabel.text = @"李丽丽";
        cell.typeImageView.image = [UIImage imageNamed:@"康-"];
        // 创建标签
        NSArray *arr = @[@"运动康复运动",@"运动康复运动",@"运动康复运动",@"运动康复运动"];
        [cell creatLabelWithArray:arr];
        // 自适应nameLabel宽度
        CGFloat nameW = [YKSearchResultPeopleCell widthForNameLabel:cell.nameLabel.text];
        [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(nameW + 2);
        }];
        
        

        
        return cell;
        
    }
    static NSString *cell_id = @"search";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}



#pragma mark  ----  布局最上方搜索框  ----
-(void)layoutSearchUI
{
    
    UIView *white = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:white];
    
    
    UIView *gray = [[UIView alloc] init];
    gray.backgroundColor = YKGlobalBg;
    gray.clipsToBounds = YES;
    gray.layer.cornerRadius = 5;
    [white addSubview:gray];
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(white.mas_left).offset(10 );
        make.right.mas_equalTo(white.mas_right).offset(-10 );
        make.top.mas_equalTo(white.mas_top).offset(27);
        make.height.mas_equalTo(30);
    }];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [gray addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gray.mas_left).offset(15);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(gray.mas_centerY);
    }];

    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:YK505050 forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [gray addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(gray.mas_right).offset(-6);
        make.centerY.mas_equalTo(gray.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
    
    
    self.textField = [[UITextField alloc] init];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.font = [UIFont systemFontOfSize:13];
    self.textField.textColor = YK333333;
    [gray addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchBtn.mas_right).offset(11);
        make.centerY.mas_equalTo(gray.mas_centerY);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(cancelBtn.mas_left).offset(-10);
    }];
    
    
    
}


#pragma mark  ----  取消  -----
-(void)cancelBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark  ----  搜索事件  -----
-(void)searchBtnAction:(UIButton *)sender
{
    NSLog(@"搜索事件");
    
    self.allArray = [[NSMutableArray alloc] init];
    
    NSArray *array1 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g", nil];
    NSArray *array3 = [NSArray arrayWithObjects:@"you",@"me", nil];
    
    [self.allArray addObject:array1];
    [self.allArray addObject:array2];
    [self.allArray addObject:array3];
    
    self.boolArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.allArray.count; i++) {
        [self.boolArray addObject:@"no"];
    }
  
    [self.tableView reloadData];
    
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}






@end

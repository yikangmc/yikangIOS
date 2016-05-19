//
//  YKSearchResultVC.m
//  JJBetter
//
//  Created by yikang on 16/4/14.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKSearchResultVC.h"

@interface YKSearchResultVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *searchResult;
@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) NSMutableArray *result;
-(void)initSearchBar;//创建搜索
-(void)initTableView;//创建搜索结果的示意图

@end

@implementation YKSearchResultVC

-(NSMutableArray *)result{
    if (!_result) {
        self.result = [NSMutableArray array];
    }
    return _result;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameArray = [@[@"闪闪发光",@"商量等产",@"小情人",@"小歌手",@"爱人",@"爱着你",@"王大妈",@"王阿姨",@"我爱你",@"我爱猪",@"你是猪",@"你是人吗",@"啦啦啦",@"爱我吗",@"爱吗",@"爱不爱",@"不爱",@"爱人他",@"爱人妈",@"小帅哥",@"小情人人",@"小帅哥小帅哥小帅哥小帅哥小帅哥",@"小帅哥小帅哥小帅哥小帅哥小帅",@"小帅哥小帅哥小帅哥小帅哥小",@"小帅哥小帅哥小帅哥小帅哥",@"小帅哥小帅哥小帅哥小帅",@"小帅哥小帅哥小帅哥小",@"小帅哥小帅哥小帅哥",@"小帅哥小帅哥小帅哥小",@"小帅哥小帅哥小帅哥",@"小帅哥小帅哥小帅",@"小帅哥小帅哥小",@"小帅哥小帅哥"] mutableCopy];
    
    [self initSearchBar];
    

}

-(void)initSearchBar
{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"请输入你需要搜索的关键字";
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor lightGrayColor];
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    [self.view addSubview:_searchBar];
    
}

- (void)initTableView{
    self.searchResult = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.searchBar.frame), self.view.bounds.size.width, self.view.bounds.size.height-64-CGRectGetHeight(self.searchBar.frame))];
    _searchResult.dataSource = self;
    _searchResult.delegate =self;
    _searchResult.tableFooterView = [[UIView alloc]init];
    [_searchResult registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.searchResult];
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    [self initTableView];
    NSLog(@"heahtdyfgh");
    
    //改变取消的文本
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}



-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"我的");
    [self dismissViewControllerAnimated:NO completion:nil];
}

/**
 *  搜框中输入关键字的事件响应
 *
 *  @param searchBar  UISearchBar
 *  @param searchText 输入的关键字
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
    self.result = nil;
    for (int i = 0; i < self.nameArray.count; i++) {
        NSString *string = self.nameArray[i];
        if (string.length >= searchText.length) {
            NSString *str = [self.nameArray[i] substringWithRange:NSMakeRange(0, searchText.length)];
            if ([str isEqualToString:searchText]) {
                [self.result addObject:self.nameArray[i]];
            }
        }
    }
    [self.searchResult reloadData];
    
}

/**
 *  取消的响应事件
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取消吗");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

/**
 *  键盘上搜索事件的响应
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
}


/**
 *  UITableView的三个代理
 *
 *
 *  @return 行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.result.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.result[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

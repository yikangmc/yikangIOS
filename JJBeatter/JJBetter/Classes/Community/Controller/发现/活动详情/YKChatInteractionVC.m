//
//  YKChatInteractionVC.m
//  JJBetter
//
//  Created by yikang on 16/5/7.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKChatInteractionVC.h"
#import "YKChatInteractionCell.h"

@interface YKChatInteractionVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSString *middleChatStr;


@end

@implementation YKChatInteractionVC


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // 初始化tableView
    [self initTableView];
    
    
}


#pragma mark  ----  初始化tableView  -----
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ScreenH - 245 * WScale)];
    self.tableView.backgroundColor = YKGlobalBg;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerClass:[YKChatInteractionCell class] forCellReuseIdentifier:@"YKChatInteractionCell"];
    
}


#pragma mark  ----  tableView代理方法  -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(280 * WScale, 0);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13 * WScale]};
    CGRect rect = [self.middleChatStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height + 60 * WScale;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKChatInteractionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKChatInteractionCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"头像"]];
    cell.nameLabel.text = @"康复师周琳";
    cell.timeLabel.text = @"2016-02-21";
    cell.chatContentLabel.text = @"这活动有谁参加dhakd和咖啡店和跨世纪的的的杀手开户行叫撒杀了可视宽度大雷";
    self.middleChatStr = cell.chatContentLabel.text;
    
    // 自适应聊天内容高度
    CGFloat chatContentH = [YKChatInteractionCell heightForChatContentLabel:cell.chatContentLabel.text];
    [cell.chatContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(chatContentH + 2 * WScale);
    }];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end

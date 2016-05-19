//
//  YKSearchResultPeopleCell.m
//  JJBetter
//
//  Created by yikang on 16/5/10.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKSearchResultPeopleCell.h"

@implementation YKSearchResultPeopleCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allViews];
    }
    return self;
}


-(void)allViews
{
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 25 * WScale;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10 * WScale);
        make.width.mas_equalTo(50 * WScale);
        make.height.mas_equalTo(self.headImageView.mas_width);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK505050;
    self.nameLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(13 * WScale);
        make.height.mas_equalTo(15 * WScale);
    }];
    
    
    self.typeImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeImageView];
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(2.5 * WScale);
        make.height.mas_equalTo(14 * WScale);
        make.width.mas_equalTo(self.typeImageView.mas_height);
        self.typeImageView.clipsToBounds = YES;
        self.typeImageView.layer.cornerRadius = 7 * WScale ;
    }];
    
    
    
}


// 名字自适应宽度
+(CGFloat)widthForNameLabel:(NSString *)nameLabel
{
    
    CGSize size = CGSizeMake(0, 15 * HScale);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14 * WScale]};
    CGRect rect = [nameLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
    
}


-(void)creatLabelWithArray:(NSArray *)dataArr{
    
    UIView *view=[[UIView alloc]init];
    //    view.backgroundColor = [UIColor yellowColor];
    int width = 0;
    
    // 创建button
    for (int i = 0; i <dataArr.count ; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = YKf0f0f0;
        label.textColor = YK323232;
        label.text = dataArr[i];
        label.font = [UIFont systemFontOfSize:12 * WScale];
        label.textAlignment = NSTextAlignmentCenter;
        // 设置边框
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 1 * WScale;
        
        CGSize size = CGSizeMake(0, 13 * HScale);
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12 * WScale]};
        CGRect rect = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        
        if (iPhone4) {
            label.frame = CGRectMake((width + 12) * WScale , 2 * HScale, rect.size.width + 7 , 26 * HScale);
            width = width + rect.size.width + 26;
        }else if (iPhone5) {
            label.frame = CGRectMake((width + 10) * WScale , 2 * HScale, (rect.size.width + 16 ) * WScale, 23 * HScale);
            width = width + rect.size.width + 22;
        }else if (iPhone6) {
            label.frame = CGRectMake((width + 10) * WScale , 2 * HScale, (rect.size.width + 8 ) * WScale, 23 * HScale);
            width = width + rect.size.width + 13;
        }else {
            label.frame = CGRectMake((width + 10) * WScale , 2 * HScale, (rect.size.width + 3 ) * WScale, 23 * HScale);
            width = width + rect.size.width + 10;
        }
        
        [view addSubview:label];
        
    }
    view.clipsToBounds = YES;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right);
        if (ScreenH < 568) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(8 * HScale);
        }else{
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5 * HScale);
        }
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5 * WScale);
        make.height.mas_equalTo(30 * HScale);
    }];
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end

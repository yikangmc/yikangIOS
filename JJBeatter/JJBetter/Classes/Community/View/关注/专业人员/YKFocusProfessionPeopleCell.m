//
//  YKFocusProfessionPeopleCell.m
//  JJBetter
//
//  Created by yikang on 16/5/12.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKFocusProfessionPeopleCell.h"

@implementation YKFocusProfessionPeopleCell


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
    self.headImageView.layer.cornerRadius = 44 * WScale / 2;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(44 * WScale);
        make.height.mas_equalTo(self.headImageView.mas_width);
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = YK505050;
    self.nameLabel.font = [UIFont systemFontOfSize:14 * WScale];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(17 * WScale);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10 * WScale);
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
    
    
    self.focusLabel = [[UILabel alloc] init];
    self.focusLabel.textAlignment = NSTextAlignmentRight;
    self.focusLabel.textColor = YK323232;
    self.focusLabel.font = [UIFont systemFontOfSize:13 * WScale];
    [self.contentView addSubview:self.focusLabel];
    [self.focusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.height.mas_equalTo(14 * WScale);
        make.width.mas_equalTo(95 * WScale);
    }];
    
    
    
}


// 名字自适应宽度
+(CGFloat)widthForNameLabel:(NSString *)nameLabel
{
    
    CGSize size = CGSizeMake(0, 15 * WScale);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14 * WScale]};
    CGRect rect = [nameLabel boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
    
}


-(void)creatLabelWithArray:(NSArray *)dataArr{
    
    UIView *view=[[UIView alloc]init];
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
        
        CGSize size = CGSizeMake(0, 13 * WScale);
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
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(6 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10 * WScale);
        make.height.mas_equalTo(30 * WScale);
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

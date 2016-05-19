//
//  YKPersonalHomePageProfessionFieldCell.m
//  JJBetter
//
//  Created by yikang on 16/5/13.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKPersonalHomePageProfessionFieldCell.h"

@interface YKPersonalHomePageProfessionFieldCell ()

@property (nonatomic,strong)UIView *bottomView;

@end

@implementation YKPersonalHomePageProfessionFieldCell


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
    UILabel *label = [[UILabel alloc] init];
    label.textColor = YK333333;
    label.font = [UIFont systemFontOfSize:15 * WScale];
    label.text = @"专业领域";
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(39 * WScale);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YKGlobalBg;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WScale);
        make.top.mas_equalTo(label.mas_bottom);
        make.height.mas_equalTo(1 * WScale);
    }];
    
    
    self.bottomView = [[UIView alloc] init];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(line.mas_bottom);
        make.height.mas_equalTo(44 * WScale);
    }];
    
    
    
    
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
            label.frame = CGRectMake((width + 12) * WScale , 2 * HScale, rect.size.width + 7 , 26 * WScale);
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
        make.left.mas_equalTo(self.contentView.mas_left).offset(5 * WScale);
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
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

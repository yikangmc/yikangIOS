//
//  YKLabelPostPeopleCell.m
//  JJBetter
//
//  Created by yikang on 16/4/26.
//  Copyright © 2016年 yikang. All rights reserved.
//

#import "YKLabelPostPeopleCell.h"

@implementation YKLabelPostPeopleCell



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
    
    self.getYesLabel = [[UILabel alloc] init];
    self.getYesLabel.textColor = YK323232;
    self.getYesLabel.font = [UIFont systemFontOfSize:12 * WScale];
    [self.contentView addSubview:self.getYesLabel];
    [self.getYesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(29 * WScale / 2);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(70 * WScale);
        make.height.mas_equalTo(13 * WScale);
    }];
    
    
}



// 添加一个方法(添加头像)
-(void)creatImageViewWithArray:(NSArray *)dataArr
{
    UIView *view = [[UIView alloc] init];

    
    for (int i = 0; i < dataArr.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 34 * WScale / 2;

        [imageView sd_setImageWithURL:[NSURL URLWithString:dataArr[i]] placeholderImage:[UIImage imageNamed:@"更多支持"]];
        
        imageView.frame = CGRectMake(0, 0, 34 * WScale, 34 * WScale);
        imageView.center = CGPointMake(i * (17 + 22) * WScale + 17 * WScale, 55 * WScale / 2);
        
        [view addSubview:imageView];
    }
    
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right);
        make.left.mas_equalTo(self.getYesLabel.mas_right).offset(8 * WScale);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
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

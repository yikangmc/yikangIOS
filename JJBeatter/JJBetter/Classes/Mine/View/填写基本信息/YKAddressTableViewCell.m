//
//  AddressTableViewCell.m
//  YouthFountain
//
//  Created by 马文帅 on 15/7/2.
//  Copyright (c) 2015年 yikang. All rights reserved.
//

#import "YKAddressTableViewCell.h"
#import "PureLayout.h"
#import "UIColor+YKExtension.h"

@interface YKAddressTableViewCell ()

@property (nonatomic, strong) NSLayoutConstraint *titleLableTopEdge;

@end

@implementation YKAddressTableViewCell

+ (id)cellInitWithTable:(UITableView *)tableView {
    static NSString *cellID = @"cellID";
    YKAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YKAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont boldSystemFontOfSize:14.0];
    [self.contentView addSubview:titleLable];
    self.titleLable = titleLable;
    NSLayoutConstraint *titleLableTopEdge = [titleLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5.0];
    self.titleLableTopEdge = titleLableTopEdge;
    [titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [titleLable autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    
    UILabel *subTitlable = [[UILabel alloc] init];
    subTitlable.textColor = [UIColor yk_colorWithHex:0x999999];
    subTitlable.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:subTitlable];
    self.subTitleLable = subTitlable;
    [subTitlable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 5, 0) excludingEdge:ALEdgeTop];
    [subTitlable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLable withOffset:0];
    
//    UIImageView *line = [UIImageView new];
//    line.image = [UIImage imageNamed:@"address_line"];
//    [self.contentView addSubview:line];
//    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
//    [line autoSetDimension:ALDimensionHeight toSize:1.0];
}

- (void)refreshWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    self.titleLable.text = title;
    self.subTitleLable.text = subTitle ? subTitle : nil;
    if (!subTitle || [subTitle isEqualToString:@""]) {
        self.titleLableTopEdge.constant = 18.0;
    } else {
        self.titleLableTopEdge.constant = 5.0;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}



@end

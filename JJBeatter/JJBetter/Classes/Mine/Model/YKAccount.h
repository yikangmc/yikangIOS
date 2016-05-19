//
//  YKAccount.h
//  YouthFountain_Server
//
//  Created by 李洋 on 15/11/17.
//  Copyright © 2015年 yikang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKAccount : NSObject<NSCoding>

/** 姓名 */
@property (nonatomic, copy) NSString *userName;
/** 用户ID，工号 */
@property (nonatomic, strong) NSNumber *userId;
/** 职位 */
@property (nonatomic, strong) NSNumber *userPosition;
/** 工作方式 */
@property (nonatomic, strong) NSNumber *jobCategory;
/** 详细地址 */
@property (nonatomic, copy) NSString *addressDetail;
/** 区域编码 */
@property (nonatomic, copy) NSString *districtCode;
/** 地图定位地址 */
@property (nonatomic, copy) NSString *mapPositionAddress;
/** 患者数 */
@property (nonatomic, strong) NSNumber *nums;
/** 头像url */
@property (nonatomic, copy) NSString *photoUrl;
/** 医院 */
@property (nonatomic, copy) NSString *hospital;
/** 擅长 */
@property (nonatomic, copy) NSString *adept;
@property (nonatomic,strong)NSArray *adepts;
/** 二维码携带的url */
@property (nonatomic, copy) NSString *invitationUrl;
/** 科室 */
@property (nonatomic, copy) NSString *offices;
/** 邀请码 */
@property (nonatomic, strong) NSNumber *invitationCode;
/** 信息完整*/
@property (nonatomic,strong)NSNumber *infoWrite;
/** 审核职位*/
@property (nonatomic,strong)NSNumber *positionAuditStatus;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;





@end

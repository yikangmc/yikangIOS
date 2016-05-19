//
//  YKAccount.m
//  YouthFountain_Server
//
//  Created by 李洋 on 15/11/17.
//  Copyright © 2015年 yikang. All rights reserved.
//

#import "YKAccount.h"

@implementation YKAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

/** 从文件中解析对象的时候调用 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.userPosition = [decoder decodeObjectForKey:@"userPosition"];
        self.jobCategory = [decoder decodeObjectForKey:@"jobCategory"];
        self.addressDetail = [decoder decodeObjectForKey:@"addressDetail"];
        self.districtCode = [decoder decodeObjectForKey:@"districtCode"];
        self.mapPositionAddress = [decoder decodeObjectForKey:@"mapPositionAddress"];
        self.nums = [decoder decodeObjectForKey:@"nums"];
        self.photoUrl = [decoder decodeObjectForKey:@"photoUrl"];
        self.hospital = [decoder decodeObjectForKey:@"hospital"];
        self.adept = [decoder decodeObjectForKey:@"adept"];
        self.invitationUrl = [decoder decodeObjectForKey:@"invitationUrl"];
        self.offices = [decoder decodeObjectForKey:@"offices"];
        self.invitationCode = [decoder decodeObjectForKey:@"invitationCode"];
        self.infoWrite = [decoder decodeObjectForKey:@"infoWrite"];
    }
    return self;
}

/** 将对象写入文件的时候调用 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.userPosition forKey:@"userPosition"];
    [encoder encodeObject:self.jobCategory forKey:@"jobCategory"];
    [encoder encodeObject:self.addressDetail forKey:@"addressDetail"];
    [encoder encodeObject:self.districtCode forKey:@"districtCode"];
    [encoder encodeObject:self.mapPositionAddress forKey:@"mapPositionAddress"];
    [encoder encodeObject:self.nums forKey:@"nums"];
    [encoder encodeObject:self.photoUrl forKey:@"photoUrl"];
    [encoder encodeObject:self.hospital forKey:@"hospital"];
    [encoder encodeObject:self.adept forKey:@"adept"];
    [encoder encodeObject:self.invitationUrl forKey:@"invitationUrl"];
    [encoder encodeObject:self.offices forKey:@"offices"];
    [encoder encodeObject:self.invitationCode forKey:@"invitationCode"];
    [encoder encodeObject:self.infoWrite forKey:@"infoWrite"];
    
}







@end

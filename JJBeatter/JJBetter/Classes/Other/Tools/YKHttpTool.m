//
//  WSHttpTool.m
//  封装整个项目的GET\POST请求
//
//  Created by 李洋 on 15/7/22.
//  Copyright (c) 2015年 yikang. All rights reserved.
//

#import "YKHttpTool.h"


@implementation YKHttpTool

+ (void)postWithURL:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 将参数字典中的paramData取出进行加密操作
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic = [params mutableCopy];
    id paramData = paramDic[@"paramData"];
    // 如果paramData对应的是字典则进行加密，否则不加密
    if ([paramData isKindOfClass:[NSDictionary class]]) {
        NSString *dataStr = [paramData dictionaryToJson];
        NSString *enStr = [dataStr aes256_encrypt:keyForEncrypt];
        paramDic[@"paramData"] = enStr;
    }
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 10;
    
    // 2.发送请求
    [mgr POST:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSMutableDictionary *responseDic = [NSMutableDictionary dictionary];
            responseDic = [responseObject mutableCopy];
            if (responseDic[@"data"] != [NSNull null]) {
                NSString *deStr = [responseDic[@"data"] aes256_decrypt:keyForEncrypt];
                
                id data = [deStr jsonStringToDictionary]?[deStr jsonStringToDictionary]:[deStr jsonStringToArray];
                if (data) {
                    responseDic[@"data"] = data;
                } else {
                    responseDic[@"data"] = deStr;
                }
            }
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 10;
    
    // 2.发送请求
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 30;
    
    // 2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (YKFormData *tempFormData in formDataArray) {
            [formData appendPartWithFileData:tempFormData.data name:tempFormData.name fileName:tempFormData.filename mimeType:tempFormData.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

    
}



@end

/**
 *  用来封装文件数据的模型
 */
@implementation YKFormData





@end
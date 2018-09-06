//
//  RXNetWorkTool.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXNetWorkTool.h"
#import "RXNetManager.h"

@implementation RXNetWorkTool



+(void)POST:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [RXNetManager shareInstance];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            NSDictionary *successDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(successDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
    }];
}


/*
 +(void)POST:(NSString *)URLString
 parameters:(id)parameters
 progress:(void (^)(NSProgress *))progress
 success:(void (^)(id))success
 failure:(void (^)(NSError *))failure{
 
 
 AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
 manager.securityPolicy.allowInvalidCertificates = YES;
 manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
 if (progress) {
 progress(uploadProgress);
 }
 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 if (success) {
 NSDictionary *successDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
 success(successDic);
 }
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 if (failure) {
 failure(error);
 }
 }];
 }
 */

@end

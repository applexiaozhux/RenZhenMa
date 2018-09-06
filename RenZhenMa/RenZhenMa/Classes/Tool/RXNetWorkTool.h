//
//  RXNetWorkTool.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface RXNetWorkTool : NSObject
/**
 *  POST 请求
 *
 *  @param URLString  请求头
 *  @param parameters 请求体
 *  @param progress   进度
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
    progress:(nullable void (^)(NSProgress *progress))progress
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;



@end
NS_ASSUME_NONNULL_END

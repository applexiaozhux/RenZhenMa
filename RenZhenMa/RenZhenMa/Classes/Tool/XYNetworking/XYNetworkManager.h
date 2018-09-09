//
//  XYNetworkManager.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^XYManagerSuccess)(id response,id responseObject);
/**
 *  请求错误所走方法
 *
 *  @param error 请求错误返还的信息
 */
typedef void (^XYManagerFail)(NSURLSessionDataTask * task, NSError * error);
@interface XYNetworkManager : NSObject


+(instancetype)defaultManager;

@property (nonatomic,assign) BOOL isShowHUD;
-(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(XYManagerSuccess)success
       fail:(XYManagerFail)fail;



@end

//
//  XYNetworkManager.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYNetworkManager.h"
#import <AFNetworking.h>
#import "XYConst.h"
#import <SVProgressHUD.h>
#import "XYUserInfoManager.h"
@interface XYNetworkManager()

@property(nonatomic,retain)AFHTTPSessionManager *manager;

@end


@implementation XYNetworkManager

+(instancetype)defaultManager{
    
    static XYNetworkManager *networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[XYNetworkManager alloc] init];
        networkManager.manager = [XYNetworkManager managerWithBaseURL:kBaseURL sessionConfiguration:NO];
        networkManager.isShowHUD = YES;
    });
    return networkManager;
}

-(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(XYManagerSuccess)success
       fail:(XYManagerFail)fail{
    
    NSString *urlPath = [NSString stringWithFormat:@"%@/%@",kBaseURL,url];
    NSLog(@"urlPath = %@,params = %@",urlPath,params);

    if (self.isShowHUD) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD show];
    }
    
    [self.manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [XYNetworkManager responseConfiguration:responseObject];
        NSLog(@"response = %@",dic);
        NSString *code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            
            id info = dic[@"info"];
            if (success) {
                success(info,dic);
            }
            
        }else{
            NSString *messageStr = [dic objectForKey:@"message"];
            if (self.isShowHUD) {
                
                [SVProgressHUD showErrorWithStatus:messageStr];
            }
            
            if (fail) {
                NSError *error = [NSError errorWithDomain:messageStr code:code.integerValue userInfo:nil];
                fail(nil,error);
            }
        }
        self.isShowHUD = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (fail) {
            fail(task,error);
        
        }
        if (self.isShowHUD) {
            [SVProgressHUD showErrorWithStatus:error.domain];
        }
        self.isShowHUD = YES;
    }];
    
    
}




+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}


+(NSDictionary *)responseConfiguration:(id)responseObject{
    
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
    
}


@end

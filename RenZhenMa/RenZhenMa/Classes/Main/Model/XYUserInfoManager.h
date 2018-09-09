//
//  XYUserInfoManager.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^XYLoginDoneBlock)(BOOL success);
@class XYUserInfoModel;
@interface XYUserInfoManager : NSObject

+(instancetype)shareInfoManager;

+(BOOL)isLogin;

+(void)showLoginViewController:(XYLoginDoneBlock)done controller:(UIViewController *)controller;

-(void)logOut;
@property(nonatomic, retain) XYUserInfoModel *userInfo;

@end

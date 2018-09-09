//
//  XYUserInfoManager.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYUserInfoManager.h"
#import "XYConst.h"
#import "XYUserInfoModel.h"
#import "RXLoginViewController.h"
#import "XYNavigationViewController.h"
@implementation XYUserInfoManager

+(instancetype)shareInfoManager{
    
    static XYUserInfoManager *userInfoManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfoManager = [[XYUserInfoManager alloc] init];
        if ([self isLogin]) {
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoData];
            XYUserInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            userInfoManager.userInfo = model;
        }
    });
    return userInfoManager;
}



+(BOOL)isLogin{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoData];
    if (data == nil) {
        return NO;
    }
    return YES;
    
}
+(void)showLoginViewController:(XYLoginDoneBlock)done controller:(UIViewController *)controller{
    
    if ([XYUserInfoManager isLogin]) {
        done(YES);
    }else{
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RXLoginViewController *vc = [story instantiateViewControllerWithIdentifier:@"RXLoginViewController"];
        XYNavigationViewController *naviVC = [[XYNavigationViewController alloc] initWithRootViewController:vc];
        vc.loginDone = ^(BOOL success) {
            done(success);
        };
        [controller presentViewController:naviVC animated:YES completion:nil];
        
    }
    
}

-(void)logOut{
    
    self.userInfo = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInfoData];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccess object:nil];
}

-(void)setUserInfo:(XYUserInfoModel *)userInfo{
    _userInfo = userInfo;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserInfoData];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccess object:nil];
}




@end

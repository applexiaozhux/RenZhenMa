//
//  AppDelegate.m
//  RenZhenMa
//
//  Created by 李瑞星 on 2018/9/3.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "AppDelegate.h"
#import "XYTabBarController.h"
#import <AFNetworking.h>
#import "XYProgressHUD.h"
#import "XYConst.h"
#import <UMCommon/UMCommon.h>
#import <XHLaunchAd.h>
#import "XYAdvicationModel.h"
@interface AppDelegate ()<XHLaunchAdDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    
    XYTabBarController *tabBarController = [[XYTabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];

    [self listenNetWorkingStatus];
    
    [UMConfigure initWithAppkey:kUMAppkey channel:@"App Store"];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSData *advData = [[NSUserDefaults standardUserDefaults] objectForKey:kAdvKey];
    if (advData != nil) {
        XYAdvicationModel *advModel = [NSKeyedUnarchiver unarchiveObjectWithData:advData];
        
        [XHLaunchAd setLaunchSourceType:SourceTypeLaunchScreen];
        //配置广告数据
        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
        imageAdconfiguration.duration = [advModel.palytime integerValue];
        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
        imageAdconfiguration.imageNameOrURLString = advModel.imgsrc;
        //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
        imageAdconfiguration.openModel = advModel.url;
        //显示图片开屏广告
        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)listenNetWorkingStatus{
    //1:创建网络监听者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    //2:获取网络状态
    /*
     AFNetworkReachabilityStatusUnknown          = 未知网络，
     AFNetworkReachabilityStatusNotReachable     = 没有联网
     AFNetworkReachabilityStatusReachableViaWWAN = 蜂窝数据
     AFNetworkReachabilityStatusReachableViaWiFi = 无线网
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                [XYProgressHUD showMessage:@"未能连接到网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                DLog(@"蜂窝数据");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DLog(@"无线网");
                break;
            default:
                [XYProgressHUD showMessage:@"未能连接到网络"];
                break;
        }
    }];
    
    //开启网络监听
    [manager startMonitoring];
}

//广告点击
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAdvNoti object:openModel];
    
}

@end

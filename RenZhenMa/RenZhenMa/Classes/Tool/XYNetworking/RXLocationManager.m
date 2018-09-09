//
//  RXLocationManager.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/9.
//  Copyright © 2018年 李瑞星. All rights reserved.
//


#define Location_Key @"Location_Key_2.2.1"
#define SelectLocation_Key @"SelectLocation_Key_2.2.1"
#import "RXLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "XYCommonHeader.h"

@interface RXLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, assign) BOOL isAccess;//是否获取权限
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation RXLocationManager

+ (RXLocationManager *)manager {
    static RXLocationManager *tjManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tjManager = [[RXLocationManager alloc]init];
    });
    return tjManager;
}
-(instancetype)init {
    self = [super init];
    
    if (self) {
        _type = TJLocation_UnLocation;
        
        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:Location_Key];
        if (city.length > 0) {
            _locality = city;
        }else{
            _locality = @"";
        }
        
    }
    return self;
}

#pragma mark  定位获取城市
-(CLLocationManager *)locationManager {
    if (!_locationManager) {
        // 初始化定位管理器
        _locationManager = [[CLLocationManager alloc] init];
        // 设置代理
        _locationManager.delegate = self;
        // 设置定位精确度到米
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置过滤器为无
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        // 取得定位权限，有两个方法，取决于你的定位使用情况
        // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
        // 这句话ios8以上版本使用。
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startMonitoringSignificantLocationChanges];
        __weak typeof(self) weakSelf = self;
        if (self.locality.length == 0) {//第一次定位时候,如果定位超时,则通知获取默认页面,避免等待很久
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakSelf.type != TJLocation_Success || weakSelf.type != TJLocation_Fail) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocation_End object:@[@"",@""]];
                }
            });
            
        }
    }
    return _locationManager;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                                            objectForKey:@"AppleLanguages"];
    // 强制 成简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil]
                                              forKey:@"AppleLanguages"];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    //    CLLocation *l1 = [[CLLocation alloc] initWithLatitude:35.216895 longitude:113.247471];//测试使用经纬度坐标
    __weak typeof(self) weakSelf = self;
    //    locations.lastObject
    
    [geocoder reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray *array, NSError *error){
        if (weakSelf.type == TJLocation_Success) {
            return ;
        }
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            weakSelf.locality = @"";//定位成功取消记忆位置
            weakSelf.type = TJLocation_Success;
            weakSelf.nowlocality = placemark.locality.mutableCopy;
            weakSelf.nowSubLocality = placemark.subLocality.mutableCopy;

            if (weakSelf.nowlocality.length == 0) {
                weakSelf.nowlocality = @"";
                weakSelf.nowSubLocality = @"";
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocation_End object:@[weakSelf.nowlocality,weakSelf.nowSubLocality]];
        } else if (error == nil && [array count] == 0)
        {
            weakSelf.type = TJLocation_Fail;
            DLog(@"No results were returned.");
        }else if (error != nil)
        {
            weakSelf.type = TJLocation_Fail;
            DLog(@"An error occurred = %@", error);
        }else {
            weakSelf.type = TJLocation_Fail;
        }
        if (!weakSelf.nowlocality) {
            weakSelf.nowlocality = @"";
        }
        if (!weakSelf.nowSubLocality) {
            weakSelf.nowSubLocality = @"";
        }
        // 还原Device 的语言
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
    [_locationManager stopUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

    _type = TJLocation_Fail;
    _locality = @"";
    if (error.code == kCLErrorDenied) {//用户拒绝使用地理位置
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请允许访问位置信息权限,方便为您提供更精准的服务信息" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *appSettingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:appSettingURL]) {
                [[UIApplication sharedApplication] openURL:appSettingURL];
            }
        }]];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }else {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [_locationManager stopUpdatingLocation];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocation_End object:@""];
    
}
-(void)setLocality:(NSString *)locality {
    _locality = locality;
    if (locality.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:locality forKey:Location_Key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
+(void)getLocationWithBlock:(void (^)(TJLocationDataType,NSString *record, NSString *, NSString *))block {
    if ([[self class] manager].type == TJLocation_UnLocation) {
        [[RXLocationManager manager].locationManager startUpdatingLocation];
        if ([RXLocationManager manager].locality.length > 0) {
            block(TJLocation_Cache, [RXLocationManager manager].locality, [RXLocationManager manager].nowlocality,[RXLocationManager manager].nowSubLocality);
        }else{
            block(TJLocation_None,@"", @"",@"");
        }
    }else if ([[self class] manager].type == TJLocation_BeLocation){
        //等待
        if ([RXLocationManager manager].locality.length > 0) {
            block(TJLocation_Cache, [RXLocationManager manager].locality, [RXLocationManager manager].nowlocality,[RXLocationManager manager].nowSubLocality);
        }else{
            block(TJLocation_None,@"", @"",@"");
        }
    }else if ([[self class] manager].type == TJLocation_Fail) {//定位失败
        block(TJLocation_None, [RXLocationManager manager].locality, [RXLocationManager manager].nowlocality,[RXLocationManager manager].nowSubLocality);
    }else{//已经获取定位
        block(TJLocation_Now,[RXLocationManager manager].locality, [RXLocationManager manager].nowlocality,[RXLocationManager manager].nowSubLocality);
    }
    
    
}



@end

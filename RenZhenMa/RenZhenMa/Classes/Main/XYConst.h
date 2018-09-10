//
//  XYConst.h
//  RenZhenMa
//
//  Created by qiaoxy on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
//测试环境
static const NSString *kBaseURL = @"https://api.renzhenma.com.cn/index.php/index/index";


#else
//生产环境
static const NSString *kBaseURL = @"https://api.renzhenma.com.cn/index.php/index/index";
#endif

//本地用户信息
static NSString *kUserInfoData = @"kUserInfoData";
//登录成功通知
static NSString *kLoginSuccess = @"kLoginSuccess";
//退出登录通知
static NSString *kLogoutSuccess = @"kLogoutSuccess";
//主题颜色
static NSString *kThemeColorStr = @"#00a950"; //主题颜色
//友盟key
static NSString *kUMAppkey = @"5b9481e7b27b0a540a00032f";
//广告
static NSString *kAdvKey = @"kAdvKey";

//广告点击通知
static NSString *kAdvNoti = @"kAdvNoti";


#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//背景色
#define DeviceBackGroundColor        [UIColor colorWithString:@"#efeff4"]
// 下划线
#define DeviceLineViewColor         [UIColor colorWithString:@"#e5e5e5"]


#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
// 按设备宽度做适配 UI 出图750px宽
#define SCALE375_WIDTH(x) (([UIScreen mainScreen].bounds.size.width/375.0)*(x))


// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)


#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 navigationBar的高度
 */
#define KNavigationBar_Height      (iPhoneX ? 88.f : 64.f)

#define KTabBar_Height             (iPhoneX ? 83.f : 49.f)

#define KStatusBar_Height          (iPhoneX ? 44.f : 20.f)

#define NotificationLocation_End            @"NotificationLocation_End"//获取位置完成通知


#ifdef DEBUG
#    define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#    define DLog(...)
#endif




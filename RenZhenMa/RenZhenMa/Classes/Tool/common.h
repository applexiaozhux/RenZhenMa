//
//  common.h
//  JiatyhNurse
//
//  Created by liruixing on 2018/7/24.
//  Copyright © 2018年 liruixing. All rights reserved.
//



/*请求接口地址*/
#define  BASE_URL(path)      [NSString stringWithFormat:@"https://api.renzhenma.com.cn/index.php/index/index/%@",path]


#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//背景色
#define DeviceBackGroundColor        [UIColor colorWithHexString:@"#f7f8f9"]
// 下划线
#define DeviceLineViewColor         [UIColor colorWithHexString:@"#e5e5e5"]


#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
// 按设备宽度做适配 UI 出图750px宽
#define SCALE375_WIDTH(x) (([UIScreen mainScreen].bounds.size.width/375.0)*(x))


#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 navigationBar的高度
 */
#define KNavigationBar_Height      (iPhoneX ? 88.f : 64.f)

#define KTabBar_Height             (iPhoneX ? 83.f : 49.f)

#define KStatusBar_Height          (iPhoneX ? 44.f : 20.f)



#ifdef DEBUG
#    define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#    define DLog(...)
#endif


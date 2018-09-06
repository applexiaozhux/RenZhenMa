//
//  XYConst.h
//  RenZhenMa
//
//  Created by qiaoxy on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kThemeColorStr = @"#25A857"; //主题颜色

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

#define  BASE_URL(path)      [NSString stringWithFormat:@"https://api.renzhenma.com.cn/index.php/index/index/%@",path]

#ifdef DEBUG
#    define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#    define DLog(...)
#endif


#pragma mark - BaseURL

#ifdef DEBUG
//测试环境
static const NSString *baseURL = @"http://api.nongji360.com/";


#else
//生产环境
static const NSString *baseURL = @"http://api.nongji360.com/";

#endif



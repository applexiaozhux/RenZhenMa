//
//  RXLocationManager.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/9.
//  Copyright © 2018年 李瑞星. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TJLocation_UnLocation,
    TJLocation_BeLocation,
    TJLocation_Success,
    TJLocation_Fail,
} TJLocationType;//定位状态
typedef enum : NSUInteger {
    TJLocation_None,//失败/无位置
    TJLocation_Cache,
    TJLocation_Now,
} TJLocationDataType;//定位数据


@interface RXLocationManager : NSObject

@property (nonatomic,assign) TJLocationType type;
@property (nonatomic,copy) NSString *locality;//记录选择城市

@property (nonatomic,copy) NSString *nowlocality;//定位城市
@property (nonatomic,copy) NSString *nowSubLocality;//定位区域


@property (nonatomic,copy) NSString *oldLocality;//之前缓存城市
@property (nonatomic,copy) NSString *oldSubLocality;//之前缓存区域



+ (RXLocationManager *)manager;
+ (void)getLocationWithBlock:(void (^)(TJLocationDataType type,NSString *record,NSString *locality,NSString *subLocality))block;

@end

//
//  XYProductInfoModel.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYProductInfoModel.h"
#import "XYGoodModel.h"
#import "XYGooddDataModel.h"
#import "XYScanInfoModel.h"
#import <YYKit/NSObject+YYModel.h>
@implementation XYProductInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"gooddata" : [XYGooddDataModel class],
             @"good" : XYGoodModel.class,
             @"scaninfo" : [XYScanInfoModel class] };
}


@end

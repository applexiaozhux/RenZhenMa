//
//  XYProductInfoModel.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYGoodModel,XYGooddDataModel,XYScanInfoModel;
@interface XYProductInfoModel : NSObject

@property(nonatomic,retain) XYGoodModel *good;
@property(nonatomic,retain) NSArray *gooddata;
@property(nonatomic, retain) NSArray *scaninfo;

@end

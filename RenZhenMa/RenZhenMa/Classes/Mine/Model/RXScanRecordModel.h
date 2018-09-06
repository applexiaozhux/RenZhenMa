//
//  RXScanRecordModel.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXScanRecordModel : NSObject

@property (nonatomic,copy) NSString *scanRecordID;
@property (nonatomic,copy) NSString *simg;
@property (nonatomic,copy) NSString *goods_name;//'商品名
@property (nonatomic,copy) NSString *key_name;//商品规格
@property (nonatomic,copy) NSString *utime;// 时间戳精确到秒

@end

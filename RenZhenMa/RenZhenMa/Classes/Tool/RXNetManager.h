//
//  RXNetManager.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface RXNetManager : NSObject

+ (AFHTTPSessionManager *)shareInstance;

@end

//
//  XYConst.h
//  RenZhenMa
//
//  Created by qiaoxy on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kThemeColorStr = @"#25A857"; //更新我的收藏数量

#pragma mark - BaseURL

#ifdef DEBUG
//测试环境
static const NSString *baseURL = @"http://api.nongji360.com/";


#else
//生产环境
static const NSString *baseURL = @"http://api.nongji360.com/";

#endif



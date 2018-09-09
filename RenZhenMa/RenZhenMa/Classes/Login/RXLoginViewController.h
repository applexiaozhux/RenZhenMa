//
//  RXLoginViewController.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
// 登录

#import <UIKit/UIKit.h>

@interface RXLoginViewController : UIViewController

@property(nonatomic,copy) void (^loginDone)(BOOL success);

@end

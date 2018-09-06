//
//  XYTabBarController.h
//  YiTuoCompany
//
//  Created by xiyang on 2017/3/7.
//  Copyright © 2017年 xiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ChildViewControllerType) {
    ScanChildViewController,
    MineChildViewController
};

@interface XYTabBarController : UITabBarController


-(void)showLoginViewController;

-(void)showCurrentViewController:(ChildViewControllerType)type;



@end

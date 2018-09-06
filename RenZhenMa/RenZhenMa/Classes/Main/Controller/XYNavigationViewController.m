
//
//  XYNavigationViewController.m
//  YiTuoCompany
//
//  Created by xiyang on 2017/3/7.
//  Copyright © 2017年 xiyang. All rights reserved.
//

#import "XYNavigationViewController.h"
#import "XYConst.h"
#import "UIImage+XYColorString.h"
@interface XYNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation XYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName:[UIColor whiteColor]
                                            }];
    
    [navigationBar setBackgroundImage:[UIImage navigationBarImageWithColorString:kThemeColorStr] forBarMetrics:UIBarMetricsDefault];

    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        if ([UIApplication sharedApplication].statusBarStyle==UIStatusBarStyleLightContent) {
            [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }
    }
   
    [super pushViewController:viewController animated:animated];
    
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{

    if (self.viewControllers.count == 2) {
        
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        
    }
    
    return [super popViewControllerAnimated:animated];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}

// 允许同时响应多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:
            UIScreenEdgePanGestureRecognizer.class];
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    //控制器入栈之后,启用手势识别
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}

@end

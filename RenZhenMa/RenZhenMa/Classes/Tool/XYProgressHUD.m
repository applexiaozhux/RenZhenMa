//
//  XYProgressHUD.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYProgressHUD.h"
#import <SVProgressHUD.h>
@implementation XYProgressHUD

+(void)showMessage:(NSString *)message{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setInfoImage:[UIImage new]];
    [SVProgressHUD setImageViewSize:CGSizeZero];
    [SVProgressHUD showInfoWithStatus:message];
    
}

@end

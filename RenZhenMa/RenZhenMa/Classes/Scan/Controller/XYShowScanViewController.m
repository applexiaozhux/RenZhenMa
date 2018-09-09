//
//  XYShowScanViewController.m
//  RenZhenMa
//
//  Created by qiaoxy on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYShowScanViewController.h"
#import "XYZQRScanView.h"
#import "XYCommonHeader.h"
#import "RXScanCodeViewController.h"
#import "UIImage+XYColorString.h"
#import "RXWarningViewController.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
@interface XYShowScanViewController ()<XYZQRScanDelegate>
@property (nonatomic ,strong) XYZQRScanView *scanView;

@end

@implementation XYShowScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.scanView startScanning];
    [MobClick beginLogPageView:@"扫码界面"]; //("Pagename"为页面名称，可自定义)
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage navigationBarImageWithColorString:kThemeColorStr] forBarMetrics:UIBarMetricsDefault];
    [MobClick endLogPageView:@"扫码界面"];
}

-(void)initSubViews{
    
    [self.view addSubview:self.scanView];
    
    
    
    UIImage *leftImage = [[UIImage imageNamed:@"guanbi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick)];
    
}

-(void)leftBarButtonClick{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadData:(NSString *)urlPath{
    
   
    if ([urlPath hasPrefix:@"http://www.renzhenma.com"]&&[urlPath containsString:@"rzm="]) {
        NSArray *array = [urlPath componentsSeparatedByString:@"="];
        if (array.count == 2) {
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            RXScanCodeViewController *vc = [story instantiateViewControllerWithIdentifier:@"RXScanCodeViewController"];
            vc.valueStr = array.lastObject;
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
    }
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RXWarningViewController *vc = [story instantiateViewControllerWithIdentifier:@"RXWarningViewController"];
    vc.imgStr = @"warning_red";
    vc.warningContent = @"非常抱歉！你查询的认真码不存在!";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


#pragma mark - scanViewDelegate
- (void)scanView:(XYZQRScanView *)scanView pickUpMessage:(NSString *)message{
    [scanView stopScanning];
    NSLog(@"%@",message);
    
    [self uploadData:message];
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self.scanView startScanning];
//    }];
//    [alertController addAction:action];
//    [self presentViewController:alertController animated:YES completion:nil];
    //    [self showAlert:message action:^{
    //        [scanView startScanning];
    //    }];
}

#pragma mark - Getter

-(XYZQRScanView *)scanView{
    if (!_scanView) {
        _scanView = [[XYZQRScanView alloc]initWithFrame:self.view.bounds];
        _scanView.delegate = self;
        _scanView.scanLineColor = [UIColor colorWithString:kThemeColorStr];
        _scanView.cornerLineColor = [UIColor colorWithString:kThemeColorStr];
        _scanView.showBorderLine = YES;
    }
    return _scanView;
}


@end

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

-(void)initSubViews{
    
    [self.view addSubview:self.scanView];
    [self.scanView startScanning];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    UIImage *leftImage = [[UIImage imageNamed:@"guanbi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick)];
    
}

-(void)leftBarButtonClick{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - scanViewDelegate
- (void)scanView:(XYZQRScanView *)scanView pickUpMessage:(NSString *)message{
    [scanView stopScanning];
    NSLog(@"%@",message);
    
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

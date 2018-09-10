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
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
@interface XYShowScanViewController ()<XYZQRScanDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) XYZQRScanView *scanView;

@property (nonatomic ,strong) UIImagePickerController *imagePicker;

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
    
    UIButton *photoButton = [[UIButton alloc] init];
    photoButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [photoButton setTitle:@"相册" forState:UIControlStateNormal];
    photoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [photoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:photoButton];
    [photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-30);
        make.width.height.mas_equalTo(50);
    }];
    photoButton.layer.cornerRadius = 25;
    photoButton.layer.masksToBounds = YES;
    [photoButton addTarget:self action:@selector(photoClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *lightButton = [[UIButton alloc] init];
//    lightButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [lightButton setImage:[UIImage imageNamed:@"close_Sanguang"] forState:UIControlStateNormal];
    [lightButton setImage:[UIImage imageNamed:@"sanguang"] forState:UIControlStateSelected];
    [self.view addSubview:lightButton];
    [lightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.bottom.equalTo(self.view).offset(-30);
        make.width.height.mas_equalTo(50);
    }];
    lightButton.layer.cornerRadius = 25;
    lightButton.layer.masksToBounds = YES;
    [lightButton addTarget:self action:@selector(lightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)lightButtonClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.isSelected == YES) { //打开闪光灯
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        
        if ([captureDevice hasTorch]) {
            BOOL locked = [captureDevice lockForConfiguration:&error];
            if (locked) {
                captureDevice.torchMode = AVCaptureTorchModeOn;
                [captureDevice unlockForConfiguration];
            }
        }
    }else{//关闭闪光灯
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
    }

    
}
-(void)photoClick{
    
    [self openLibary];
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

- (void)openLibary{
    if (![self isLibaryAuthStatusCorrect]) {
        [XYProgressHUD showMessage:@"需要相册权限"];
        
        return;
    }
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}
- (NSString *)messageFromQRCodeImage:(UIImage *)image{
    if (!image) {
        return nil;
    }
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    NSArray *features = [detector featuresInImage:ciImage];
    if (features.count == 0) {
        return nil;
    }
    CIQRCodeFeature *feature = features.firstObject;
    return feature.messageString;
}
- (BOOL)isLibaryAuthStatusCorrect{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusNotDetermined || authStatus == PHAuthorizationStatusAuthorized) {
        return YES;
    }
    return NO;
}

#pragma mark - scanViewDelegate
- (void)scanView:(XYZQRScanView *)scanView pickUpMessage:(NSString *)message{
    [scanView stopScanning];
    
    [self uploadData:message];
}

#pragma mark - imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSString *result = [self messageFromQRCodeImage:image];
    if (result.length == 0) {
        [XYProgressHUD showMessage:@"未识别到二维码"];
//        [self showAlert:@"未识别到二维码" action:nil];
        return;
    }
    [self uploadData:result];
    NSLog(@"%@",result);
    
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

- (UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.navigationBar.tintColor = [UIColor whiteColor];
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return _imagePicker;
}
@end

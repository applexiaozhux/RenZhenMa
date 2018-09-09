//
//  RXScanCodeViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXScanCodeViewController.h"
#import "XYCommonHeader.h"
#import "RXQueryResultViewController.h"
#import "XYProductInfoModel.h"
#import "RXWarningViewController.h"
#import "UIButton+CountDown.h"
#import <UMAnalytics/MobClick.h>
@interface RXScanCodeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

- (IBAction)getCodeButtonClick;
- (IBAction)quaryButtonClick;

@end

@implementation RXScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"输入验证码";

    
//    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"扫码输入验证码界面"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"扫码输入验证码界面"];
}

//-(void)initSubViews{
//    
//    
//}
//
//-(void)requestData{
//    
//    
//    
//}


- (IBAction)getCodeButtonClick {
    
    if (![self.phoneTextField hasText]) {
        [XYProgressHUD showMessage:@"请输入手机号"];
        
        return;
    }
    if (![self.phoneTextField.text isMobileNumber]) {
        [XYProgressHUD showMessage:@"请输入正确的手机号码"];
        return;
    }
    if (self.valueStr == nil) {
        [XYProgressHUD showMessage:@"未获取到有效url"];
    
        return;
    }
    [_codeButton countDownFromTime:10 title:@"重新获取验证码" unitTitle:@"s" mainColor:[UIColor colorWithString:kThemeColorStr] countColor:[UIColor colorWithString:@"#999999"]];
    NSString *token = @"";
    NSString *wxid = @"0";
    if ([XYUserInfoManager isLogin]) {
        XYUserInfoModel *userInfo = [XYUserInfoManager shareInfoManager].userInfo;
        token = userInfo.token;
        wxid = userInfo.uid;
    }
    
    NSString *signature = [[NSString stringWithFormat:@"%@%@%@%@",wxid,self.valueStr,self.phoneTextField.text,token] md5];
    NSDictionary *params = @{@"qrcode":self.valueStr,@"wxid":wxid,@"token":token,@"phone":self.phoneTextField.text,@"signature":signature};
    
    [[XYNetworkManager defaultManager] post:@"getcode1" params:params success:^(id response, id responseObject) {
        [XYProgressHUD showMessage:@"验证码发送成功，请注意查收！"];
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (IBAction)quaryButtonClick {
    
    
    if (![self.phoneTextField hasText]) {
        [XYProgressHUD showMessage:@"请输入手机号"];
        
        return;
    }
    if (![self.phoneTextField.text isMobileNumber]) {
        [XYProgressHUD showMessage:@"请输入正确的手机号码"];
        return;
    }
    if (![self.codeTextField hasText]) {
        [XYProgressHUD showMessage:@"请输入验证码"];
        
        return;
    }
    NSString *token = @"";
    NSString *wxid = @"0";
    if ([XYUserInfoManager isLogin]) {
        XYUserInfoModel *userInfo = [XYUserInfoManager shareInfoManager].userInfo;
        token = userInfo.token;
        wxid = userInfo.uid;
    }
    
    NSString *signature = [[NSString stringWithFormat:@"%@%@%@%@%@",wxid,self.valueStr,self.phoneTextField.text,self.codeTextField.text,token] md5];
    NSDictionary *params = @{@"qrcode":self.valueStr,@"wxid":wxid,@"token":token,@"phone":self.phoneTextField.text,@"code":self.codeTextField.text,@"signature":signature};
    
    
    XYNetworkManager *manager = [XYNetworkManager defaultManager];
    manager.isShowHUD = NO;
    [manager post:@"getgoodinfo" params:params success:^(id response, id responseObject) {
        
        XYProductInfoModel *infoModel = [XYProductInfoModel modelWithDictionary:response];
        RXQueryResultViewController *reaultVC = [[RXQueryResultViewController alloc] init];
        reaultVC.infoModel = infoModel;
        [self.navigationController pushViewController:reaultVC animated:YES];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        switch (error.code) {
            case 2:
                [SVProgressHUD showErrorWithStatus:error.domain];
                break;
            case 3:{
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                RXWarningViewController *vc = [story instantiateViewControllerWithIdentifier:@"RXWarningViewController"];
                vc.imgStr = @"warning_red";
                [self.navigationController pushViewController:vc animated:YES];
            }
                
                break;
            case 4:{
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                RXWarningViewController *vc = [story instantiateViewControllerWithIdentifier:@"RXWarningViewController"];
                vc.imgStr = @"warning_orange";
                [self.navigationController pushViewController:vc animated:YES];
            }
                
                break;
            case 5:{
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                RXWarningViewController *vc = [story instantiateViewControllerWithIdentifier:@"RXWarningViewController"];
                vc.imgStr = @"sad";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
            {
                [SVProgressHUD showErrorWithStatus:error.domain];
            }
                
                break;
        }
       
        
        
    }];
    
    
}
@end

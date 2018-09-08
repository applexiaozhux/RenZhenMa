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
@interface RXScanCodeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

- (IBAction)getCodeButtonClick;
- (IBAction)quaryButtonClick;

@end

@implementation RXScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"输入验证码";

    
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSubViews{
    
    
}

-(void)requestData{
    
    
    
}


- (IBAction)getCodeButtonClick {
    
    if (![self.phoneTextField hasText]) {
        [SVProgressHUD showErrorWithStatus:@"请先输入手机号"];
        return;
    }
    
    XYUserInfoModel *userInfo = [XYUserInfoManager shareInfoManager].userInfo;
    NSString *signature = [[NSString stringWithFormat:@"%@%@%@%@",userInfo.uid,self.valueStr,self.phoneTextField.text,userInfo.token] md5];
    NSDictionary *params = @{@"qrcode":self.valueStr,@"wxid":userInfo.uid,@"token":userInfo.token,@"phone":self.phoneTextField.text,@"signature":signature};
    
    [[XYNetworkManager defaultManager] post:@"getcode1" params:params success:^(id response, id responseObject) {
        
        [SVProgressHUD showSuccessWithStatus:@"验证码已发送，请注意查收!"];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (IBAction)quaryButtonClick {
    
    
    if (![self.phoneTextField hasText]) {
        [SVProgressHUD showErrorWithStatus:@"请先输入手机号"];
        return;
    }
    if (![self.codeTextField hasText]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    XYUserInfoModel *userInfo = [XYUserInfoManager shareInfoManager].userInfo;
    NSString *signature = [[NSString stringWithFormat:@"%@%@%@%@%@",userInfo.uid,self.valueStr,self.phoneTextField.text,self.codeTextField.text,userInfo.token] md5];
    NSDictionary *params = @{@"qrcode":self.valueStr,@"wxid":userInfo.uid,@"token":userInfo.token,@"phone":self.phoneTextField.text,@"code":self.codeTextField.text,@"signature":signature};
    
    [[XYNetworkManager defaultManager] post:@"getgoodinfo" params:params success:^(id response, id responseObject) {
        
        
        RXQueryResultViewController *reaultVC = [[RXQueryResultViewController alloc] init];
        [self.navigationController pushViewController:reaultVC animated:YES];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
@end

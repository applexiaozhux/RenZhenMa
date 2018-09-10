//
//  RXLoginViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXLoginViewController.h"
#import "XYCommonHeader.h"
#import "UIButton+CountDown.h"
#import "XYNormalWebViewController.h"
#import <UMAnalytics/MobClick.h>
@interface RXLoginViewController ()
- (IBAction)loginButtonClick;
- (IBAction)getCodeAction;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;

- (IBAction)serviceButtonAction;

@property (nonatomic,assign) BOOL isLoginSuccess;
@end

@implementation RXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.title = @"登录";
    [self initSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}


-(void)initSubView{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"guanbi"] style:UIBarButtonItemStylePlain target:self action:@selector(closeClick)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)closeClick{
    if (self.loginDone) {
        self.loginDone(self.isLoginSuccess);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonClick {
    
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
    NSDictionary *params = @{@"phone":self.phoneTextField.text,@"code":self.codeTextField.text};
    
    [[XYNetworkManager defaultManager] post:@"login" params:params success:^(id response, id responseObject) {
        NSDictionary *info = (NSDictionary *)response;
        XYUserInfoModel *userInfo = [XYUserInfoModel modelWithDictionary:info];
        [XYUserInfoManager shareInfoManager].userInfo = userInfo;
        self.isLoginSuccess = YES;
        [self closeClick];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    

}

- (IBAction)getCodeAction {
    
    if (![self.phoneTextField hasText]) {
        [XYProgressHUD showMessage:@"请输入手机号"];
        return;
    }
    
    if (![self.phoneTextField.text isMobileNumber]) {
        [XYProgressHUD showMessage:@"请输入正确的手机号码"];
        return;
    }
    
    
    [_codeButton countDownFromTime:90 title:@"重新获取验证码" unitTitle:@"s" mainColor:[UIColor colorWithString:kThemeColorStr] countColor:[UIColor colorWithString:@"#999999"]];
    
    NSDictionary *params = @{@"phone":self.phoneTextField.text};
    
    [[XYNetworkManager defaultManager] post:@"getPhoneCode" params:params success:^(id response, id responseObject) {
        [XYProgressHUD showMessage:@"验证码发送成功，请注意查收！"];
    
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (IBAction)serviceButtonAction {
    
    XYNormalWebViewController *webVC = [[XYNormalWebViewController alloc] init];
    webVC.urlStr = @"http://www.renzhenma.com/agreement.html";
    webVC.title = @"用户协议";
    [self.navigationController pushViewController:webVC animated:YES];
    
}
@end

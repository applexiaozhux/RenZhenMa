//
//  RXLoginViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXLoginViewController.h"
#import "XYCommonHeader.h"

@interface RXLoginViewController ()
- (IBAction)loginButtonClick;
- (IBAction)getCodeAction;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

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

-(void)initSubView{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"guanbi"] style:UIBarButtonItemStylePlain target:self action:@selector(closeClick)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)closeClick{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonClick {
    
    if (![self.phoneTextField hasText]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (![self.codeTextField hasText]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    NSDictionary *params = @{@"phone":self.phoneTextField.text,@"code":self.codeTextField.text};
    
    [[XYNetworkManager defaultManager] post:@"login" params:params success:^(id response, id responseObject) {
        NSDictionary *info = (NSDictionary *)response;
        XYUserInfoModel *userInfo = [XYUserInfoModel modelWithDictionary:info];
        [XYUserInfoManager shareInfoManager].userInfo = userInfo;
        [self closeClick];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    

}

- (IBAction)getCodeAction {
    
    if (![self.phoneTextField hasText]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    
    NSDictionary *params = @{@"phone":self.phoneTextField.text};
    
    [[XYNetworkManager defaultManager] post:@"getPhoneCode" params:params success:^(id response, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"验证码发送成功，请注意查收！"];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
@end

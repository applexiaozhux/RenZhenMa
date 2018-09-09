//
//  XYNotificationViewController.m
//  RenZhenMa
//
//  Created by 李瑞星 on 2018/9/9.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYNotificationViewController.h"
#import "XYCommonHeader.h"
#import "XYNotificationModel.h"
@interface XYNotificationViewController ()

@end

@implementation XYNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSubView{
    
}

-(void)requestData{
    NSDictionary *params = @{@"id":self.model.ID};
    [[XYNetworkManager defaultManager] post:@"getInforminfo" params:params success:^(id response, id responseObject) {
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

@end

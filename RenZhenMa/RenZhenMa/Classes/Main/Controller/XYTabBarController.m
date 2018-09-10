
//
//  XYTabBarController.m
//  YiTuoCompany
//
//  Created by xiyang on 2017/3/7.
//  Copyright © 2017年 xiyang. All rights reserved.
//

#import "XYTabBarController.h"
#import "XYNavigationViewController.h"
#import "XYScanMainViewController.h"
#import "XYMineMainViewController.h"
#import "XYCommonHeader.h"
#import "RXLocationManager.h"
#import "XYAdvicationModel.h"
@interface XYTabBarController ()<UITabBarControllerDelegate>

@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loactionEndNotify) name:NotificationLocation_End object:nil];

    [RXLocationManager getLocationWithBlock:^(TJLocationDataType type,NSString *record, NSString *locality, NSString *subLocality) {
    }];

    [self initSubViews];
    [self refreshToken];
    self.delegate = self;

}
//通知方法调用
- (void)loactionEndNotify {
    
    NSString *localitystr = [RXLocationManager manager].nowlocality;
    DLog(@"%@",localitystr);
    [self requestNotification:localitystr];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSubViews{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    XYScanMainViewController *scanVC = [[XYScanMainViewController alloc] init];
    [self addController:scanVC normalImageNamed:@"scan" selecteImageNamed:@"scan_pre" titile:@"扫一扫"];
    
    XYMineMainViewController *mineVC = [[XYMineMainViewController alloc] init];
    [self addController:mineVC normalImageNamed:@"my" selecteImageNamed:@"my_pre" titile:@"我的"];
    self.tabBar.tintColor = [UIColor colorWithString:kThemeColorStr];
    self.tabBar.backgroundColor = [UIColor whiteColor];
}

-(void)requestNotification:(NSString *)city{
    
    if (city == nil) {
        return;
    }
    XYNetworkManager *manager = [XYNetworkManager defaultManager];
    NSDictionary *params = @{@"city":city};
    manager.isShowHUD = NO;
    [manager post:@"getad" params:params success:^(id response, id responseObject) {
        
        XYAdvicationModel *model = [XYAdvicationModel modelWithDictionary:response];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAdvKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


-(void)refreshToken{
    
    if ([XYUserInfoManager isLogin]) {
        XYUserInfoModel *userInfo = [XYUserInfoManager shareInfoManager].userInfo;
        NSString *signature = [NSString stringWithFormat:@"%@%@",userInfo.uid,userInfo.token];
        NSDictionary *params = @{@"wxid":userInfo.uid,@"token":userInfo.token,@"signature":[signature md5]};
        XYNetworkManager *manager = [XYNetworkManager defaultManager];
        manager.isShowHUD = NO;
        [manager post:@"getToken" params:params success:^(id response, id responseObject) {
            NSDictionary *dic = (NSDictionary *)response;
            userInfo.token = dic[@"token"];
            [XYUserInfoManager shareInfoManager].userInfo = userInfo;
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)addController:(UIViewController *)controller normalImageNamed:(NSString *)normal selecteImageNamed:(NSString *)selecte titile:(NSString *)title{
    
    XYNavigationViewController *navigationVC = [[XYNavigationViewController alloc] initWithRootViewController:controller];
    if (normal&&normal.length>0) {
        navigationVC.tabBarItem.image = [[UIImage imageNamed:normal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if (selecte&&selecte.length>0) {
        navigationVC.tabBarItem.selectedImage = [[UIImage imageNamed:selecte] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    navigationVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    navigationVC.tabBarItem.title = title;
    
    [self addChildViewController:navigationVC];
    
}

#pragma mark - UITabBarControllerDelegate






@end

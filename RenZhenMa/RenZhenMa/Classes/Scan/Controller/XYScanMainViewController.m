//
//  XYScanMainViewController.m
//  RenZhenMa
//
//  Created by qiaoxy on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYScanMainViewController.h"
#import "XYCommonHeader.h"
#import "XYShowScanViewController.h"
#import "XYNavigationViewController.h"
#import "RippleAnimationView.h"
#import <UMAnalytics/MobClick.h>
#import "MarqueeView.h"
@interface XYScanMainViewController ()

@property(nonatomic,retain)UIButton *scanButton;

@property(nonatomic,retain)UIImageView *iconImageView;
@property (nonatomic, strong) MarqueeView *marqueeView;
@property(nonatomic,strong) UIView *headerView;
@end

@implementation XYScanMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"认证码";
    [self initSubViews];
    [self configureTongzhi];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"扫码首页"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"扫码首页"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSubViews{
    self.view.backgroundColor = [UIColor colorWithString:kThemeColorStr];
    
    RippleAnimationView *viewA = [[RippleAnimationView alloc] initWithFrame:self.scanButton.bounds animationType:AnimationTypeWithBackground];
    [self.view addSubview:viewA];
    
    [self.view addSubview:self.scanButton];
    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(100);
        make.right.equalTo(self.view).offset(-100);
        make.height.equalTo(self.scanButton.mas_width).multipliedBy(1.0f);
        make.centerY.equalTo(self.view).offset(-100);
    }];
    
    [viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.scanButton);
        make.width.height.equalTo(self.scanButton);
    }];
    
    
    [self.view addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-(KTabBar_Height + 30));
        make.centerX.equalTo(self.view);
    }];
    
    
    
    
}

-(void)configureTongzhi{
    
    self.headerView = [[UIView alloc] init];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    
    [self.headerView addSubview:self.marqueeView];
    [self.marqueeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerView);
    }];
    
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setImage:[UIImage imageNamed:@"close_home"] forState:UIControlStateNormal];
    [self.headerView addSubview:closeButton];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headerView).offset(-15);
        make.centerY.equalTo(self.headerView);
    }];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)closeButtonClick{
    
    self.headerView.hidden = YES;
    
}

//扫描
-(void)scanButtonClick{
    
    XYShowScanViewController *scanVC = [[XYShowScanViewController alloc] init];
    
    XYNavigationViewController *naviVC = [[XYNavigationViewController alloc] initWithRootViewController:scanVC];
    [self presentViewController:naviVC animated:YES completion:nil];
    

}




#pragma mark - Getter
-(UIButton *)scanButton{
    if (!_scanButton) {
        _scanButton = [[UIButton alloc] init];
        [_scanButton setImage:[UIImage imageNamed:@"scan_home_t"] forState:UIControlStateNormal];
        _scanButton.backgroundColor = [UIColor clearColor];
        [_scanButton addTarget:self action:@selector(scanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slogn"]];
    }
    return _iconImageView;
}

- (MarqueeView *)marqueeView{
    
    if (!_marqueeView) {
        MarqueeView *marqueeView =[[MarqueeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30) withTitle:@[@"1.我觉得封装好好玩",@"2.经常玩玩可以锻炼自己的技术耶",@"3.所以要经常经常玩玩，这样才能更加完美",@"4.你说对不对",@"end"]];
        marqueeView.titleColor = [UIColor colorWithString:@"#DD7536"];
        marqueeView.titleFont = [UIFont systemFontOfSize:16];
        marqueeView.backgroundColor = [UIColor colorWithString:@"#FDFCEA"];
        __weak MarqueeView *marquee = marqueeView;
        marqueeView.handlerTitleClickCallBack = ^(NSInteger index){
            
            NSLog(@"%@----%zd",marquee.titleArr[index-1],index);
        };
        _marqueeView = marqueeView;
    }
    return _marqueeView;
    
}


@end

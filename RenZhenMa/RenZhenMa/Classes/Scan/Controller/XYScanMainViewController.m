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
@interface XYScanMainViewController ()

@property(nonatomic,retain)UIButton *scanButton;

@property(nonatomic,retain)UIImageView *iconImageView;

@end

@implementation XYScanMainViewController

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
    self.view.backgroundColor = [UIColor colorWithString:kThemeColorStr];
    
    [self.view addSubview:self.scanButton];
    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
    }];
    
    [self.view addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-(KTabBar_Height + 30));
        make.centerX.equalTo(self.view);
    }];
    
}

//扫描
-(void)scanButtonClick{
    
    XYShowScanViewController *scanVC = [[XYShowScanViewController alloc] init];
    
    [self.navigationController pushViewController:scanVC animated:YES];
}




#pragma mark - Getter
-(UIButton *)scanButton{
    if (!_scanButton) {
        _scanButton = [[UIButton alloc] init];
        [_scanButton setImage:[UIImage imageNamed:@"scan_home"] forState:UIControlStateNormal];
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



@end

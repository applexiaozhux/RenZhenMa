//
//  XYScanMainViewController.m
//  RenZhenMa
//
//  Created by qiaoxy on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYScanMainViewController.h"
#import "XYCommonHeader.h"
@interface XYScanMainViewController ()

@property(nonatomic,retain)UIButton *scanButton;

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
        make.top.equalTo(self.view).offset(80);
    }];
    
}


#pragma mark - Getter
-(UIButton *)scanButton{
    if (!_scanButton) {
        _scanButton = [[UIButton alloc] init];
        [_scanButton setImage:[UIImage imageNamed:@"scan_home"] forState:UIControlStateNormal];
    }
    return _scanButton;
}

@end

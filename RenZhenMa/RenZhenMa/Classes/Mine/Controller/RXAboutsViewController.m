//
//  RXAboutsViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXAboutsViewController.h"
#import "XYCommonHeader.h"

@interface RXAboutsViewController ()

@end

@implementation RXAboutsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于我们";
    self.view.backgroundColor = DeviceBackGroundColor;

    [self initView];
}

-(void)initView{
    UIImageView *iconImg = [[UIImageView alloc] init];
    [iconImg setImage:[UIImage imageNamed:@"mine_settings"]];
    [self.view addSubview:iconImg];
//    iconImg.layer.masksToBounds = YES;

    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@SCALE375_WIDTH(120));
        make.height.equalTo(@SCALE375_WIDTH(120));
        make.centerY.equalTo(self.view.mas_centerY).offset(-SCALE375_WIDTH(30));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.font = [UIFont systemFontOfSize:SCALE375_WIDTH(13)];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor colorWithString:kThemeColorStr];
    nameLab.text = [NSString stringWithFormat:@"当前版本：V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [self.view addSubview:nameLab];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom).offset(-SCALE375_WIDTH(20));
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@SCALE375_WIDTH(15));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

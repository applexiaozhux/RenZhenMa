//
//  RXWarningViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXWarningViewController.h"
#import "XYCommonHeader.h"
#import <UMAnalytics/MobClick.h>
@interface RXWarningViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *waringImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (IBAction)backClick;


@end

@implementation RXWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"警告";
    
    self.waringImageView.image = [UIImage imageNamed:self.imgStr];
    if (self.warningContent != nil) {
        self.contentLabel.text = self.warningContent;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"警告界面"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"警告界面"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backClick {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
@end

//
//  XYNormalWebViewController.m
//  RenZhenMa
//
//  Created by 李瑞星 on 2018/9/9.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYNormalWebViewController.h"
#import <WebKit/WebKit.h>
#import "XYCommonHeader.h"
@interface XYNormalWebViewController ()<WKNavigationDelegate>

@property (nonatomic,retain) WKWebView *webView;

@end

@implementation XYNormalWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"用户协议";
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSubViews{
    
    self.webView = [[WKWebView alloc] init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.webView.navigationDelegate = self;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
    
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}

@end

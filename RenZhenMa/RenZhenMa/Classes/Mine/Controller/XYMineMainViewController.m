//
//  XYMineMainViewController.m
//  RenZhenMa
//
//  Created by qiaoxy on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYMineMainViewController.h"
#import "XYCommonHeader.h"
#import "MineTableViewCell.h"
#import "RXScanRecordViewController.h"
#import "RXFeedRecordViewController.h"
#import "RXIdeaFeedbackViewController.h"
#import "RXSettingViewController.h"
#import "XYNavigationViewController.h"
static NSString *MineTableViewCellIdentifier = @"MineTableViewCellIdentifier";

@interface XYMineMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArr;

@end

@implementation XYMineMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = DeviceBackGroundColor;
    
    self.title = @"我的";
    _listArr = [NSMutableArray array];
    [_listArr addObjectsFromArray:@[@{@"name":@"扫描记录",@"icon":@"mine_settings"},@{@"name":@"反馈记录",@"icon":@"mine_settings"},@{@"name":@"意见反馈",@"icon":@"mine_settings"},@{@"name":@"设置",@"icon":@"mine_settings"}]];
    [self initView];
    
}


//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    XYNavigationViewController *naviVC = (XYNavigationViewController *)self.navigationController;
//    [naviVC showShadowImageView:NO];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    XYNavigationViewController *naviVC = (XYNavigationViewController *)self.navigationController;
//    [naviVC showShadowImageView:YES];
//}

-(void)initView{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE375_WIDTH(95)+KNavigationBar_Height)];
    [headView setBackgroundColor:[UIColor colorWithString:kThemeColorStr]];
    [self.view addSubview:headView];
    
    UIImageView *iconImg = [[UIImageView alloc] init];
    [iconImg setImage:[UIImage imageNamed:@"mine_settings"]];
    [headView addSubview:iconImg];
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = SCALE375_WIDTH(50)/2;
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@SCALE375_WIDTH(50));
        make.height.equalTo(@SCALE375_WIDTH(50));
        make.centerY.equalTo(headView.mas_centerY).offset(-10);
        make.centerX.equalTo(headView.mas_centerX);
    }];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.font = [UIFont systemFontOfSize:SCALE375_WIDTH(15)];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor whiteColor];
    nameLab.text = @"测试";
    [headView addSubview:nameLab];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_left);
        make.top.equalTo(iconImg.mas_bottom).offset(15);
        make.right.equalTo(headView.mas_right);
        make.height.equalTo(@SCALE375_WIDTH(15));
    }];
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.rowHeight = SCALE375_WIDTH(47);
        tableView.tableFooterView = [[UIView alloc]init];
        [tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:MineTableViewCellIdentifier];
        tableView.backgroundColor = DeviceBackGroundColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableHeaderView = headView;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
    
    UIView *underView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, SCREEN_WIDTH, 300)];
    underView.backgroundColor = [UIColor colorWithString:kThemeColorStr];
    [self.tableView addSubview:underView];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineTableViewCellIdentifier];
    NSDictionary *item = self.listArr[indexPath.row];
    [cell.imgView setImage:[UIImage imageNamed:[item objectForKey:@"icon"]]];
    cell.titleL.text = [item objectForKey:@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row ==0) {//扫描记录
        RXScanRecordViewController *vc = [[RXScanRecordViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {//反馈记录
        RXFeedRecordViewController *vc = [[RXFeedRecordViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2) {//意见反馈
        RXIdeaFeedbackViewController *vc = [[RXIdeaFeedbackViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{//设置
        RXSettingViewController *vc = [[RXSettingViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

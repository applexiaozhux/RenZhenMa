//
//  XYMineMainViewController.m
//  RenZhenMa
//
//  Created by qiaoxy on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYMineMainViewController.h"
#import "XYCommonHeader.h"
#import "XYNavigationViewController.h"
#import "MineTableViewCell.h"
#import "RXScanRecordViewController.h"
#import "RXFeedRecordViewController.h"
#import "RXIdeaFeedbackViewController.h"
#import "RXSettingViewController.h"
#import "RXLoginViewController.h"
#import "XYNavigationViewController.h"
#import "RXQueryResultViewController.h"

static NSString *MineTableViewCellIdentifier = @"MineTableViewCellIdentifier";

@interface XYMineMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArr;
@property(nonatomic,retain) UILabel *nameLab;
@property(nonatomic,retain) UIImageView *iconImg;
@end

@implementation XYMineMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = DeviceBackGroundColor;
    
    self.title = @"我的";
    _listArr = [NSMutableArray array];
    [_listArr addObjectsFromArray:@[@{@"name":@"扫描记录",@"icon":@"jilu"},@{@"name":@"反馈记录",@"icon":@"menu"},@{@"name":@"意见反馈",@"icon":@"jainyi"},@{@"name":@"设置",@"icon":@"set"}]];
    [self initView];
    [self configureNotification];
}


-(void)initView{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE375_WIDTH(95)+KNavigationBar_Height)];
    [headView setBackgroundColor:[UIColor colorWithString:kThemeColorStr]];
    [self.view addSubview:headView];
    
    self.iconImg = [[UIImageView alloc] init];
    [self.iconImg setImage:[UIImage imageNamed:@"user2"]];
    [headView addSubview:self.iconImg];
    self.iconImg.layer.masksToBounds = YES;
    self.iconImg.layer.cornerRadius = SCALE375_WIDTH(80)/2;
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@SCALE375_WIDTH(80));
        make.height.equalTo(@SCALE375_WIDTH(80));
        make.centerY.equalTo(headView.mas_centerY).offset(-10);
        make.centerX.equalTo(headView.mas_centerX);
    }];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont systemFontOfSize:SCALE375_WIDTH(15)];
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.textColor = [UIColor whiteColor];
    self.nameLab.text = @"登录";
    [headView addSubview:self.nameLab];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_left);
        make.top.equalTo(self.iconImg.mas_bottom).offset(15);
        make.right.equalTo(headView.mas_right);
        make.height.equalTo(@SCALE375_WIDTH(15));
    }];
    
    UIButton *headBtn = [[UIButton alloc] init];
    headBtn.backgroundColor = [UIColor clearColor];
    [headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:headBtn];
    
    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_left);
        make.right.equalTo(self.iconImg.mas_right);
        make.top.equalTo(self.iconImg.mas_top);
        make.bottom.equalTo(self.nameLab.mas_bottom);
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
    
    
    [self configureUserHeader];
}

-(void)configureNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureUserHeader) name:kLogoutSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureUserHeader) name:kLoginSuccess object:nil];
}

-(void)configureUserHeader{
    
    if ([XYUserInfoManager isLogin]) {
        XYUserInfoModel *userInfo = [XYUserInfoManager shareInfoManager].userInfo;
        self.nameLab.text = userInfo.nickName;
        NSString *placeImageStr = @"avatar_man";
        if ([userInfo.gender isEqualToString:@"2"]) {
            placeImageStr = @"avatar_woman";
        }
        
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:userInfo.avatarUrl] placeholderImage:[UIImage imageNamed:placeImageStr]];
        
    }else{
        self.nameLab.text = @"登录";
        [self.iconImg setImage:[UIImage imageNamed:@"user2"]];\
    }
    
}


#pragma mark - 点击头像
-(void)headBtnClick{
    
    if ([XYUserInfoManager isLogin]) {
        
    }else{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RXLoginViewController *vc = [story instantiateViewControllerWithIdentifier:@"RXLoginViewController"];
        XYNavigationViewController *naviVC = [[XYNavigationViewController alloc] initWithRootViewController:vc];
        [self presentViewController:naviVC animated:YES completion:nil];
    }
    
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
    

//    RXQueryResultViewController *vc = [[RXQueryResultViewController alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];

    if (indexPath.row ==0) {//扫描记录
        [XYUserInfoManager showLoginViewController:^(BOOL success) {
            if (success) {
                RXScanRecordViewController *vc = [[RXScanRecordViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } controller:self];
        
    }else if (indexPath.row == 1) {//反馈记录
        [XYUserInfoManager showLoginViewController:^(BOOL success) {
            if (success) {
                RXFeedRecordViewController *vc = [[RXFeedRecordViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } controller:self];
        
    }else if (indexPath.row == 2) {//意见反馈
        [XYUserInfoManager showLoginViewController:^(BOOL success) {
            if (success) {
                RXIdeaFeedbackViewController *vc = [[RXIdeaFeedbackViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } controller:self];
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
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end

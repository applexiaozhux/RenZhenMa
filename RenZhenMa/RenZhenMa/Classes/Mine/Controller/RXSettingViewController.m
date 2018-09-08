//
//  RXSettingViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXSettingViewController.h"
#import "XYCommonHeader.h"
#import "RXAboutsViewController.h"

@interface RXSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArr;
@end

@implementation RXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    self.view.backgroundColor = DeviceBackGroundColor;
    _listArr = [NSMutableArray array];
    [_listArr addObjectsFromArray:@[@"关于我们",@"退出"]];
    
    [self initView];
}

-(void)initView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.rowHeight = SCALE375_WIDTH(47);
        tableView.backgroundColor = DeviceBackGroundColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc]init];
        tableView;
    });
    [self.view addSubview:self.tableView];

}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.textColor = [UIColor colorWithString:@"#333333"];
    cell.textLabel.text = self.listArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row ==0) {//关于我们
        RXAboutsViewController *vc = [[RXAboutsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {//退出登录
        [self quitBtnClick];
    }
}

#pragma mark - 点击退出登录
-(void)quitBtnClick{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self logOutEvent];
    }];
    [alert addAction:cancle];
    [alert addAction:sure];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

-(void)logOutEvent{
    
    [[XYUserInfoManager shareInfoManager] logOut];
    [self.navigationController popViewControllerAnimated:YES];
   
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

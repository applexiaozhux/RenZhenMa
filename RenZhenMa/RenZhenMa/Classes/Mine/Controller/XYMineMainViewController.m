//
//  XYMineMainViewController.m
//  RenZhenMa
//
//  Created by qiaoxy on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYMineMainViewController.h"
#import "MineTableViewCell.h"
#import "XYCommonHeader.h"

static NSString *MineTableViewCellIdentifier = @"MineTableViewCellIdentifier";

@interface XYMineMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArr;

@end

@implementation XYMineMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的";
    _listArr = [NSMutableArray array];
    [_listArr addObjectsFromArray:@[@{@"name":@"扫描记录",@"icon":@"mine_settings"},@{@"name":@"范反馈记录",@"icon":@"mine_settings"},@{@"name":@"意见反馈",@"icon":@"mine_settings"},@{@"name":@"设置",@"icon":@"mine_settings"}]];
    [self initView];
    
}


-(void)initView{
    self.view.backgroundColor = DeviceBackGroundColor;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE375_WIDTH(95)+KNavigationBar_Height)];
    [headView setBackgroundColor:[UIColor colorWithString:kThemeColorStr]];
    [self.view addSubview:headView];
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
    
}


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
        
    }else if (indexPath.row == 1) {//反馈记录
        
    }else if (indexPath.row == 2) {//意见反馈

    }else{//设置

    }
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

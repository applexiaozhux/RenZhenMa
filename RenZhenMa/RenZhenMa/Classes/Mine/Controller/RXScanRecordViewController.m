//
//  RXScanRecordViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXScanRecordViewController.h"
#import "XYCommonHeader.h"
#import "RXScanRecord.h"
#import "RXScanRecordModel.h"

@interface RXScanRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArr;

@end

@implementation RXScanRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫描记录";
    self.view.backgroundColor = DeviceBackGroundColor;
    _listArr = [NSMutableArray array];
    
    [self initView];
    
    [self loadData];
}

-(void)initView{
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.rowHeight = SCALE375_WIDTH(47);
        tableView.tableFooterView = [[UIView alloc]init];
        [tableView registerNib:[UINib nibWithNibName:@"RXScanRecord" bundle:nil] forCellReuseIdentifier:@"RXScanRecord"];
        tableView.backgroundColor = DeviceBackGroundColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = SCALE375_WIDTH(107);
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.separatorColor = DeviceLineViewColor;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
}

//获取扫描记录调用接口（扫描记录页） code为1时，把info数据显示出来。 code不为1，根据返回结果message给出提示
-(void)loadData{
    [self.listArr removeAllObjects];
    if (![XYUserInfoManager isLogin]) {
        return;
    }
    XYUserInfoModel *userinfo = [XYUserInfoManager shareInfoManager].userInfo;
    NSDictionary *dic=@{@"wxid":userinfo.uid,@"page":@"1",@"num":@"10",@"token":userinfo.token};
    
    [[XYNetworkManager defaultManager] post:@"scanRecord" params:dic success:^(id response, id responseObject) {
        NSArray *data = (NSArray *)response;
        for (NSDictionary *list in data) {
            RXScanRecordModel *model = [RXScanRecordModel modelWithDictionary:list];
            [self.listArr addObject:model];
        }
        [self.tableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma mark - <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
//    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RXScanRecord *cell = [tableView dequeueReusableCellWithIdentifier:@"RXScanRecord"];
    RXScanRecordModel *model = self.listArr[indexPath.row];
    [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:model.simg]];
    cell.titleLab.text = model.goods_name;
    cell.detailLab.text = model.key_name;
    cell.timeLab.text = model.utime;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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

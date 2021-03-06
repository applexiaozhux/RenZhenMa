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
#import <MJRefresh.h>
#import "RXQueryResultViewController.h"
@interface RXScanRecordViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArr;
@property(nonatomic,assign)NSInteger page;
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
    self.page = 1;
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
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
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    
}

//获取扫描记录调用接口（扫描记录页） code为1时，把info数据显示出来。 code不为1，根据返回结果message给出提示
-(void)loadData{
    if (![XYUserInfoManager isLogin]) {
        return;
    }
    XYUserInfoModel *userinfo = [XYUserInfoManager shareInfoManager].userInfo;
    NSDictionary *dic=@{@"wxid":userinfo.uid,@"page":@(self.page),@"num":@"10",@"token":userinfo.token};
    
    [[XYNetworkManager defaultManager] post:@"scanRecord" params:dic success:^(id response, id responseObject) {
        
        NSArray *data = (NSArray *)response;
        if (data.count == 0) {
            [XYProgressHUD showMessage:@"没有更多数据了"];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self.tableView.mj_footer endRefreshing];
        for (NSDictionary *list in data) {
            RXScanRecordModel *model = [RXScanRecordModel modelWithDictionary:list];
            [self.listArr addObject:model];
        }
        [self.tableView reloadData];
        self.page += 1;
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
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
    
    [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:model.simg] placeholderImage:[UIImage imageNamed:@"photoPlacehold"]];
    cell.titleLab.text = model.goods_name;
    cell.detailLab.text = model.key_name;
    cell.timeLab.text = model.utime;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    RXQueryResultViewController *resultVC = [[RXQueryResultViewController alloc] init];
//
//    [self.navigationController pushViewController:resultVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"null"];
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [[NSAttributedString alloc] initWithString:@"暂无数据" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
}

@end

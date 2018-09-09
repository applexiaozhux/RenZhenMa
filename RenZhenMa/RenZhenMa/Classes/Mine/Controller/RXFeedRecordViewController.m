//
//  RXFeedRecordViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXFeedRecordViewController.h"
#import "XYCommonHeader.h"
#import "RXFeedRecordCell.h"
#import "RXFeedRecordModel.h"
#import <MJRefresh.h>
@interface RXFeedRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArr;
@property(nonatomic,assign) NSInteger page;
@end

@implementation RXFeedRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"反馈记录";
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
        tableView.rowHeight = SCALE375_WIDTH(47);
        tableView.tableFooterView = [[UIView alloc]init];
        [tableView registerNib:[UINib nibWithNibName:@"RXFeedRecordCell" bundle:nil] forCellReuseIdentifier:@"RXFeedRecordCell"];
        tableView.backgroundColor = DeviceBackGroundColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = SCALE375_WIDTH(107);
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.separatorColor = DeviceLineViewColor;
        tableView;
    });
    [self.view addSubview:self.tableView];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadData];
    }];
    
}
//获取反馈记录调用接口（反馈记录页） code为1时，把info数据显示出来。 code不为1，根据返回结果message给出提示
-(void)loadData{

    [XYUserInfoManager showLoginViewController:^(BOOL success) {
        if (success) {
            [self requestData];
        }else{
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
        }
    } controller:self];

  
}

-(void)requestData{
    
    XYUserInfoModel *userinfo = [XYUserInfoManager shareInfoManager].userInfo;
    NSDictionary *dic=@{@"wxid":userinfo.uid,@"page":@(self.page),@"num":@"10",@"token":userinfo.token};
    
    
    [[XYNetworkManager defaultManager] post:@"getSuggest" params:dic success:^(id response, id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (self.page == 1) {
            [self.listArr removeAllObjects];
        }
        NSArray *data = (NSArray *)response;
        if (data.count == 0) {
            [XYProgressHUD showMessage:@"没有更多数据了"];
            
            return ;
        }
        for (NSDictionary *list in data) {
            RXFeedRecordModel *model = [RXFeedRecordModel modelWithDictionary:list];
            [self.listArr addObject:model];
        }
        [self.tableView reloadData];
        self.page += 1;
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RXFeedRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RXFeedRecordCell"];
    RXFeedRecordModel *model = self.listArr[indexPath.row];

    cell.titleLab.text = model.sinfo;
    NSString *str = @"";
    if (model.status&&[model.status isEqualToString:@"1"]) {
        str = @"未读   ";
    }else if (model.status&&[model.status isEqualToString:@"3"]) {
        str = @"已读   ";
    }else if (model.status&&[model.status isEqualToString:@"4"]) {
        str = @"已回复   ";
    }
    str = [str stringByAppendingString:model.times];
    cell.timeLab.text = str;
    cell.replyLab.text = @"回到家萨克的落地的";

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

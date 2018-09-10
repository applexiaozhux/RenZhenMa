//
//  XYNotificationViewController.m
//  RenZhenMa
//
//  Created by 李瑞星 on 2018/9/9.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYNotificationViewController.h"
#import "XYCommonHeader.h"
#import "XYNotificationModel.h"
#import "XYNotificationViewCell.h"
@interface XYNotificationViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property(nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataSource;
@end

@implementation XYNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通知详情";
    [self initSubView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSubView{
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYNotificationViewCell" bundle:nil] forCellReuseIdentifier:@"XYNotificationViewCell"];
    self.tableView.tableFooterView = [UIView new];
    self.dataSource = [NSMutableArray array];
    
}

-(void)requestData{
    if (self.model.ID == nil) {
        [XYProgressHUD showMessage:@"未获取到通知id"];
        return;
    }
    NSDictionary *params = @{@"id":self.model.ID};
    [[XYNetworkManager defaultManager] post:@"getInforminfo" params:params success:^(id response, id responseObject) {
        
        XYNotificationModel *model = [XYNotificationModel modelWithDictionary:response];
        [self.dataSource addObject:model];
        [self.tableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYNotificationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYNotificationViewCell" forIndexPath:indexPath];
    XYNotificationModel *model = self.dataSource[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.contentLabel.text = model.inform;
    cell.timeLabel.text = model.utime;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"null"];
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [[NSAttributedString alloc] initWithString:@"暂无数据" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
}


@end

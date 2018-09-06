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

@interface RXFeedRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArr;

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
    
}
//获取反馈记录调用接口（反馈记录页） code为1时，把info数据显示出来。 code不为1，根据返回结果message给出提示
-(void)loadData{
    [self.listArr removeAllObjects];

    NSDictionary *dic=@{@"wxid":@"2",@"page":@"",@"num":@"",@"token":@""};

    [RXNetWorkTool POST:BASE_URL(@"getSuggest") parameters:dic progress:nil success:^(id  _Nonnull responseObject) {
        if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]] isEqualToString:@"1"]) {

            NSArray *data = [responseObject objectForKey:@"info"];
            for (NSDictionary *list in data) {
                RXFeedRecordModel *model = [RXFeedRecordModel modelWithDictionary:list];
                [self.listArr addObject:model];
            }
            
        }else{
            NSString *messageStr = [responseObject objectForKey:@"message"];

        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.listArr.count;
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RXFeedRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RXFeedRecordCell"];
    cell.titleLab.text = @"的垃圾堆里看见的看见大家看见的好看空间打开空间的框架的空间的看到当机立断";
    cell.detailLab.text = @"回到家萨克的落地的";
    cell.timeLab.text = @"7938998793989830303";

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

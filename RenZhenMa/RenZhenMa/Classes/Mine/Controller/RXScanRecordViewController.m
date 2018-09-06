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


#pragma mark - <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.listArr.count;
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RXScanRecord *cell = [tableView dequeueReusableCellWithIdentifier:@"RXScanRecord"];
    
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

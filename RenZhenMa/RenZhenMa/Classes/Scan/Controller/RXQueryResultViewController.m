//
//  RXQueryResultViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXQueryResultViewController.h"
#import "XYCommonHeader.h"
#import "RXResultInfoCell.h"
#import "RXResultPersonCell.h"

@interface RXQueryResultViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation RXQueryResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"产品查询结果";
    
    self.view.backgroundColor = DeviceBackGroundColor;
    [self.view addSubview:self.tableView];

}
#pragma mark - <UITableViewDataSource, UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 0) {
        return 10;
    }else{
        return 10;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        RXResultInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RXResultInfoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
     
    }else if(indexPath.section==1){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = @"产品名称";
        cell.detailTextLabel.text = @"认真码";

        return cell;
    }else{
        RXResultPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RXResultPersonCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return SCALE375_WIDTH(45);
    }else{
        return self.tableView.rowHeight;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0;
    }else{
        return SCALE375_WIDTH(39);

    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];//LabelTextBlackColor
    label.font = [UIFont systemFontOfSize:SCALE375_WIDTH(15)];
    if (section==1) {
        label.text =@"产品信息";

    }else if (section==2){
        label.text =@"扫码查询信息";

    }
    [view addSubview:label];
    //label
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).mas_offset(SCALE375_WIDTH(15));
        make.right.mas_equalTo(view.mas_right).mas_offset(-SCALE375_WIDTH(60));
        make.centerY.equalTo(view.mas_centerY);
        make.height.mas_equalTo(SCALE375_WIDTH(16));
    }];
    return view;
}
#pragma mark - getter tableView
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavigationBar_Height) style:UITableViewStyleGrouped];//self.view.bounds
        _tableView.backgroundColor = DeviceBackGroundColor;
        [_tableView registerNib:[UINib nibWithNibName:@"RXResultInfoCell" bundle:nil] forCellReuseIdentifier:@"RXResultInfoCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"RXResultPersonCell" bundle:nil] forCellReuseIdentifier:@"RXResultPersonCell"];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)]];
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)]];
        _tableView.estimatedRowHeight = SCALE375_WIDTH(100);
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.separatorColor = DeviceLineViewColor;
        
    }
    return _tableView;
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

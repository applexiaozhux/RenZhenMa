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
#import "XYProductInfoModel.h"
#import "XYGooddDataModel.h"
@interface RXQueryResultViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *productArray;
@property(nonatomic,retain)NSMutableArray *scanInfoArray;
@end

@implementation RXQueryResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"产品查询结果";
    
    [self initSubViews];
    [self configureData];
    
}

-(void)initSubViews{
    
    self.view.backgroundColor = DeviceBackGroundColor;
    [self.view addSubview:self.tableView];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithString:@"#EEEFF1"];
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.font = [UIFont systemFontOfSize:14];
    NSString *tipStr = @"温馨提示：请根据查询结果判断自己购买的产品的真伪,如果您是购买后第一次查询，扫码查询信息就只会显示一条您的查询，如果还有其他的查询信息，在您确认不是您的家人或亲朋查询的情况下，此产品就是假冒伪劣。请您联系您的卖家进行维权。";
    
    footerLabel.text = tipStr;
    footerLabel.numberOfLines = 0;
    footerLabel.textColor = [UIColor colorWithString:@"#E34B56"];
    [footerView addSubview:footerLabel];
    [footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(footerView).offset(15);
        make.right.bottom.equalTo(footerView).offset(-15);
    }];
    CGFloat tipH = [tipStr boundingRectWithSize:CGSizeMake(kScreenWidth - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    footerView.frame = CGRectMake(0, 0, kScreenWidth, tipH + 30);
    self.tableView.tableFooterView = footerView;
    
    
    
}

-(void)configureData{

    if (self.infoModel == nil) {
        [XYProgressHUD showMessage:@"未获取到相关信息"];
        
        return;
    }
    
    [self.productArray addObjectsFromArray:self.infoModel.gooddata];
    [self.scanInfoArray addObjectsFromArray:self.infoModel.scaninfo];
    [self.tableView reloadData];
    
}
-(UIView *)createInfoView:(NSString *)infoStr{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];//LabelTextBlackColor
    label.font = [UIFont systemFontOfSize:SCALE375_WIDTH(15)];
    [view addSubview:label];
    label.text = infoStr;
    //label
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).mas_offset(SCALE375_WIDTH(15));
        make.right.mas_equalTo(view.mas_right).mas_offset(-SCALE375_WIDTH(60));
        make.centerY.equalTo(view.mas_centerY);
        make.height.mas_equalTo(SCALE375_WIDTH(16));
    }];
    return view;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return self.productArray.count;
    }else{
        return self.scanInfoArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        RXResultInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RXResultInfoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.infoModel.good;
        return cell;
     
    }else if(indexPath.section==1){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        XYGooddDataModel *model = self.productArray[indexPath.row];
        cell.textLabel.text = model.key;
        cell.detailTextLabel.text = model.val;

        return cell;
    }else{
        RXResultPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RXResultPersonCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.scanInfoArray[indexPath.row];
        
        return cell;
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
 
    if (section==1) {
        
        return [self createInfoView:@"产品信息"];
    }else if (section==2){
        UILabel *personLabel = [[UILabel alloc] init];
        personLabel.font = [UIFont boldSystemFontOfSize:14];
        personLabel.text = @"查码人";
        personLabel.backgroundColor = [UIColor whiteColor];
        personLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *phoneLabel = [[UILabel alloc] init];
        phoneLabel.font = [UIFont boldSystemFontOfSize:14];
        phoneLabel.text = @"手机号";
        phoneLabel.backgroundColor = [UIColor whiteColor];
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont boldSystemFontOfSize:14];
        timeLabel.text = @"时间";
        timeLabel.backgroundColor = [UIColor whiteColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[personLabel,phoneLabel,timeLabel]];
        stackView.backgroundColor = [UIColor whiteColor];
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.distribution = UIStackViewDistributionFillEqually;
        
        return stackView;
    }
  
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        
        return [self createInfoView:@"扫码查询信息"];
        
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return SCALE375_WIDTH(39);
    }
    return 0;
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

-(NSMutableArray *)productArray{
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}
-(NSMutableArray *)scanInfoArray{
    if (!_scanInfoArray) {
        _scanInfoArray = [NSMutableArray array];
    }
    return _scanInfoArray;
}

@end

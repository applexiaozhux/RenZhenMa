//
//  RXIdeaFeedbackViewController.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXIdeaFeedbackViewController.h"
#import "XYCommonHeader.h"

#define WordTextColor        [UIColor redColor]


@interface RXIdeaFeedbackViewController ()<YYTextViewDelegate>
{
    UIButton *submitBtn;
}
@property (nonatomic,strong)NSMutableAttributedString * allLengthString;
@property (nonatomic,assign) NSInteger length;
@property (nonatomic,assign) NSInteger allLength;
@property (nonatomic,strong) NSMutableParagraphStyle *style;

@property (nonatomic,strong) YYTextView *writeView;
@property (nonatomic,strong) YYLabel *writeLabel;
@property (nonatomic,strong) YYLabel *wordsLabel;

@end

@implementation RXIdeaFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"意见反馈";
    self.view.backgroundColor = DeviceBackGroundColor;

    [self initView];
}
-(void)initView{
    
    _style = [[NSMutableParagraphStyle alloc]init];
    _style.alignment = NSTextAlignmentRight;

    
    _length = 0;
    _allLength = 200;

    _allLengthString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"/%li",(long)_allLength] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SCALE375_WIDTH(13)],NSForegroundColorAttributeName:RGBCOLOR(204, 204, 204),NSParagraphStyleAttributeName:_style}];

    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(SCALE375_WIDTH(15), SCALE375_WIDTH(10), SCREEN_WIDTH-SCALE375_WIDTH(30), SCALE375_WIDTH(200))];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];

    
    _writeLabel = [[YYLabel alloc]init];
    [self.view addSubview:_writeLabel];
    _writeLabel.textColor = RGBCOLOR(204, 204, 204);
    _writeLabel.textContainerInset = UIEdgeInsetsMake(SCALE375_WIDTH(12), SCALE375_WIDTH(12), SCALE375_WIDTH(12), SCALE375_WIDTH(12));
    _writeLabel.numberOfLines = 0;
    _writeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _writeLabel.font = [UIFont systemFontOfSize:SCALE375_WIDTH(12)];
    _writeLabel.hidden = YES;
    
    _writeView = [[YYTextView alloc]initWithFrame:CGRectMake(SCALE375_WIDTH(5), SCALE375_WIDTH(5), WIDTH(whiteView)-SCALE375_WIDTH(10), HEIGHT(whiteView)-SCALE375_WIDTH(10))];
    _writeView.textColor = [UIColor colorWithHexString:@"#666666"];
    _writeView.textContainerInset = UIEdgeInsetsMake(SCALE375_WIDTH(9), SCALE375_WIDTH(9), SCALE375_WIDTH(25), SCALE375_WIDTH(9));
    _writeView.backgroundColor = [UIColor whiteColor];
    _writeView.delegate = self;
    _writeView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    _writeView.translatesAutoresizingMaskIntoConstraints = NO;
    _writeView.placeholderText = @"请输入您的意见建议";
    _writeView.font = [UIFont systemFontOfSize:SCALE375_WIDTH(14)];
    _writeView.placeholderFont = [UIFont systemFontOfSize:SCALE375_WIDTH(14)];
    _writeView.placeholderTextColor = RGBCOLOR(204, 204, 204);
    _writeView.returnKeyType = UIReturnKeyDone;
    [whiteView addSubview:_writeView];
    
    _wordsLabel = [[YYLabel alloc]initWithFrame:CGRectMake(SCALE375_WIDTH(15), MaxY(whiteView)+SCALE375_WIDTH(10), SCREEN_WIDTH-SCALE375_WIDTH(30), SCALE375_WIDTH(20))];
    _wordsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"0" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SCALE375_WIDTH(13)],NSForegroundColorAttributeName:WordTextColor}];
    [string appendAttributedString:_allLengthString];
    [string addAttribute:NSParagraphStyleAttributeName value:_style range:NSMakeRange(0, string.length)];
    _wordsLabel.attributedText = string;
    [self.view addSubview:_wordsLabel];

    submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCALE375_WIDTH(15), MaxY(whiteView)+SCALE375_WIDTH(45), SCREEN_WIDTH-SCALE375_WIDTH(30), SCALE375_WIDTH(45))];
    submitBtn.backgroundColor = [UIColor colorWithString:kThemeColorStr];
    [submitBtn setTitle:@"立即提交" forState:UIControlStateNormal];
    
    [submitBtn.titleLabel setFont:[UIFont systemFontOfSize:SCALE375_WIDTH(17)]];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = SCALE375_WIDTH(5);
    submitBtn.enabled = NO;
    [self.view addSubview:submitBtn];
}
#pragma mark - YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView{
    _length = textView.text.length;
    if (_length>_allLength) {
        textView.text = [textView.text substringToIndex:_allLength];
        
        NSMutableAttributedString *wordstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%li",(long)_allLength] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SCALE375_WIDTH(13)],NSForegroundColorAttributeName:WordTextColor,NSParagraphStyleAttributeName:_style}];
        [wordstr appendAttributedString:_allLengthString];
        [wordstr addAttribute:NSParagraphStyleAttributeName value:_style range:NSMakeRange(0, wordstr.length)];
        _wordsLabel.attributedText = wordstr;
        
    }else{
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%tu",_length] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SCALE375_WIDTH(13)],NSForegroundColorAttributeName:WordTextColor,NSParagraphStyleAttributeName:_style}];
        [string appendAttributedString:_allLengthString];
        [string addAttribute:NSParagraphStyleAttributeName value:_style range:NSMakeRange(0, string.length)];
        _wordsLabel.attributedText = string;
    }
    
}

- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSString *content = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (content.length==0) {
        submitBtn.enabled = NO;
    }else{
        submitBtn.enabled = YES;
    }
    if (!self.view.userInteractionEnabled) {
        return YES;
    }
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    NSMutableString *str = [[NSMutableString alloc] initWithString:textView.text];
    if (text.length > 0&&text.length <= _allLength){
        [str insertString:text atIndex:range.location];
    }else if (text.length > _allLength) {
        NSString *string = [text substringToIndex:_allLength];
        [str insertString:string atIndex:range.location];
    }else if (str.length != 0){
        [str deleteCharactersInRange:range];
    }
    
    return YES;
}
#pragma mark -  点击提交
//意见反馈调用接口（意见反馈页） 1、code为1时，提示成功。然后跳转到我的页 2、code不为1，根据返回结果message给出提示
-(void)submitBtnClick{
    
    if (![XYUserInfoManager isLogin]) {
        return;
    }
    NSString *str = self.writeView.text;
    if (str.length==0) {
        return;
    }
    XYUserInfoModel *userinfo = [XYUserInfoManager shareInfoManager].userInfo;
    NSDictionary *dic=@{@"wxid":userinfo.uid,@"token":userinfo.token,@"info":str};

    [[XYNetworkManager defaultManager] post:@"suggest" params:dic success:^(id response, id responseObject) {
        [XYProgressHUD showMessage:@"提交成功"];
    
        [self.navigationController popViewControllerAnimated:YES];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
    }];
   
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

//
//  MineTableViewCell.m
//  DoctorNurse
//
//  Created by 李瑞星 on 2018/1/22.
//  Copyright © 2018年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "MineTableViewCell.h"
#import "XYCommonHeader.h"

@implementation MineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(SCALE375_WIDTH(21));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(SCALE375_WIDTH(27));
            make.height.equalTo(self.imgView.mas_width);
        }];
        
        self.arrowImg = [[UIImageView alloc] init];
        [self.arrowImg setImage:[UIImage imageNamed:@"listview_arrow"]];
        [self.contentView addSubview:self.arrowImg];
        [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-22);
            make.width.mas_equalTo(15);
            make.height.equalTo(self.arrowImg.mas_width);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        self.titleL = [[UILabel alloc] init];
        self.titleL.font = [UIFont systemFontOfSize:SCALE375_WIDTH(15)];
        self.titleL.textAlignment = NSTextAlignmentLeft;
        self.titleL.textColor = [UIColor colorWithString:@"#333333"];
        [self.contentView addSubview:self.titleL];
        
        [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).with.offset(12);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView).with.offset(-49);
        }];
    }
    return self;
}

@end

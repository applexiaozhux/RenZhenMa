//
//  RXResultInfoCell.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXResultInfoCell.h"
#import "XYGoodModel.h"
#import <UIImageView+WebCache.h>
@implementation RXResultInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYGoodModel *)model{
    _model = model;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"photoPlacehold"]];
    
    self.rzmLabel.text = [NSString stringWithFormat:@"认证码：%@",model.rzm];
    self.productLabel.text = model.goodname;
}

@end

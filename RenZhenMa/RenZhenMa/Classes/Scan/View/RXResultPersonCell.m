//
//  RXResultPersonCell.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXResultPersonCell.h"
#import "XYScanInfoModel.h"
#import "XYCommonHeader.h"
@implementation RXResultPersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYScanInfoModel *)model{
    _model = model;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"avatar_man"]];
    self.nickNameLabel.text = model.nick;
    self.phoneLabel.text = model.phone;
    NSString *timeDay = [model.utime timeStampString:@"yyyy-MM-dd"];
    NSString *timeSecond = [model.utime timeStampString:@"HH:mm:ss"];
    self.timeLabel.text = [NSString stringWithFormat:@"%@\n%@",timeDay,timeSecond];
    
}


@end

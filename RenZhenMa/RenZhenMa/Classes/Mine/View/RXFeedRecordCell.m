//
//  RXFeedRecordCell.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXFeedRecordCell.h"
#import "XYCommonHeader.h"

@implementation RXFeedRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleLab.font = [UIFont systemFontOfSize:SCALE375_WIDTH(14)];
    _timeLab.font = [UIFont systemFontOfSize:SCALE375_WIDTH(12)];
    _replyLab.font = [UIFont systemFontOfSize:SCALE375_WIDTH(13)];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

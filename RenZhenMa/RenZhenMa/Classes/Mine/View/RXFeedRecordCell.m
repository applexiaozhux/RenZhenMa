//
//  RXFeedRecordCell.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXFeedRecordCell.h"
#import "XYCommonHeader.h"
#import "RXFeedRecordModel.h"
#import "XYCommonHeader.h"
@implementation RXFeedRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleLab.font = [UIFont systemFontOfSize:SCALE375_WIDTH(14)];
    _timeLab.font = [UIFont systemFontOfSize:SCALE375_WIDTH(12)];
    _replyLab.font = [UIFont systemFontOfSize:SCALE375_WIDTH(13)];

}


-(void)setModel:(RXFeedRecordModel *)model{
    _model = model;
    
    self.titleLab.text = model.sinfo;
    NSString *str = @"";
    if (model.status&&[model.status isEqualToString:@"1"]) {
        str = @"未读";
        self.replayStatusLabel.textColor = [UIColor colorWithString:@"#999999"];
    }else if (model.status&&[model.status isEqualToString:@"3"]) {
        str = @"已读";
        self.replayStatusLabel.textColor = [UIColor colorWithString:kThemeColorStr];
    }else if (model.status&&[model.status isEqualToString:@"4"]) {
        str = @"已回复";
        self.replayStatusLabel.textColor = [UIColor colorWithString:kThemeColorStr];
    }
    NSString *time = [model.times timeStampString:nil];

    self.replayStatusLabel.text = str;
    self.timeLab.text = time;
    
    if ([model.rstatus isEqualToString:@"1"]) {
        self.replyLab.text = model.rinfo;
        self.replyStatusLabel.text = @"回复：";
        self.replayConst.constant = 15;
    }else{
        self.replyLab.text = @"";
        self.replyStatusLabel.text = @"";
        self.replayConst.constant = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

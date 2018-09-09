//
//  RXFeedRecordCell.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RXFeedRecordModel;
@interface RXFeedRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *replyLab;
@property (weak, nonatomic) IBOutlet UILabel *replyStatusLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replayConst;

@property (nonatomic,retain) RXFeedRecordModel *model;

@end

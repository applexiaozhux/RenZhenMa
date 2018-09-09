//
//  XYNotificationViewCell.h
//  RenZhenMa
//
//  Created by 李瑞星 on 2018/9/9.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYNotificationViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

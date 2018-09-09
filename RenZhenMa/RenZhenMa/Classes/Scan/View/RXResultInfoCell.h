//
//  RXResultInfoCell.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/7.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYGoodModel;
@interface RXResultInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@property (weak, nonatomic) IBOutlet UILabel *rzmLabel;


@property(nonatomic,retain) XYGoodModel *model;

@end

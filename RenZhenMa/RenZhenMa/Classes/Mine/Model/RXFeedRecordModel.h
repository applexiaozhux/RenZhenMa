//
//  RXFeedRecordModel.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXFeedRecordModel : NSObject

@property (nonatomic,copy) NSString *feedRecordID;
@property (nonatomic,copy) NSString *sinfo;//反馈内容
@property (nonatomic,copy) NSString *status;// 反馈状态，1未读，3已读，4已回复
@property (nonatomic,copy) NSString *times;//  反馈时间戳精确到秒
@property (nonatomic,copy) NSString *rstatus;// 回复状态，1说明已回复，显示回复内容，其他隐藏回复显示
@property (nonatomic,copy) NSString *rinfo;//回复内容

@end

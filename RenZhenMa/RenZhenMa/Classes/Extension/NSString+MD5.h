//
//  NSString+MD5.h
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
- (NSString *)md5;
-(NSString *)timeStampString:(NSString *)formatter;

/**
 验证手机号码
 
 @return 正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isMobileNumber;

@end

//
//  NSString+MD5.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MD5)

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


-(NSString *)timeStampString:(NSString *)formatter{
    NSTimeInterval time = formatter.integerValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    if (formatter == nil) {
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
         [dateFormat setDateFormat:formatter];
    }
    NSString* string=[dateFormat stringFromDate:date];
   
    return string;
    
}


/**
 验证手机号码
 
 @return 正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isMobileNumber {// @"^(13[0-9]|14[56789]|15[0-9]|16[6]|17[0-9]|18[0-9]|19[89])\\d{8}$";
    NSString *emailRegex = @"^1(3[0-9]|4[56789]|5[0-9]|6[6]|7[0-9]|8[0-9]|9[89])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [predicate evaluateWithObject:self];
}



@end

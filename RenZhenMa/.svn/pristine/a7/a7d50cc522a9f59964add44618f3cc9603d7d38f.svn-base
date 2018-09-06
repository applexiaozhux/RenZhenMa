

//
//  UIImage+XYColorString.m
//  YiTuoCompany
//
//  Created by xiyang on 2017/3/10.
//  Copyright © 2017年 xiyang. All rights reserved.
//

#import "UIImage+XYColorString.h"
#import "ColorUtils.h"
@implementation UIImage (XYColorString)

+(UIImage *)navigationBarImageWithColorString:(NSString *)colorStr{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect rect = CGRectMake(0, 0, width, 64);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithString:colorStr].CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
    
}


//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




@end

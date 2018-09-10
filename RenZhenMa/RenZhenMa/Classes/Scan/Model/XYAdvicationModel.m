//
//  XYAdvicationModel.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/9.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYAdvicationModel.h"

NSString *const kRootClassImgsrc = @"imgsrc";
NSString *const kRootClassPalytime = @"palytime";

@implementation XYAdvicationModel


/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(self.imgsrc != nil){
        [aCoder encodeObject:self.imgsrc forKey:kRootClassImgsrc];
    }
    if(self.palytime != nil){
        [aCoder encodeObject:self.palytime forKey:kRootClassPalytime];
    }
    if(self.url != nil){
        [aCoder encodeObject:self.url forKey:@"url"];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.imgsrc = [aDecoder decodeObjectForKey:kRootClassImgsrc];
    self.palytime = [aDecoder decodeObjectForKey:kRootClassPalytime];
    self.url = [aDecoder decodeObjectForKey:@"url"];
    return self;
    
}



@end

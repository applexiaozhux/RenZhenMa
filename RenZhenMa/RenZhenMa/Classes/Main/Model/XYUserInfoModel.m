//
//  XYUserInfoModel.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/8.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "XYUserInfoModel.h"
NSString *const kRootClassAvatarUrl = @"avatarUrl";
NSString *const kRootClassGender = @"gender";
NSString *const kRootClassIswx = @"iswx";
NSString *const kRootClassNickName = @"nickName";
NSString *const kRootClassToken = @"token";
NSString *const kRootClassUid = @"uid";
@implementation XYUserInfoModel


/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(self.avatarUrl != nil){
        [aCoder encodeObject:self.avatarUrl forKey:kRootClassAvatarUrl];
    }
    if(self.gender != nil){
        [aCoder encodeObject:self.gender forKey:kRootClassGender];
    }
    if(self.iswx != nil){
        [aCoder encodeObject:self.iswx forKey:kRootClassIswx];
    }
    if(self.nickName != nil){
        [aCoder encodeObject:self.nickName forKey:kRootClassNickName];
    }
    if(self.token != nil){
        [aCoder encodeObject:self.token forKey:kRootClassToken];
    }
    if(self.uid != nil){
        [aCoder encodeObject:self.uid forKey:kRootClassUid];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.avatarUrl = [aDecoder decodeObjectForKey:kRootClassAvatarUrl];
    self.gender = [aDecoder decodeObjectForKey:kRootClassGender];
    self.iswx = [aDecoder decodeObjectForKey:kRootClassIswx];
    self.nickName = [aDecoder decodeObjectForKey:kRootClassNickName];
    self.token = [aDecoder decodeObjectForKey:kRootClassToken];
    self.uid = [aDecoder decodeObjectForKey:kRootClassUid];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    XYUserInfoModel *copy = [XYUserInfoModel new];
    
    copy.avatarUrl = [self.avatarUrl copy];
    copy.gender = [self.gender copy];
    copy.iswx = [self.iswx copy];
    copy.nickName = [self.nickName copy];
    copy.token = [self.token copy];
    copy.uid = [self.uid copy];
    
    return copy;
}

@end

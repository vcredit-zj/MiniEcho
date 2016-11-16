//
//  MESingleChannelUser.m
//
//  Created by vcredit  on 16/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MESingleChannelUser.h"


NSString *const kMESingleChannelUserId = @"id";
NSString *const kMESingleChannelUserStatus = @"status";
NSString *const kMESingleChannelUserFamousType = @"famous_type";
NSString *const kMESingleChannelUserPayStatus = @"pay_status";
NSString *const kMESingleChannelUserAvatar100 = @"avatar_100";
NSString *const kMESingleChannelUserAvatar150 = @"avatar_150";
NSString *const kMESingleChannelUserAvatar = @"avatar";
NSString *const kMESingleChannelUserFamousStatus = @"famous_status";
NSString *const kMESingleChannelUserAvatar50 = @"avatar_50";
NSString *const kMESingleChannelUserPayClass = @"pay_class";
NSString *const kMESingleChannelUserFollowedCount = @"followed_count";
NSString *const kMESingleChannelUserPhoto = @"photo";
NSString *const kMESingleChannelUserName = @"name";


@interface MESingleChannelUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MESingleChannelUser

@synthesize userIdentifier = _userIdentifier;
@synthesize status = _status;
@synthesize famousType = _famousType;
@synthesize payStatus = _payStatus;
@synthesize avatar100 = _avatar100;
@synthesize avatar150 = _avatar150;
@synthesize avatar = _avatar;
@synthesize famousStatus = _famousStatus;
@synthesize avatar50 = _avatar50;
@synthesize payClass = _payClass;
@synthesize followedCount = _followedCount;
@synthesize photo = _photo;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userIdentifier = [self objectOrNilForKey:kMESingleChannelUserId fromDictionary:dict];
            self.status = [self objectOrNilForKey:kMESingleChannelUserStatus fromDictionary:dict];
            self.famousType = [self objectOrNilForKey:kMESingleChannelUserFamousType fromDictionary:dict];
            self.payStatus = [self objectOrNilForKey:kMESingleChannelUserPayStatus fromDictionary:dict];
            self.avatar100 = [self objectOrNilForKey:kMESingleChannelUserAvatar100 fromDictionary:dict];
            self.avatar150 = [self objectOrNilForKey:kMESingleChannelUserAvatar150 fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:kMESingleChannelUserAvatar fromDictionary:dict];
            self.famousStatus = [self objectOrNilForKey:kMESingleChannelUserFamousStatus fromDictionary:dict];
            self.avatar50 = [self objectOrNilForKey:kMESingleChannelUserAvatar50 fromDictionary:dict];
            self.payClass = [self objectOrNilForKey:kMESingleChannelUserPayClass fromDictionary:dict];
            self.followedCount = [self objectOrNilForKey:kMESingleChannelUserFollowedCount fromDictionary:dict];
            self.photo = [self objectOrNilForKey:kMESingleChannelUserPhoto fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMESingleChannelUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userIdentifier forKey:kMESingleChannelUserId];
    [mutableDict setValue:self.status forKey:kMESingleChannelUserStatus];
    [mutableDict setValue:self.famousType forKey:kMESingleChannelUserFamousType];
    [mutableDict setValue:self.payStatus forKey:kMESingleChannelUserPayStatus];
    [mutableDict setValue:self.avatar100 forKey:kMESingleChannelUserAvatar100];
    [mutableDict setValue:self.avatar150 forKey:kMESingleChannelUserAvatar150];
    [mutableDict setValue:self.avatar forKey:kMESingleChannelUserAvatar];
    [mutableDict setValue:self.famousStatus forKey:kMESingleChannelUserFamousStatus];
    [mutableDict setValue:self.avatar50 forKey:kMESingleChannelUserAvatar50];
    [mutableDict setValue:self.payClass forKey:kMESingleChannelUserPayClass];
    [mutableDict setValue:self.followedCount forKey:kMESingleChannelUserFollowedCount];
    [mutableDict setValue:self.photo forKey:kMESingleChannelUserPhoto];
    [mutableDict setValue:self.name forKey:kMESingleChannelUserName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.userIdentifier = [aDecoder decodeObjectForKey:kMESingleChannelUserId];
    self.status = [aDecoder decodeObjectForKey:kMESingleChannelUserStatus];
    self.famousType = [aDecoder decodeObjectForKey:kMESingleChannelUserFamousType];
    self.payStatus = [aDecoder decodeObjectForKey:kMESingleChannelUserPayStatus];
    self.avatar100 = [aDecoder decodeObjectForKey:kMESingleChannelUserAvatar100];
    self.avatar150 = [aDecoder decodeObjectForKey:kMESingleChannelUserAvatar150];
    self.avatar = [aDecoder decodeObjectForKey:kMESingleChannelUserAvatar];
    self.famousStatus = [aDecoder decodeObjectForKey:kMESingleChannelUserFamousStatus];
    self.avatar50 = [aDecoder decodeObjectForKey:kMESingleChannelUserAvatar50];
    self.payClass = [aDecoder decodeObjectForKey:kMESingleChannelUserPayClass];
    self.followedCount = [aDecoder decodeObjectForKey:kMESingleChannelUserFollowedCount];
    self.photo = [aDecoder decodeObjectForKey:kMESingleChannelUserPhoto];
    self.name = [aDecoder decodeObjectForKey:kMESingleChannelUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userIdentifier forKey:kMESingleChannelUserId];
    [aCoder encodeObject:_status forKey:kMESingleChannelUserStatus];
    [aCoder encodeObject:_famousType forKey:kMESingleChannelUserFamousType];
    [aCoder encodeObject:_payStatus forKey:kMESingleChannelUserPayStatus];
    [aCoder encodeObject:_avatar100 forKey:kMESingleChannelUserAvatar100];
    [aCoder encodeObject:_avatar150 forKey:kMESingleChannelUserAvatar150];
    [aCoder encodeObject:_avatar forKey:kMESingleChannelUserAvatar];
    [aCoder encodeObject:_famousStatus forKey:kMESingleChannelUserFamousStatus];
    [aCoder encodeObject:_avatar50 forKey:kMESingleChannelUserAvatar50];
    [aCoder encodeObject:_payClass forKey:kMESingleChannelUserPayClass];
    [aCoder encodeObject:_followedCount forKey:kMESingleChannelUserFollowedCount];
    [aCoder encodeObject:_photo forKey:kMESingleChannelUserPhoto];
    [aCoder encodeObject:_name forKey:kMESingleChannelUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MESingleChannelUser *copy = [[MESingleChannelUser alloc] init];
    
    if (copy) {

        copy.userIdentifier = [self.userIdentifier copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
//        copy.famousType = [self.famousType copyWithZone:zone];
        copy.payStatus = [self.payStatus copyWithZone:zone];
        copy.avatar100 = [self.avatar100 copyWithZone:zone];
        copy.avatar150 = [self.avatar150 copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.famousStatus = [self.famousStatus copyWithZone:zone];
        copy.avatar50 = [self.avatar50 copyWithZone:zone];
        copy.payClass = [self.payClass copyWithZone:zone];
        copy.followedCount = [self.followedCount copyWithZone:zone];
        copy.photo = [self.photo copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end

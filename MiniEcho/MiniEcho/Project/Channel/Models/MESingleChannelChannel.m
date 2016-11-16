//
//  MESingleChannelChannel.m
//
//  Created by vcredit  on 16/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MESingleChannelChannel.h"


NSString *const kMESingleChannelChannelPic750 = @"pic_750";
NSString *const kMESingleChannelChannelStatus = @"status";
NSString *const kMESingleChannelChannelUserId = @"user_id";
NSString *const kMESingleChannelChannelCreateTime = @"create_time";
NSString *const kMESingleChannelChannelDesp = @"desp";
NSString *const kMESingleChannelChannelLikeCount = @"like_count";
NSString *const kMESingleChannelChannelListOrder = @"list_order";
NSString *const kMESingleChannelChannelFollowCount = @"follow_count";
NSString *const kMESingleChannelChannelName = @"name";
NSString *const kMESingleChannelChannelPic200 = @"pic_200";
NSString *const kMESingleChannelChannelType = @"type";
NSString *const kMESingleChannelChannelInfo = @"info";
NSString *const kMESingleChannelChannelId = @"id";
NSString *const kMESingleChannelChannelPic500 = @"pic_500";
NSString *const kMESingleChannelChannelIsAttention = @"is_attention";
NSString *const kMESingleChannelChannelTagId = @"tag_id";
NSString *const kMESingleChannelChannelShareCount = @"share_count";
NSString *const kMESingleChannelChannelPic = @"pic";
NSString *const kMESingleChannelChannelPic640 = @"pic_640";
NSString *const kMESingleChannelChannelPic100 = @"pic_100";
NSString *const kMESingleChannelChannelPic1080 = @"pic_1080";
NSString *const kMESingleChannelChannelUpdateTime = @"update_time";
NSString *const kMESingleChannelChannelSoundCount = @"sound_count";
NSString *const kMESingleChannelChannelUpdateUserId = @"update_user_id";


@interface MESingleChannelChannel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MESingleChannelChannel

@synthesize pic750 = _pic750;
@synthesize status = _status;
@synthesize userId = _userId;
@synthesize createTime = _createTime;
@synthesize desp = _desp;
@synthesize likeCount = _likeCount;
@synthesize listOrder = _listOrder;
@synthesize followCount = _followCount;
@synthesize name = _name;
@synthesize pic200 = _pic200;
@synthesize type = _type;
@synthesize info = _info;
@synthesize channelIdentifier = _channelIdentifier;
@synthesize pic500 = _pic500;
@synthesize isAttention = _isAttention;
@synthesize tagId = _tagId;
@synthesize shareCount = _shareCount;
@synthesize pic = _pic;
@synthesize pic640 = _pic640;
@synthesize pic100 = _pic100;
@synthesize pic1080 = _pic1080;
@synthesize updateTime = _updateTime;
@synthesize soundCount = _soundCount;
@synthesize updateUserId = _updateUserId;


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
            self.pic750 = [self objectOrNilForKey:kMESingleChannelChannelPic750 fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kMESingleChannelChannelStatus fromDictionary:dict] doubleValue];
            self.userId = [[self objectOrNilForKey:kMESingleChannelChannelUserId fromDictionary:dict] doubleValue];
            self.createTime = [[self objectOrNilForKey:kMESingleChannelChannelCreateTime fromDictionary:dict] doubleValue];
            self.desp = [self objectOrNilForKey:kMESingleChannelChannelDesp fromDictionary:dict];
            self.likeCount = [[self objectOrNilForKey:kMESingleChannelChannelLikeCount fromDictionary:dict] doubleValue];
            self.listOrder = [[self objectOrNilForKey:kMESingleChannelChannelListOrder fromDictionary:dict] doubleValue];
            self.followCount = [[self objectOrNilForKey:kMESingleChannelChannelFollowCount fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kMESingleChannelChannelName fromDictionary:dict];
            self.pic200 = [self objectOrNilForKey:kMESingleChannelChannelPic200 fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kMESingleChannelChannelType fromDictionary:dict] doubleValue];
            self.info = [self objectOrNilForKey:kMESingleChannelChannelInfo fromDictionary:dict];
            self.channelIdentifier = [[self objectOrNilForKey:kMESingleChannelChannelId fromDictionary:dict] doubleValue];
            self.pic500 = [self objectOrNilForKey:kMESingleChannelChannelPic500 fromDictionary:dict];
            self.isAttention = [[self objectOrNilForKey:kMESingleChannelChannelIsAttention fromDictionary:dict] doubleValue];
            self.tagId = [[self objectOrNilForKey:kMESingleChannelChannelTagId fromDictionary:dict] doubleValue];
            self.shareCount = [[self objectOrNilForKey:kMESingleChannelChannelShareCount fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kMESingleChannelChannelPic fromDictionary:dict];
            self.pic640 = [self objectOrNilForKey:kMESingleChannelChannelPic640 fromDictionary:dict];
            self.pic100 = [self objectOrNilForKey:kMESingleChannelChannelPic100 fromDictionary:dict];
            self.pic1080 = [self objectOrNilForKey:kMESingleChannelChannelPic1080 fromDictionary:dict];
            self.updateTime = [[self objectOrNilForKey:kMESingleChannelChannelUpdateTime fromDictionary:dict] doubleValue];
            self.soundCount = [[self objectOrNilForKey:kMESingleChannelChannelSoundCount fromDictionary:dict] doubleValue];
            self.updateUserId = [[self objectOrNilForKey:kMESingleChannelChannelUpdateUserId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.pic750 forKey:kMESingleChannelChannelPic750];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kMESingleChannelChannelStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kMESingleChannelChannelUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kMESingleChannelChannelCreateTime];
    [mutableDict setValue:self.desp forKey:kMESingleChannelChannelDesp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.likeCount] forKey:kMESingleChannelChannelLikeCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listOrder] forKey:kMESingleChannelChannelListOrder];
    [mutableDict setValue:[NSNumber numberWithDouble:self.followCount] forKey:kMESingleChannelChannelFollowCount];
    [mutableDict setValue:self.name forKey:kMESingleChannelChannelName];
    [mutableDict setValue:self.pic200 forKey:kMESingleChannelChannelPic200];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kMESingleChannelChannelType];
    [mutableDict setValue:self.info forKey:kMESingleChannelChannelInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.channelIdentifier] forKey:kMESingleChannelChannelId];
    [mutableDict setValue:self.pic500 forKey:kMESingleChannelChannelPic500];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAttention] forKey:kMESingleChannelChannelIsAttention];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tagId] forKey:kMESingleChannelChannelTagId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shareCount] forKey:kMESingleChannelChannelShareCount];
    [mutableDict setValue:self.pic forKey:kMESingleChannelChannelPic];
    [mutableDict setValue:self.pic640 forKey:kMESingleChannelChannelPic640];
    [mutableDict setValue:self.pic100 forKey:kMESingleChannelChannelPic100];
    [mutableDict setValue:self.pic1080 forKey:kMESingleChannelChannelPic1080];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kMESingleChannelChannelUpdateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.soundCount] forKey:kMESingleChannelChannelSoundCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateUserId] forKey:kMESingleChannelChannelUpdateUserId];

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

    self.pic750 = [aDecoder decodeObjectForKey:kMESingleChannelChannelPic750];
    self.status = [aDecoder decodeDoubleForKey:kMESingleChannelChannelStatus];
    self.userId = [aDecoder decodeDoubleForKey:kMESingleChannelChannelUserId];
    self.createTime = [aDecoder decodeDoubleForKey:kMESingleChannelChannelCreateTime];
    self.desp = [aDecoder decodeObjectForKey:kMESingleChannelChannelDesp];
    self.likeCount = [aDecoder decodeDoubleForKey:kMESingleChannelChannelLikeCount];
    self.listOrder = [aDecoder decodeDoubleForKey:kMESingleChannelChannelListOrder];
    self.followCount = [aDecoder decodeDoubleForKey:kMESingleChannelChannelFollowCount];
    self.name = [aDecoder decodeObjectForKey:kMESingleChannelChannelName];
    self.pic200 = [aDecoder decodeObjectForKey:kMESingleChannelChannelPic200];
    self.type = [aDecoder decodeDoubleForKey:kMESingleChannelChannelType];
    self.info = [aDecoder decodeObjectForKey:kMESingleChannelChannelInfo];
    self.channelIdentifier = [aDecoder decodeDoubleForKey:kMESingleChannelChannelId];
    self.pic500 = [aDecoder decodeObjectForKey:kMESingleChannelChannelPic500];
    self.isAttention = [aDecoder decodeDoubleForKey:kMESingleChannelChannelIsAttention];
    self.tagId = [aDecoder decodeDoubleForKey:kMESingleChannelChannelTagId];
    self.shareCount = [aDecoder decodeDoubleForKey:kMESingleChannelChannelShareCount];
    self.pic = [aDecoder decodeObjectForKey:kMESingleChannelChannelPic];
    self.pic640 = [aDecoder decodeObjectForKey:kMESingleChannelChannelPic640];
    self.pic100 = [aDecoder decodeObjectForKey:kMESingleChannelChannelPic100];
    self.pic1080 = [aDecoder decodeObjectForKey:kMESingleChannelChannelPic1080];
    self.updateTime = [aDecoder decodeDoubleForKey:kMESingleChannelChannelUpdateTime];
    self.soundCount = [aDecoder decodeDoubleForKey:kMESingleChannelChannelSoundCount];
    self.updateUserId = [aDecoder decodeDoubleForKey:kMESingleChannelChannelUpdateUserId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pic750 forKey:kMESingleChannelChannelPic750];
    [aCoder encodeDouble:_status forKey:kMESingleChannelChannelStatus];
    [aCoder encodeDouble:_userId forKey:kMESingleChannelChannelUserId];
    [aCoder encodeDouble:_createTime forKey:kMESingleChannelChannelCreateTime];
    [aCoder encodeObject:_desp forKey:kMESingleChannelChannelDesp];
    [aCoder encodeDouble:_likeCount forKey:kMESingleChannelChannelLikeCount];
    [aCoder encodeDouble:_listOrder forKey:kMESingleChannelChannelListOrder];
    [aCoder encodeDouble:_followCount forKey:kMESingleChannelChannelFollowCount];
    [aCoder encodeObject:_name forKey:kMESingleChannelChannelName];
    [aCoder encodeObject:_pic200 forKey:kMESingleChannelChannelPic200];
    [aCoder encodeDouble:_type forKey:kMESingleChannelChannelType];
    [aCoder encodeObject:_info forKey:kMESingleChannelChannelInfo];
    [aCoder encodeDouble:_channelIdentifier forKey:kMESingleChannelChannelId];
    [aCoder encodeObject:_pic500 forKey:kMESingleChannelChannelPic500];
    [aCoder encodeDouble:_isAttention forKey:kMESingleChannelChannelIsAttention];
    [aCoder encodeDouble:_tagId forKey:kMESingleChannelChannelTagId];
    [aCoder encodeDouble:_shareCount forKey:kMESingleChannelChannelShareCount];
    [aCoder encodeObject:_pic forKey:kMESingleChannelChannelPic];
    [aCoder encodeObject:_pic640 forKey:kMESingleChannelChannelPic640];
    [aCoder encodeObject:_pic100 forKey:kMESingleChannelChannelPic100];
    [aCoder encodeObject:_pic1080 forKey:kMESingleChannelChannelPic1080];
    [aCoder encodeDouble:_updateTime forKey:kMESingleChannelChannelUpdateTime];
    [aCoder encodeDouble:_soundCount forKey:kMESingleChannelChannelSoundCount];
    [aCoder encodeDouble:_updateUserId forKey:kMESingleChannelChannelUpdateUserId];
}

- (id)copyWithZone:(NSZone *)zone
{
    MESingleChannelChannel *copy = [[MESingleChannelChannel alloc] init];
    
    if (copy) {

        copy.pic750 = [self.pic750 copyWithZone:zone];
        copy.status = self.status;
        copy.userId = self.userId;
        copy.createTime = self.createTime;
        copy.desp = [self.desp copyWithZone:zone];
        copy.likeCount = self.likeCount;
        copy.listOrder = self.listOrder;
        copy.followCount = self.followCount;
        copy.name = [self.name copyWithZone:zone];
        copy.pic200 = [self.pic200 copyWithZone:zone];
        copy.type = self.type;
        copy.info = [self.info copyWithZone:zone];
        copy.channelIdentifier = self.channelIdentifier;
        copy.pic500 = [self.pic500 copyWithZone:zone];
        copy.isAttention = self.isAttention;
        copy.tagId = self.tagId;
        copy.shareCount = self.shareCount;
        copy.pic = [self.pic copyWithZone:zone];
        copy.pic640 = [self.pic640 copyWithZone:zone];
        copy.pic100 = [self.pic100 copyWithZone:zone];
        copy.pic1080 = [self.pic1080 copyWithZone:zone];
        copy.updateTime = self.updateTime;
        copy.soundCount = self.soundCount;
        copy.updateUserId = self.updateUserId;
    }
    
    return copy;
}


@end

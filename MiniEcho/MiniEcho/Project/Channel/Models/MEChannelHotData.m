//
//  MEChannelHotData.m
//
//  Created by vcredit  on 16/11/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MEChannelHotData.h"


NSString *const kMEChannelHotDataPic750 = @"pic_750";
NSString *const kMEChannelHotDataStatus = @"status";
NSString *const kMEChannelHotDataUserId = @"user_id";
NSString *const kMEChannelHotDataCreateTime = @"create_time";
NSString *const kMEChannelHotDataDesp = @"desp";
NSString *const kMEChannelHotDataLikeCount = @"like_count";
NSString *const kMEChannelHotDataListOrder = @"list_order";
NSString *const kMEChannelHotDataFollowCount = @"follow_count";
NSString *const kMEChannelHotDataName = @"name";
NSString *const kMEChannelHotDataPic200 = @"pic_200";
NSString *const kMEChannelHotDataType = @"type";
NSString *const kMEChannelHotDataInfo = @"info";
NSString *const kMEChannelHotDataId = @"id";
NSString *const kMEChannelHotDataPic500 = @"pic_500";
NSString *const kMEChannelHotDataTagId = @"tag_id";
NSString *const kMEChannelHotDataPic = @"pic";
NSString *const kMEChannelHotDataShareCount = @"share_count";
NSString *const kMEChannelHotDataPic1080 = @"pic_1080";
NSString *const kMEChannelHotDataPic100 = @"pic_100";
NSString *const kMEChannelHotDataPic640 = @"pic_640";
NSString *const kMEChannelHotDataUpdateTime = @"update_time";
NSString *const kMEChannelHotDataSoundCount = @"sound_count";
NSString *const kMEChannelHotDataUpdateUserId = @"update_user_id";


@interface MEChannelHotData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MEChannelHotData

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
@synthesize dataIdentifier = _dataIdentifier;
@synthesize pic500 = _pic500;
@synthesize tagId = _tagId;
@synthesize pic = _pic;
@synthesize shareCount = _shareCount;
@synthesize pic1080 = _pic1080;
@synthesize pic100 = _pic100;
@synthesize pic640 = _pic640;
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
            self.pic750 = [self objectOrNilForKey:kMEChannelHotDataPic750 fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kMEChannelHotDataStatus fromDictionary:dict] doubleValue];
            self.userId = [[self objectOrNilForKey:kMEChannelHotDataUserId fromDictionary:dict] doubleValue];
            self.createTime = [[self objectOrNilForKey:kMEChannelHotDataCreateTime fromDictionary:dict] doubleValue];
            self.desp = [self objectOrNilForKey:kMEChannelHotDataDesp fromDictionary:dict];
            self.likeCount = [[self objectOrNilForKey:kMEChannelHotDataLikeCount fromDictionary:dict] doubleValue];
            self.listOrder = [[self objectOrNilForKey:kMEChannelHotDataListOrder fromDictionary:dict] doubleValue];
            self.followCount = [[self objectOrNilForKey:kMEChannelHotDataFollowCount fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kMEChannelHotDataName fromDictionary:dict];
            self.pic200 = [self objectOrNilForKey:kMEChannelHotDataPic200 fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kMEChannelHotDataType fromDictionary:dict] doubleValue];
            self.info = [self objectOrNilForKey:kMEChannelHotDataInfo fromDictionary:dict];
            self.dataIdentifier = [[self objectOrNilForKey:kMEChannelHotDataId fromDictionary:dict] doubleValue];
            self.pic500 = [self objectOrNilForKey:kMEChannelHotDataPic500 fromDictionary:dict];
            self.tagId = [[self objectOrNilForKey:kMEChannelHotDataTagId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kMEChannelHotDataPic fromDictionary:dict];
            self.shareCount = [[self objectOrNilForKey:kMEChannelHotDataShareCount fromDictionary:dict] doubleValue];
            self.pic1080 = [self objectOrNilForKey:kMEChannelHotDataPic1080 fromDictionary:dict];
            self.pic100 = [self objectOrNilForKey:kMEChannelHotDataPic100 fromDictionary:dict];
            self.pic640 = [self objectOrNilForKey:kMEChannelHotDataPic640 fromDictionary:dict];
            self.updateTime = [[self objectOrNilForKey:kMEChannelHotDataUpdateTime fromDictionary:dict] doubleValue];
            self.soundCount = [[self objectOrNilForKey:kMEChannelHotDataSoundCount fromDictionary:dict] doubleValue];
            self.updateUserId = [[self objectOrNilForKey:kMEChannelHotDataUpdateUserId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.pic750 forKey:kMEChannelHotDataPic750];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kMEChannelHotDataStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kMEChannelHotDataUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kMEChannelHotDataCreateTime];
    [mutableDict setValue:self.desp forKey:kMEChannelHotDataDesp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.likeCount] forKey:kMEChannelHotDataLikeCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listOrder] forKey:kMEChannelHotDataListOrder];
    [mutableDict setValue:[NSNumber numberWithDouble:self.followCount] forKey:kMEChannelHotDataFollowCount];
    [mutableDict setValue:self.name forKey:kMEChannelHotDataName];
    [mutableDict setValue:self.pic200 forKey:kMEChannelHotDataPic200];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kMEChannelHotDataType];
    [mutableDict setValue:self.info forKey:kMEChannelHotDataInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kMEChannelHotDataId];
    [mutableDict setValue:self.pic500 forKey:kMEChannelHotDataPic500];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tagId] forKey:kMEChannelHotDataTagId];
    [mutableDict setValue:self.pic forKey:kMEChannelHotDataPic];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shareCount] forKey:kMEChannelHotDataShareCount];
    [mutableDict setValue:self.pic1080 forKey:kMEChannelHotDataPic1080];
    [mutableDict setValue:self.pic100 forKey:kMEChannelHotDataPic100];
    [mutableDict setValue:self.pic640 forKey:kMEChannelHotDataPic640];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateTime] forKey:kMEChannelHotDataUpdateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.soundCount] forKey:kMEChannelHotDataSoundCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateUserId] forKey:kMEChannelHotDataUpdateUserId];

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

    self.pic750 = [aDecoder decodeObjectForKey:kMEChannelHotDataPic750];
    self.status = [aDecoder decodeDoubleForKey:kMEChannelHotDataStatus];
    self.userId = [aDecoder decodeDoubleForKey:kMEChannelHotDataUserId];
    self.createTime = [aDecoder decodeDoubleForKey:kMEChannelHotDataCreateTime];
    self.desp = [aDecoder decodeObjectForKey:kMEChannelHotDataDesp];
    self.likeCount = [aDecoder decodeDoubleForKey:kMEChannelHotDataLikeCount];
    self.listOrder = [aDecoder decodeDoubleForKey:kMEChannelHotDataListOrder];
    self.followCount = [aDecoder decodeDoubleForKey:kMEChannelHotDataFollowCount];
    self.name = [aDecoder decodeObjectForKey:kMEChannelHotDataName];
    self.pic200 = [aDecoder decodeObjectForKey:kMEChannelHotDataPic200];
    self.type = [aDecoder decodeDoubleForKey:kMEChannelHotDataType];
    self.info = [aDecoder decodeObjectForKey:kMEChannelHotDataInfo];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kMEChannelHotDataId];
    self.pic500 = [aDecoder decodeObjectForKey:kMEChannelHotDataPic500];
    self.tagId = [aDecoder decodeDoubleForKey:kMEChannelHotDataTagId];
    self.pic = [aDecoder decodeObjectForKey:kMEChannelHotDataPic];
    self.shareCount = [aDecoder decodeDoubleForKey:kMEChannelHotDataShareCount];
    self.pic1080 = [aDecoder decodeObjectForKey:kMEChannelHotDataPic1080];
    self.pic100 = [aDecoder decodeObjectForKey:kMEChannelHotDataPic100];
    self.pic640 = [aDecoder decodeObjectForKey:kMEChannelHotDataPic640];
    self.updateTime = [aDecoder decodeDoubleForKey:kMEChannelHotDataUpdateTime];
    self.soundCount = [aDecoder decodeDoubleForKey:kMEChannelHotDataSoundCount];
    self.updateUserId = [aDecoder decodeDoubleForKey:kMEChannelHotDataUpdateUserId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pic750 forKey:kMEChannelHotDataPic750];
    [aCoder encodeDouble:_status forKey:kMEChannelHotDataStatus];
    [aCoder encodeDouble:_userId forKey:kMEChannelHotDataUserId];
    [aCoder encodeDouble:_createTime forKey:kMEChannelHotDataCreateTime];
    [aCoder encodeObject:_desp forKey:kMEChannelHotDataDesp];
    [aCoder encodeDouble:_likeCount forKey:kMEChannelHotDataLikeCount];
    [aCoder encodeDouble:_listOrder forKey:kMEChannelHotDataListOrder];
    [aCoder encodeDouble:_followCount forKey:kMEChannelHotDataFollowCount];
    [aCoder encodeObject:_name forKey:kMEChannelHotDataName];
    [aCoder encodeObject:_pic200 forKey:kMEChannelHotDataPic200];
    [aCoder encodeDouble:_type forKey:kMEChannelHotDataType];
    [aCoder encodeObject:_info forKey:kMEChannelHotDataInfo];
    [aCoder encodeDouble:_dataIdentifier forKey:kMEChannelHotDataId];
    [aCoder encodeObject:_pic500 forKey:kMEChannelHotDataPic500];
    [aCoder encodeDouble:_tagId forKey:kMEChannelHotDataTagId];
    [aCoder encodeObject:_pic forKey:kMEChannelHotDataPic];
    [aCoder encodeDouble:_shareCount forKey:kMEChannelHotDataShareCount];
    [aCoder encodeObject:_pic1080 forKey:kMEChannelHotDataPic1080];
    [aCoder encodeObject:_pic100 forKey:kMEChannelHotDataPic100];
    [aCoder encodeObject:_pic640 forKey:kMEChannelHotDataPic640];
    [aCoder encodeDouble:_updateTime forKey:kMEChannelHotDataUpdateTime];
    [aCoder encodeDouble:_soundCount forKey:kMEChannelHotDataSoundCount];
    [aCoder encodeDouble:_updateUserId forKey:kMEChannelHotDataUpdateUserId];
}

- (id)copyWithZone:(NSZone *)zone
{
    MEChannelHotData *copy = [[MEChannelHotData alloc] init];
    
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
        copy.dataIdentifier = self.dataIdentifier;
        copy.pic500 = [self.pic500 copyWithZone:zone];
        copy.tagId = self.tagId;
        copy.pic = [self.pic copyWithZone:zone];
        copy.shareCount = self.shareCount;
        copy.pic1080 = [self.pic1080 copyWithZone:zone];
        copy.pic100 = [self.pic100 copyWithZone:zone];
        copy.pic640 = [self.pic640 copyWithZone:zone];
        copy.updateTime = self.updateTime;
        copy.soundCount = self.soundCount;
        copy.updateUserId = self.updateUserId;
    }
    
    return copy;
}


@end

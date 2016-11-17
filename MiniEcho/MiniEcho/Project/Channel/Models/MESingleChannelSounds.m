//
//  MESingleChannelSounds.m
//
//  Created by vcredit  on 16/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MESingleChannelSounds.h"
#import "MESingleChannelUser.h"


NSString *const kMESingleChannelSoundsComposer = @"composer";
NSString *const kMESingleChannelSoundsPic750 = @"pic_750";
NSString *const kMESingleChannelSoundsSource = @"source";
NSString *const kMESingleChannelSoundsStatus = @"status";
NSString *const kMESingleChannelSoundsTranslateMask = @"translate_mask";
NSString *const kMESingleChannelSoundsUserId = @"user_id";
NSString *const kMESingleChannelSoundsLikeCount = @"like_count";
NSString *const kMESingleChannelSoundsIsPay = @"is_pay";
NSString *const kMESingleChannelSoundsCheckVisition = @"check_visition";
NSString *const kMESingleChannelSoundsPic200 = @"pic_200";
NSString *const kMESingleChannelSoundsIsEdit = @"is_edit";
NSString *const kMESingleChannelSoundsStatusMask = @"status_mask";
NSString *const kMESingleChannelSoundsName = @"name";
NSString *const kMESingleChannelSoundsId = @"id";
NSString *const kMESingleChannelSoundsPic500 = @"pic_500";
NSString *const kMESingleChannelSoundsCommendTime = @"commend_time";
NSString *const kMESingleChannelSoundsUser = @"user";
NSString *const kMESingleChannelSoundsLength = @"length";
NSString *const kMESingleChannelSoundsPic = @"pic";
NSString *const kMESingleChannelSoundsPic640 = @"pic_640";
NSString *const kMESingleChannelSoundsViewCount = @"view_count";
NSString *const kMESingleChannelSoundsPic100 = @"pic_100";
NSString *const kMESingleChannelSoundsPic1080 = @"pic_1080";
NSString *const kMESingleChannelSoundsLyrics = @"lyrics";
NSString *const kMESingleChannelSoundsOriSinger = @"ori_singer";
NSString *const kMESingleChannelSoundsChannelId = @"channel_id";
NSString *const kMESingleChannelSoundsExchangeCount = @"exchange_count";
NSString *const kMESingleChannelSoundsIsBought = @"is_bought";
NSString *const kMESingleChannelSoundsCommentCount = @"comment_count";


@interface MESingleChannelSounds ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MESingleChannelSounds

@synthesize composer = _composer;
@synthesize pic750 = _pic750;
@synthesize source = _source;
@synthesize status = _status;
@synthesize translateMask = _translateMask;
@synthesize userId = _userId;
@synthesize likeCount = _likeCount;
@synthesize isPay = _isPay;
@synthesize checkVisition = _checkVisition;
@synthesize pic200 = _pic200;
@synthesize isEdit = _isEdit;
@synthesize statusMask = _statusMask;
@synthesize name = _name;
@synthesize soundsIdentifier = _soundsIdentifier;
@synthesize pic500 = _pic500;
@synthesize commendTime = _commendTime;
@synthesize user = _user;
@synthesize length = _length;
@synthesize pic = _pic;
@synthesize pic640 = _pic640;
@synthesize viewCount = _viewCount;
@synthesize pic100 = _pic100;
@synthesize pic1080 = _pic1080;
@synthesize lyrics = _lyrics;
@synthesize oriSinger = _oriSinger;
@synthesize channelId = _channelId;
@synthesize exchangeCount = _exchangeCount;
@synthesize isBought = _isBought;
@synthesize commentCount = _commentCount;


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
            self.composer = [self objectOrNilForKey:kMESingleChannelSoundsComposer fromDictionary:dict];
            self.pic750 = [self objectOrNilForKey:kMESingleChannelSoundsPic750 fromDictionary:dict];
            self.source = [self objectOrNilForKey:kMESingleChannelSoundsSource fromDictionary:dict];
            self.status = [self objectOrNilForKey:kMESingleChannelSoundsStatus fromDictionary:dict];
            self.translateMask = [[self objectOrNilForKey:kMESingleChannelSoundsTranslateMask fromDictionary:dict] doubleValue];
            self.userId = [self objectOrNilForKey:kMESingleChannelSoundsUserId fromDictionary:dict];
            self.likeCount = [[self objectOrNilForKey:kMESingleChannelSoundsLikeCount fromDictionary:dict] doubleValue];
            self.isPay = [[self objectOrNilForKey:kMESingleChannelSoundsIsPay fromDictionary:dict] doubleValue];
            self.checkVisition = [[self objectOrNilForKey:kMESingleChannelSoundsCheckVisition fromDictionary:dict] doubleValue];
            self.pic200 = [self objectOrNilForKey:kMESingleChannelSoundsPic200 fromDictionary:dict];
            self.isEdit = [self objectOrNilForKey:kMESingleChannelSoundsIsEdit fromDictionary:dict];
            self.statusMask = [self objectOrNilForKey:kMESingleChannelSoundsStatusMask fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMESingleChannelSoundsName fromDictionary:dict];
            self.soundsIdentifier = [self objectOrNilForKey:kMESingleChannelSoundsId fromDictionary:dict];
            self.pic500 = [self objectOrNilForKey:kMESingleChannelSoundsPic500 fromDictionary:dict];
            self.commendTime = [self objectOrNilForKey:kMESingleChannelSoundsCommendTime fromDictionary:dict];
            self.user = [MESingleChannelUser modelObjectWithDictionary:[dict objectForKey:kMESingleChannelSoundsUser]];
            self.length = [self objectOrNilForKey:kMESingleChannelSoundsLength fromDictionary:dict];
            self.pic = [self objectOrNilForKey:kMESingleChannelSoundsPic fromDictionary:dict];
            self.pic640 = [self objectOrNilForKey:kMESingleChannelSoundsPic640 fromDictionary:dict];
            self.viewCount = [[self objectOrNilForKey:kMESingleChannelSoundsViewCount fromDictionary:dict] doubleValue];
            self.pic100 = [self objectOrNilForKey:kMESingleChannelSoundsPic100 fromDictionary:dict];
            self.pic1080 = [self objectOrNilForKey:kMESingleChannelSoundsPic1080 fromDictionary:dict];
            self.lyrics = [self objectOrNilForKey:kMESingleChannelSoundsLyrics fromDictionary:dict];
            self.oriSinger = [self objectOrNilForKey:kMESingleChannelSoundsOriSinger fromDictionary:dict];
            self.channelId = [self objectOrNilForKey:kMESingleChannelSoundsChannelId fromDictionary:dict];
            self.exchangeCount = [self objectOrNilForKey:kMESingleChannelSoundsExchangeCount fromDictionary:dict];
            self.isBought = [[self objectOrNilForKey:kMESingleChannelSoundsIsBought fromDictionary:dict] doubleValue];
            self.commentCount = [self objectOrNilForKey:kMESingleChannelSoundsCommentCount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.composer forKey:kMESingleChannelSoundsComposer];
    [mutableDict setValue:self.pic750 forKey:kMESingleChannelSoundsPic750];
    [mutableDict setValue:self.source forKey:kMESingleChannelSoundsSource];
    [mutableDict setValue:self.status forKey:kMESingleChannelSoundsStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.translateMask] forKey:kMESingleChannelSoundsTranslateMask];
    [mutableDict setValue:self.userId forKey:kMESingleChannelSoundsUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.likeCount] forKey:kMESingleChannelSoundsLikeCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isPay] forKey:kMESingleChannelSoundsIsPay];
    [mutableDict setValue:[NSNumber numberWithDouble:self.checkVisition] forKey:kMESingleChannelSoundsCheckVisition];
    [mutableDict setValue:self.pic200 forKey:kMESingleChannelSoundsPic200];
    [mutableDict setValue:self.isEdit forKey:kMESingleChannelSoundsIsEdit];
    [mutableDict setValue:self.statusMask forKey:kMESingleChannelSoundsStatusMask];
    [mutableDict setValue:self.name forKey:kMESingleChannelSoundsName];
    [mutableDict setValue:self.soundsIdentifier forKey:kMESingleChannelSoundsId];
    [mutableDict setValue:self.pic500 forKey:kMESingleChannelSoundsPic500];
    [mutableDict setValue:self.commendTime forKey:kMESingleChannelSoundsCommendTime];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kMESingleChannelSoundsUser];
    [mutableDict setValue:self.length forKey:kMESingleChannelSoundsLength];
    [mutableDict setValue:self.pic forKey:kMESingleChannelSoundsPic];
    [mutableDict setValue:self.pic640 forKey:kMESingleChannelSoundsPic640];
    [mutableDict setValue:[NSNumber numberWithDouble:self.viewCount] forKey:kMESingleChannelSoundsViewCount];
    [mutableDict setValue:self.pic100 forKey:kMESingleChannelSoundsPic100];
    [mutableDict setValue:self.pic1080 forKey:kMESingleChannelSoundsPic1080];
    [mutableDict setValue:self.lyrics forKey:kMESingleChannelSoundsLyrics];
    [mutableDict setValue:self.oriSinger forKey:kMESingleChannelSoundsOriSinger];
    [mutableDict setValue:self.channelId forKey:kMESingleChannelSoundsChannelId];
    [mutableDict setValue:self.exchangeCount forKey:kMESingleChannelSoundsExchangeCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isBought] forKey:kMESingleChannelSoundsIsBought];
    [mutableDict setValue:self.commentCount forKey:kMESingleChannelSoundsCommentCount];

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

    self.composer = [aDecoder decodeObjectForKey:kMESingleChannelSoundsComposer];
    self.pic750 = [aDecoder decodeObjectForKey:kMESingleChannelSoundsPic750];
    self.source = [aDecoder decodeObjectForKey:kMESingleChannelSoundsSource];
    self.status = [aDecoder decodeObjectForKey:kMESingleChannelSoundsStatus];
    self.translateMask = [aDecoder decodeDoubleForKey:kMESingleChannelSoundsTranslateMask];
    self.userId = [aDecoder decodeObjectForKey:kMESingleChannelSoundsUserId];
    self.likeCount = [aDecoder decodeDoubleForKey:kMESingleChannelSoundsLikeCount];
    self.isPay = [aDecoder decodeDoubleForKey:kMESingleChannelSoundsIsPay];
    self.checkVisition = [aDecoder decodeDoubleForKey:kMESingleChannelSoundsCheckVisition];
    self.pic200 = [aDecoder decodeObjectForKey:kMESingleChannelSoundsPic200];
    self.isEdit = [aDecoder decodeObjectForKey:kMESingleChannelSoundsIsEdit];
    self.statusMask = [aDecoder decodeObjectForKey:kMESingleChannelSoundsStatusMask];
    self.name = [aDecoder decodeObjectForKey:kMESingleChannelSoundsName];
    self.soundsIdentifier = [aDecoder decodeObjectForKey:kMESingleChannelSoundsId];
    self.pic500 = [aDecoder decodeObjectForKey:kMESingleChannelSoundsPic500];
    self.commendTime = [aDecoder decodeObjectForKey:kMESingleChannelSoundsCommendTime];
    self.user = [aDecoder decodeObjectForKey:kMESingleChannelSoundsUser];
    self.length = [aDecoder decodeObjectForKey:kMESingleChannelSoundsLength];
    self.pic = [aDecoder decodeObjectForKey:kMESingleChannelSoundsPic];
    self.pic640 = [aDecoder decodeObjectForKey:kMESingleChannelSoundsPic640];
    self.viewCount = [aDecoder decodeDoubleForKey:kMESingleChannelSoundsViewCount];
    self.pic100 = [aDecoder decodeObjectForKey:kMESingleChannelSoundsPic100];
    self.pic1080 = [aDecoder decodeObjectForKey:kMESingleChannelSoundsPic1080];
    self.lyrics = [aDecoder decodeObjectForKey:kMESingleChannelSoundsLyrics];
    self.oriSinger = [aDecoder decodeObjectForKey:kMESingleChannelSoundsOriSinger];
    self.channelId = [aDecoder decodeObjectForKey:kMESingleChannelSoundsChannelId];
    self.exchangeCount = [aDecoder decodeObjectForKey:kMESingleChannelSoundsExchangeCount];
    self.isBought = [aDecoder decodeDoubleForKey:kMESingleChannelSoundsIsBought];
    self.commentCount = [aDecoder decodeObjectForKey:kMESingleChannelSoundsCommentCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_composer forKey:kMESingleChannelSoundsComposer];
    [aCoder encodeObject:_pic750 forKey:kMESingleChannelSoundsPic750];
    [aCoder encodeObject:_source forKey:kMESingleChannelSoundsSource];
    [aCoder encodeObject:_status forKey:kMESingleChannelSoundsStatus];
    [aCoder encodeDouble:_translateMask forKey:kMESingleChannelSoundsTranslateMask];
    [aCoder encodeObject:_userId forKey:kMESingleChannelSoundsUserId];
//    [aCoder encodeObject:_likeCount forKey:kMESingleChannelSoundsLikeCount];
    [aCoder encodeDouble:_isPay forKey:kMESingleChannelSoundsIsPay];
    [aCoder encodeDouble:_checkVisition forKey:kMESingleChannelSoundsCheckVisition];
    [aCoder encodeObject:_pic200 forKey:kMESingleChannelSoundsPic200];
    [aCoder encodeObject:_isEdit forKey:kMESingleChannelSoundsIsEdit];
    [aCoder encodeObject:_statusMask forKey:kMESingleChannelSoundsStatusMask];
    [aCoder encodeObject:_name forKey:kMESingleChannelSoundsName];
    [aCoder encodeObject:_soundsIdentifier forKey:kMESingleChannelSoundsId];
    [aCoder encodeObject:_pic500 forKey:kMESingleChannelSoundsPic500];
    [aCoder encodeObject:_commendTime forKey:kMESingleChannelSoundsCommendTime];
    [aCoder encodeObject:_user forKey:kMESingleChannelSoundsUser];
    [aCoder encodeObject:_length forKey:kMESingleChannelSoundsLength];
    [aCoder encodeObject:_pic forKey:kMESingleChannelSoundsPic];
    [aCoder encodeObject:_pic640 forKey:kMESingleChannelSoundsPic640];
    [aCoder encodeDouble:_viewCount forKey:kMESingleChannelSoundsViewCount];
    [aCoder encodeObject:_pic100 forKey:kMESingleChannelSoundsPic100];
    [aCoder encodeObject:_pic1080 forKey:kMESingleChannelSoundsPic1080];
    [aCoder encodeObject:_lyrics forKey:kMESingleChannelSoundsLyrics];
    [aCoder encodeObject:_oriSinger forKey:kMESingleChannelSoundsOriSinger];
    [aCoder encodeObject:_channelId forKey:kMESingleChannelSoundsChannelId];
    [aCoder encodeObject:_exchangeCount forKey:kMESingleChannelSoundsExchangeCount];
    [aCoder encodeDouble:_isBought forKey:kMESingleChannelSoundsIsBought];
    [aCoder encodeObject:_commentCount forKey:kMESingleChannelSoundsCommentCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    MESingleChannelSounds *copy = [[MESingleChannelSounds alloc] init];
    
    if (copy) {

//        copy.composer = [self.composer copyWithZone:zone];
        copy.pic750 = [self.pic750 copyWithZone:zone];
        copy.source = [self.source copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.translateMask = self.translateMask;
        copy.userId = [self.userId copyWithZone:zone];
//        copy.likeCount = [self.likeCount copyWithZone:zone];
        copy.isPay = self.isPay;
        copy.checkVisition = self.checkVisition;
        copy.pic200 = [self.pic200 copyWithZone:zone];
        copy.isEdit = [self.isEdit copyWithZone:zone];
        copy.statusMask = [self.statusMask copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.soundsIdentifier = [self.soundsIdentifier copyWithZone:zone];
        copy.pic500 = [self.pic500 copyWithZone:zone];
        copy.commendTime = [self.commendTime copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
        copy.length = [self.length copyWithZone:zone];
        copy.pic = [self.pic copyWithZone:zone];
        copy.pic640 = [self.pic640 copyWithZone:zone];
        copy.viewCount = self.viewCount;
        copy.pic100 = [self.pic100 copyWithZone:zone];
        copy.pic1080 = [self.pic1080 copyWithZone:zone];
//        copy.lyrics = [self.lyrics copyWithZone:zone];
//        copy.oriSinger = [self.oriSinger copyWithZone:zone];
        copy.channelId = [self.channelId copyWithZone:zone];
        copy.exchangeCount = [self.exchangeCount copyWithZone:zone];
        copy.isBought = self.isBought;
        copy.commentCount = [self.commentCount copyWithZone:zone];
    }
    
    return copy;
}


@end

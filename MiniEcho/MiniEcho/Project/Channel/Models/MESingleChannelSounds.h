//
//  MESingleChannelSounds.h
//
//  Created by vcredit  on 16/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MESingleChannelUser;

@interface MESingleChannelSounds : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) id composer;
@property (nonatomic, strong) NSString *pic750;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign) double translateMask;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *likeCount;
@property (nonatomic, assign) double isPay;
@property (nonatomic, assign) double checkVisition;
@property (nonatomic, strong) NSString *pic200;
@property (nonatomic, strong) NSString *isEdit;
@property (nonatomic, strong) NSString *statusMask;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *soundsIdentifier;
@property (nonatomic, strong) NSString *pic500;
@property (nonatomic, strong) NSString *commendTime;
@property (nonatomic, strong) MESingleChannelUser *user;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *pic640;
@property (nonatomic, assign) double viewCount;
@property (nonatomic, strong) NSString *pic100;
@property (nonatomic, strong) NSString *pic1080;
@property (nonatomic, assign) id lyrics;
@property (nonatomic, assign) id oriSinger;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *exchangeCount;
@property (nonatomic, assign) double isBought;
@property (nonatomic, strong) NSString *commentCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

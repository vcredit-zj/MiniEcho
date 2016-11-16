//
//  MESingleChannelData.m
//
//  Created by vcredit  on 16/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MESingleChannelData.h"
#import "MESingleChannelChannel.h"
#import "MESingleChannelSounds.h"


NSString *const kMESingleChannelDataChannel = @"channel";
NSString *const kMESingleChannelDataNews = @"news";
NSString *const kMESingleChannelDataSounds = @"sounds";


@interface MESingleChannelData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MESingleChannelData

@synthesize channel = _channel;
@synthesize news = _news;
@synthesize sounds = _sounds;


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
            self.channel = [MESingleChannelChannel modelObjectWithDictionary:[dict objectForKey:kMESingleChannelDataChannel]];
            self.news = [[self objectOrNilForKey:kMESingleChannelDataNews fromDictionary:dict] doubleValue];
    NSObject *receivedMESingleChannelSounds = [dict objectForKey:kMESingleChannelDataSounds];
    NSMutableArray *parsedMESingleChannelSounds = [NSMutableArray array];
    if ([receivedMESingleChannelSounds isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMESingleChannelSounds) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMESingleChannelSounds addObject:[MESingleChannelSounds modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMESingleChannelSounds isKindOfClass:[NSDictionary class]]) {
       [parsedMESingleChannelSounds addObject:[MESingleChannelSounds modelObjectWithDictionary:(NSDictionary *)receivedMESingleChannelSounds]];
    }

    self.sounds = [NSArray arrayWithArray:parsedMESingleChannelSounds];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.channel dictionaryRepresentation] forKey:kMESingleChannelDataChannel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.news] forKey:kMESingleChannelDataNews];
    NSMutableArray *tempArrayForSounds = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sounds) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSounds addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSounds addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSounds] forKey:kMESingleChannelDataSounds];

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

    self.channel = [aDecoder decodeObjectForKey:kMESingleChannelDataChannel];
    self.news = [aDecoder decodeDoubleForKey:kMESingleChannelDataNews];
    self.sounds = [aDecoder decodeObjectForKey:kMESingleChannelDataSounds];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_channel forKey:kMESingleChannelDataChannel];
    [aCoder encodeDouble:_news forKey:kMESingleChannelDataNews];
    [aCoder encodeObject:_sounds forKey:kMESingleChannelDataSounds];
}

- (id)copyWithZone:(NSZone *)zone
{
    MESingleChannelData *copy = [[MESingleChannelData alloc] init];
    
    if (copy) {

        copy.channel = [self.channel copyWithZone:zone];
        copy.news = self.news;
        copy.sounds = [self.sounds copyWithZone:zone];
    }
    
    return copy;
}


@end

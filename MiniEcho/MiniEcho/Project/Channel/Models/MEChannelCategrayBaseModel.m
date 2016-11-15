//
//  MEChannelCategrayBaseModel.m
//
//  Created by vcredit  on 16/11/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MEChannelCategrayBaseModel.h"
#import "MEChannelCategrayData.h"


NSString *const kMEChannelCategrayBaseModelVersion = @"version";
NSString *const kMEChannelCategrayBaseModelData = @"data";


@interface MEChannelCategrayBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MEChannelCategrayBaseModel

@synthesize version = _version;
@synthesize data = _data;


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
            self.version = [self objectOrNilForKey:kMEChannelCategrayBaseModelVersion fromDictionary:dict];
    NSObject *receivedMEChannelCategrayData = [dict objectForKey:kMEChannelCategrayBaseModelData];
    NSMutableArray *parsedMEChannelCategrayData = [NSMutableArray array];
    if ([receivedMEChannelCategrayData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMEChannelCategrayData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMEChannelCategrayData addObject:[MEChannelCategrayData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMEChannelCategrayData isKindOfClass:[NSDictionary class]]) {
       [parsedMEChannelCategrayData addObject:[MEChannelCategrayData modelObjectWithDictionary:(NSDictionary *)receivedMEChannelCategrayData]];
    }

    self.data = [NSArray arrayWithArray:parsedMEChannelCategrayData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.version forKey:kMEChannelCategrayBaseModelVersion];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kMEChannelCategrayBaseModelData];

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

    self.version = [aDecoder decodeObjectForKey:kMEChannelCategrayBaseModelVersion];
    self.data = [aDecoder decodeObjectForKey:kMEChannelCategrayBaseModelData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_version forKey:kMEChannelCategrayBaseModelVersion];
    [aCoder encodeObject:_data forKey:kMEChannelCategrayBaseModelData];
}

- (id)copyWithZone:(NSZone *)zone
{
    MEChannelCategrayBaseModel *copy = [[MEChannelCategrayBaseModel alloc] init];
    
    if (copy) {

        copy.version = [self.version copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end

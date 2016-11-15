//
//  MEChannelHotBaseModel.m
//
//  Created by vcredit  on 16/11/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MEChannelHotBaseModel.h"
#import "MEChannelHotData.h"


NSString *const kMEChannelHotBaseModelTotalCount = @"total_count";
NSString *const kMEChannelHotBaseModelData = @"data";


@interface MEChannelHotBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MEChannelHotBaseModel

@synthesize totalCount = _totalCount;
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
            self.totalCount = [[self objectOrNilForKey:kMEChannelHotBaseModelTotalCount fromDictionary:dict] doubleValue];
    NSObject *receivedMEChannelHotData = [dict objectForKey:kMEChannelHotBaseModelData];
    NSMutableArray *parsedMEChannelHotData = [NSMutableArray array];
    if ([receivedMEChannelHotData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMEChannelHotData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMEChannelHotData addObject:[MEChannelHotData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMEChannelHotData isKindOfClass:[NSDictionary class]]) {
       [parsedMEChannelHotData addObject:[MEChannelHotData modelObjectWithDictionary:(NSDictionary *)receivedMEChannelHotData]];
    }

    self.data = [NSArray arrayWithArray:parsedMEChannelHotData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalCount] forKey:kMEChannelHotBaseModelTotalCount];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kMEChannelHotBaseModelData];

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

    self.totalCount = [aDecoder decodeDoubleForKey:kMEChannelHotBaseModelTotalCount];
    self.data = [aDecoder decodeObjectForKey:kMEChannelHotBaseModelData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_totalCount forKey:kMEChannelHotBaseModelTotalCount];
    [aCoder encodeObject:_data forKey:kMEChannelHotBaseModelData];
}

- (id)copyWithZone:(NSZone *)zone
{
    MEChannelHotBaseModel *copy = [[MEChannelHotBaseModel alloc] init];
    
    if (copy) {

        copy.totalCount = self.totalCount;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end

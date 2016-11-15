//
//  MEChannelCategrayData.m
//
//  Created by vcredit  on 16/11/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MEChannelCategrayData.h"
#import "MEChannelCategrayChildren.h"


NSString *const kMEChannelCategrayDataIcoUrl = @"ico_url";
NSString *const kMEChannelCategrayDataEnName = @"en_name";
NSString *const kMEChannelCategrayDataId = @"id";
NSString *const kMEChannelCategrayDataCreatedAt = @"created_at";
NSString *const kMEChannelCategrayDataKrName = @"kr_name";
NSString *const kMEChannelCategrayDataChildren = @"children";
NSString *const kMEChannelCategrayDataFid = @"fid";
NSString *const kMEChannelCategrayDataUpdatedAt = @"updated_at";
NSString *const kMEChannelCategrayDataName = @"name";
NSString *const kMEChannelCategrayDataJpName = @"jp_name";


@interface MEChannelCategrayData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MEChannelCategrayData

@synthesize icoUrl = _icoUrl;
@synthesize enName = _enName;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize createdAt = _createdAt;
@synthesize krName = _krName;
@synthesize children = _children;
@synthesize fid = _fid;
@synthesize updatedAt = _updatedAt;
@synthesize name = _name;
@synthesize jpName = _jpName;


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
            self.icoUrl = [self objectOrNilForKey:kMEChannelCategrayDataIcoUrl fromDictionary:dict];
            self.enName = [self objectOrNilForKey:kMEChannelCategrayDataEnName fromDictionary:dict];
            self.dataIdentifier = [[self objectOrNilForKey:kMEChannelCategrayDataId fromDictionary:dict] doubleValue];
            self.createdAt = [self objectOrNilForKey:kMEChannelCategrayDataCreatedAt fromDictionary:dict];
            self.krName = [self objectOrNilForKey:kMEChannelCategrayDataKrName fromDictionary:dict];
    NSObject *receivedMEChannelCategrayChildren = [dict objectForKey:kMEChannelCategrayDataChildren];
    NSMutableArray *parsedMEChannelCategrayChildren = [NSMutableArray array];
    if ([receivedMEChannelCategrayChildren isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMEChannelCategrayChildren) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMEChannelCategrayChildren addObject:[MEChannelCategrayChildren modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMEChannelCategrayChildren isKindOfClass:[NSDictionary class]]) {
       [parsedMEChannelCategrayChildren addObject:[MEChannelCategrayChildren modelObjectWithDictionary:(NSDictionary *)receivedMEChannelCategrayChildren]];
    }

    self.children = [NSArray arrayWithArray:parsedMEChannelCategrayChildren];
            self.fid = [[self objectOrNilForKey:kMEChannelCategrayDataFid fromDictionary:dict] doubleValue];
            self.updatedAt = [self objectOrNilForKey:kMEChannelCategrayDataUpdatedAt fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMEChannelCategrayDataName fromDictionary:dict];
            self.jpName = [self objectOrNilForKey:kMEChannelCategrayDataJpName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.icoUrl forKey:kMEChannelCategrayDataIcoUrl];
    [mutableDict setValue:self.enName forKey:kMEChannelCategrayDataEnName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kMEChannelCategrayDataId];
    [mutableDict setValue:self.createdAt forKey:kMEChannelCategrayDataCreatedAt];
    [mutableDict setValue:self.krName forKey:kMEChannelCategrayDataKrName];
    NSMutableArray *tempArrayForChildren = [NSMutableArray array];
    for (NSObject *subArrayObject in self.children) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForChildren addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForChildren addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForChildren] forKey:kMEChannelCategrayDataChildren];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fid] forKey:kMEChannelCategrayDataFid];
    [mutableDict setValue:self.updatedAt forKey:kMEChannelCategrayDataUpdatedAt];
    [mutableDict setValue:self.name forKey:kMEChannelCategrayDataName];
    [mutableDict setValue:self.jpName forKey:kMEChannelCategrayDataJpName];

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

    self.icoUrl = [aDecoder decodeObjectForKey:kMEChannelCategrayDataIcoUrl];
    self.enName = [aDecoder decodeObjectForKey:kMEChannelCategrayDataEnName];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kMEChannelCategrayDataId];
    self.createdAt = [aDecoder decodeObjectForKey:kMEChannelCategrayDataCreatedAt];
    self.krName = [aDecoder decodeObjectForKey:kMEChannelCategrayDataKrName];
    self.children = [aDecoder decodeObjectForKey:kMEChannelCategrayDataChildren];
    self.fid = [aDecoder decodeDoubleForKey:kMEChannelCategrayDataFid];
    self.updatedAt = [aDecoder decodeObjectForKey:kMEChannelCategrayDataUpdatedAt];
    self.name = [aDecoder decodeObjectForKey:kMEChannelCategrayDataName];
    self.jpName = [aDecoder decodeObjectForKey:kMEChannelCategrayDataJpName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_icoUrl forKey:kMEChannelCategrayDataIcoUrl];
    [aCoder encodeObject:_enName forKey:kMEChannelCategrayDataEnName];
    [aCoder encodeDouble:_dataIdentifier forKey:kMEChannelCategrayDataId];
    [aCoder encodeObject:_createdAt forKey:kMEChannelCategrayDataCreatedAt];
    [aCoder encodeObject:_krName forKey:kMEChannelCategrayDataKrName];
    [aCoder encodeObject:_children forKey:kMEChannelCategrayDataChildren];
    [aCoder encodeDouble:_fid forKey:kMEChannelCategrayDataFid];
    [aCoder encodeObject:_updatedAt forKey:kMEChannelCategrayDataUpdatedAt];
    [aCoder encodeObject:_name forKey:kMEChannelCategrayDataName];
    [aCoder encodeObject:_jpName forKey:kMEChannelCategrayDataJpName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MEChannelCategrayData *copy = [[MEChannelCategrayData alloc] init];
    
    if (copy) {

        copy.icoUrl = [self.icoUrl copyWithZone:zone];
        copy.enName = [self.enName copyWithZone:zone];
        copy.dataIdentifier = self.dataIdentifier;
        copy.createdAt = [self.createdAt copyWithZone:zone];
        copy.krName = [self.krName copyWithZone:zone];
        copy.children = [self.children copyWithZone:zone];
        copy.fid = self.fid;
        copy.updatedAt = [self.updatedAt copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.jpName = [self.jpName copyWithZone:zone];
    }
    
    return copy;
}


@end

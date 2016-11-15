//
//  MEChannelCategrayChildren.m
//
//  Created by vcredit  on 16/11/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MEChannelCategrayChildren.h"


NSString *const kMEChannelCategrayChildrenIcoUrl = @"ico_url";
NSString *const kMEChannelCategrayChildrenEnName = @"en_name";
NSString *const kMEChannelCategrayChildrenId = @"id";
NSString *const kMEChannelCategrayChildrenCreatedAt = @"created_at";
NSString *const kMEChannelCategrayChildrenKrName = @"kr_name";
NSString *const kMEChannelCategrayChildrenChildren = @"children";
NSString *const kMEChannelCategrayChildrenFid = @"fid";
NSString *const kMEChannelCategrayChildrenUpdatedAt = @"updated_at";
NSString *const kMEChannelCategrayChildrenName = @"name";
NSString *const kMEChannelCategrayChildrenJpName = @"jp_name";


@interface MEChannelCategrayChildren ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MEChannelCategrayChildren

@synthesize icoUrl = _icoUrl;
@synthesize enName = _enName;
@synthesize childrenIdentifier = _childrenIdentifier;
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
            self.icoUrl = [self objectOrNilForKey:kMEChannelCategrayChildrenIcoUrl fromDictionary:dict];
            self.enName = [self objectOrNilForKey:kMEChannelCategrayChildrenEnName fromDictionary:dict];
            self.childrenIdentifier = [[self objectOrNilForKey:kMEChannelCategrayChildrenId fromDictionary:dict] doubleValue];
            self.createdAt = [self objectOrNilForKey:kMEChannelCategrayChildrenCreatedAt fromDictionary:dict];
            self.krName = [self objectOrNilForKey:kMEChannelCategrayChildrenKrName fromDictionary:dict];
            self.children = [self objectOrNilForKey:kMEChannelCategrayChildrenChildren fromDictionary:dict];
            self.fid = [[self objectOrNilForKey:kMEChannelCategrayChildrenFid fromDictionary:dict] doubleValue];
            self.updatedAt = [self objectOrNilForKey:kMEChannelCategrayChildrenUpdatedAt fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMEChannelCategrayChildrenName fromDictionary:dict];
            self.jpName = [self objectOrNilForKey:kMEChannelCategrayChildrenJpName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.icoUrl forKey:kMEChannelCategrayChildrenIcoUrl];
    [mutableDict setValue:self.enName forKey:kMEChannelCategrayChildrenEnName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.childrenIdentifier] forKey:kMEChannelCategrayChildrenId];
    [mutableDict setValue:self.createdAt forKey:kMEChannelCategrayChildrenCreatedAt];
    [mutableDict setValue:self.krName forKey:kMEChannelCategrayChildrenKrName];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForChildren] forKey:kMEChannelCategrayChildrenChildren];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fid] forKey:kMEChannelCategrayChildrenFid];
    [mutableDict setValue:self.updatedAt forKey:kMEChannelCategrayChildrenUpdatedAt];
    [mutableDict setValue:self.name forKey:kMEChannelCategrayChildrenName];
    [mutableDict setValue:self.jpName forKey:kMEChannelCategrayChildrenJpName];

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

    self.icoUrl = [aDecoder decodeObjectForKey:kMEChannelCategrayChildrenIcoUrl];
    self.enName = [aDecoder decodeObjectForKey:kMEChannelCategrayChildrenEnName];
    self.childrenIdentifier = [aDecoder decodeDoubleForKey:kMEChannelCategrayChildrenId];
    self.createdAt = [aDecoder decodeObjectForKey:kMEChannelCategrayChildrenCreatedAt];
    self.krName = [aDecoder decodeObjectForKey:kMEChannelCategrayChildrenKrName];
    self.children = [aDecoder decodeObjectForKey:kMEChannelCategrayChildrenChildren];
    self.fid = [aDecoder decodeDoubleForKey:kMEChannelCategrayChildrenFid];
    self.updatedAt = [aDecoder decodeObjectForKey:kMEChannelCategrayChildrenUpdatedAt];
    self.name = [aDecoder decodeObjectForKey:kMEChannelCategrayChildrenName];
    self.jpName = [aDecoder decodeObjectForKey:kMEChannelCategrayChildrenJpName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_icoUrl forKey:kMEChannelCategrayChildrenIcoUrl];
    [aCoder encodeObject:_enName forKey:kMEChannelCategrayChildrenEnName];
    [aCoder encodeDouble:_childrenIdentifier forKey:kMEChannelCategrayChildrenId];
    [aCoder encodeObject:_createdAt forKey:kMEChannelCategrayChildrenCreatedAt];
    [aCoder encodeObject:_krName forKey:kMEChannelCategrayChildrenKrName];
    [aCoder encodeObject:_children forKey:kMEChannelCategrayChildrenChildren];
    [aCoder encodeDouble:_fid forKey:kMEChannelCategrayChildrenFid];
    [aCoder encodeObject:_updatedAt forKey:kMEChannelCategrayChildrenUpdatedAt];
    [aCoder encodeObject:_name forKey:kMEChannelCategrayChildrenName];
    [aCoder encodeObject:_jpName forKey:kMEChannelCategrayChildrenJpName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MEChannelCategrayChildren *copy = [[MEChannelCategrayChildren alloc] init];
    
    if (copy) {

        copy.icoUrl = [self.icoUrl copyWithZone:zone];
        copy.enName = [self.enName copyWithZone:zone];
        copy.childrenIdentifier = self.childrenIdentifier;
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

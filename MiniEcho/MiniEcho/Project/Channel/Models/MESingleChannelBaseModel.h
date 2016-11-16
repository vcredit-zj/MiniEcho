//
//  MESingleChannelBaseModel.h
//
//  Created by vcredit  on 16/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MESingleChannelData;

@interface MESingleChannelBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) MESingleChannelData *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

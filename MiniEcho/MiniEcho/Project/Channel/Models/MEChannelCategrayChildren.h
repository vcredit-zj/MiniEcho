//
//  MEChannelCategrayChildren.h
//
//  Created by vcredit  on 16/11/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MEChannelCategrayChildren : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *icoUrl;
@property (nonatomic, strong) NSString *enName;
@property (nonatomic, assign) double childrenIdentifier;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *krName;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, assign) double fid;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *jpName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

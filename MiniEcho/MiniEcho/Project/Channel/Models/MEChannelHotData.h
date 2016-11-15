//
//  MEChannelHotData.h
//
//  Created by vcredit  on 16/11/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MEChannelHotData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *pic750;
@property (nonatomic, assign) double status;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *desp;
@property (nonatomic, assign) double likeCount;
@property (nonatomic, assign) double listOrder;
@property (nonatomic, assign) double followCount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic200;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, strong) NSString *pic500;
@property (nonatomic, assign) double tagId;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) double shareCount;
@property (nonatomic, strong) NSString *pic1080;
@property (nonatomic, strong) NSString *pic100;
@property (nonatomic, strong) NSString *pic640;
@property (nonatomic, assign) double updateTime;
@property (nonatomic, assign) double soundCount;
@property (nonatomic, assign) double updateUserId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

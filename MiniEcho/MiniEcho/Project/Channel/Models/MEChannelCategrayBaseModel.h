//
//  MEChannelCategrayBaseModel.h
//
//  Created by vcredit  on 16/11/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MEChannelCategrayBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSArray *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

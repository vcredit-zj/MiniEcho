//
//  MESingleChannelData.h
//
//  Created by vcredit  on 16/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MESingleChannelChannel;

@interface MESingleChannelData : NSObject

@property (nonatomic, strong) MESingleChannelChannel *channel;
@property (nonatomic, assign) double news;
@property (nonatomic, strong) NSArray *sounds;


@end

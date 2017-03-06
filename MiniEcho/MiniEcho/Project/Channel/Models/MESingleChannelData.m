//
//  MESingleChannelData.m
//
//  Created by vcredit  on 16/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MESingleChannelData.h"
#import "MESingleChannelChannel.h"
#import "MESingleChannelSounds.h"



@interface MESingleChannelData ()


@end

@implementation MESingleChannelData
+ (NSDictionary *)mj_objectClassInArray {

    return @{@"sounds":@"MESingleChannelSounds"};
}
@end

//
//  PMChannel.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "PMChannel.h"


@implementation PMChannel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"channel_id" : @"id"};
}

@end

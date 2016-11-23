//
//  LocalSoundsInfo.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/22.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "LocalSoundsInfo.h"

static NSString *soundsInfoKey = @"soundsInfoKey";
static NSString *totalSoundsKey = @"totalSoundsKey";

@implementation LocalSoundsInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _soundsInfo = [NSMutableDictionary dictionary];
        _totalSoundsCount = 0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        _soundsInfo = [aDecoder decodeObjectForKey:soundsInfoKey];
        _totalSoundsCount = [aDecoder decodeIntegerForKey:totalSoundsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_soundsInfo forKey:soundsInfoKey];
    [aCoder encodeInteger:_totalSoundsCount forKey:totalSoundsKey];
}

@end

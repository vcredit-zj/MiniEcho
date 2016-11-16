//
//  MEUser.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEUser.h"

@implementation MEUser

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"userID" : @"id"};
}

@end

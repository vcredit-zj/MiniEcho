//
//  MEUser.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.

/**
 *  用户
 */
#import <Foundation/Foundation.h>

@interface MEUser : NSObject


@property (nonatomic, copy) NSString * userID;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * photo;
@property (nonatomic, copy) NSString * famous_icon;
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * avatar_50;
@property (nonatomic, copy) NSString * avatar_150;
@property (nonatomic, copy) NSString * avatar_100;
@property (nonatomic, copy) NSString * is_follow;
@property (nonatomic, copy) NSString * famous_type;

@property (nonatomic, assign) NSInteger  status;
@property (nonatomic, assign) NSInteger  followed_count;


@end

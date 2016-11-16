//
//  PMRootModel.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.

/**
 *  播放音乐界面的rootModel
 */
#import <Foundation/Foundation.h>
@class MEUser, PMSimilarSubSound, PMChannel;

@interface PMRootModel : NSObject


@property (nonatomic, copy) NSString *soundID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *length; // 歌曲总时长
@property (nonatomic, copy) NSString *pic_100;
@property (nonatomic, copy) NSString *pic_200;
@property (nonatomic, copy) NSString *pic_500;
@property (nonatomic, copy) NSString *pic_640;
@property (nonatomic, copy) NSString *pic_750;
@property (nonatomic, copy) NSString *pic_1080;

@property (nonatomic, assign) NSInteger download_count;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger view_count;

@property (nonatomic, strong) MEUser *user;

@property (nonatomic, strong) PMChannel *channel;

@property (nonatomic, copy) NSArray <PMSimilarSubSound*>*similar;

@end

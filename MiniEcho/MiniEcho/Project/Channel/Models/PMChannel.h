//
//  PMChannel.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.

/**
 *  播放音乐的channerl子模型
 */
#import <Foundation/Foundation.h>
@class PMSimilarSubSound;

@interface PMChannel : NSObject


@property (nonatomic, copy) NSString *channel_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, copy) NSString *pic_500;

@property (nonatomic, copy) NSArray *hot_sounds;



@end

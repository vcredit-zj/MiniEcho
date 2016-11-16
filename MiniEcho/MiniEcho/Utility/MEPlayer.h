//
//  MEPlayer.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MEPlayerDelegate;
@protocol MEPlayerDelegate <NSObject>

/**
 *  给外界提供当前播放时间 do something
 */
- (void)me_playingWithTime:(NSTimeInterval)time;

/**
 *  告知外界播放结束 do something
 */
- (void)me_endPlay;

@end

@interface MEPlayer : NSObject

/** 是否正在播放音乐 */
@property (nonatomic, assign) BOOL isPlaying;
/** 音量 */
@property (nonatomic, assign) float soundValue;
/** 代理 */
@property (nonatomic, weak) id <MEPlayerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *onlineMusicData;

/**
 * 单例方法
 */
+ (instancetype)shareMEPlayer;

/**
 * 给一个线上音频链接就可以播放音乐
 */
- (void)me_playMusicWithOnlineURL:(NSString *)url;

/**
 * 播放音乐
 */
- (void)me_play;

/**
 * 暂停播放
 */
- (void)me_pause;

/**
 * 根据指定时间播放音乐
 */
- (void)me_seekToTime:(float)time;

@end

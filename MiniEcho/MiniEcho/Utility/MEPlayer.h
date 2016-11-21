//
//  MEPlayer.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MEPlayMode) {
 
    MEPlayModeDefault = 0, // 默认播放模式
    MEPlayModeRandom = 1   // 随机播放模式
};

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
/** 播放模式,默认为正常播放 */
@property (nonatomic, assign) MEPlayMode playMode;
/** 代理 */
@property (nonatomic, weak) id <MEPlayerDelegate> delegate;
/** 在线音乐的(sound_id)数据集合 */
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

/**
 * 根据音乐在线链接下载歌曲
 */
- (void)me_downloadMusicWithURL:(NSString *)url;

@end

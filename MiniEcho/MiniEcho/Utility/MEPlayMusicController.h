//
//  MEPlayMusicController.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.

/**
 *  播放音乐的单例界面
 */
#import <UIKit/UIKit.h>

@interface MEPlayMusicController : UIViewController


@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isLocal;


+ (instancetype)sharePlayMusicController;

/** 下一曲 */
- (void)nextMusic;

/** 上一曲 */
- (void)previousMusic;

/** 播放 */
- (void)playMusic;

/** 暂停 */
- (void)pauseMusic;

/** 锁屏播放信息 */
- (void)configLockedScreenPlayingInfo;


@end

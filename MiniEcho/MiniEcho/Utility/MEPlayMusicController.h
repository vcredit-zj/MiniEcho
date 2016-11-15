//
//  MEPlayMusicController.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEPlayMusicController : UIViewController


@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isLocal;


- (void)prepareForPlay;

/** 下一曲 */
- (void)nextMusic;

/** 上一曲 */
- (void)PreviousMusic;

/** 播放 */
- (void)playMusic;

/** 暂停 */
- (void)pauseMusic;

/** 锁屏播放信息 */
- (void)configLockedScreenPlayingInfo;


@end

//
//  MEPlayer.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface MEPlayer ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MEPlayer


#pragma mark - Public Methods

+ (instancetype)shareMEPlayer
{
    static MEPlayer *playerHelper = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        playerHelper = [[MEPlayer alloc] init];
    });
    return playerHelper;
}

- (void)me_playMusicWithOnlineURL:(NSString *)url
{
    NSURL *musicUrl = nil;
    //判断网络music还是本地music
    if ([[url substringToIndex:7] isEqualToString:@"http://"]) {
        musicUrl = [NSURL URLWithString:url];
        NSLog(@"网路url--%@",musicUrl);
    }else{
        
        musicUrl = [NSURL fileURLWithPath:url];
        NSLog(@"本地url--%@",musicUrl);
    }
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:musicUrl];
    [self me_pause];
    
    //切换当前音乐
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    //这样需要加载才会播放  这里有一个更好的方法 看看你能不能看懂 kov 监听 status 新值 这个属性是什么意思 AVPlayerStatus 枚举 代表播放器的状态，
    [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self me_play];
}

- (void)me_play
{
    if (self.isPlaying) return;
    
    [self.player play];
    self.isPlaying = YES;
    
    if (self.timer) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updatePlayTime) userInfo:nil repeats:YES];
}

- (void)me_pause
{
    if (!self.isPlaying) return;
    
    [self.player pause];
    self.isPlaying = NO;
    
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (void)me_seekToTime:(float)time
{
    [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
        [self me_play];
    }];
}

#pragma mark - Private Methods

// 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _onlineMusicData = [NSMutableArray array];
        
        //监听并且通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didToStop) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
        //设置播放会话，在后台可以继续播放（还需要设置程序允许后台运行模式）
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        if(![[AVAudioSession sharedInstance] setActive:YES error:nil])
        {
            NSLog(@"播放会话激活失败");
        }
    }
    return self;
}

- (void)didToStop
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(me_endPlay)]) {
        [self.delegate me_endPlay];
    }
}

// 观察者执行事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        if (self.player.status == AVPlayerStatusReadyToPlay) {
            [self me_play];
        }
    }
}

// 更新播放时间
- (void)updatePlayTime
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(me_playingWithTime:)]) {
        
        NSTimeInterval time = self.player.currentTime.value / self.player.currentTime.timescale;
        [self.delegate me_playingWithTime:time];
    }
}

#pragma mark - Setter & Getter Sound Value

- (void)setSoundValue:(float)soundValue
{
    self.player.volume = soundValue;
}

- (float)soundValue
{
    return self.player.volume;
}

#pragma mark - Lazy Load

- (AVPlayer *)player
{
    if (!_player) {
        
        _player = [[AVPlayer alloc] init];
    }
    
    return _player;
}

@end

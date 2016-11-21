//
//  MEPlayer.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking/AFNetworking.h>
#import "HYFileManager.h"

static NSString *musicDirectory = @"/localmusic/";

@interface MEPlayer ()

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

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
    
    if (!self.player) {
        // 初始化
        self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    } else {
    
        //切换当前音乐
        [self.player replaceCurrentItemWithPlayerItem:item];
    }
    
    
    //这样需要加载才会播放  这里有一个更好的方法 看看你能不能看懂 kov 监听 status 新值 这个属性是什么意思 AVPlayerStatus 枚举 代表播放器的状态，
    [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self me_play];
}

- (void)me_play
{
    if (self.isPlaying) return;
    
    [self.player play];
    self.isPlaying = YES;
    
    __weak typeof(self) weakSelf = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        if (current) {
            [weakSelf updatePlayTime:current];
        }
    }];
}

- (void)me_pause
{
    if (!self.isPlaying || !self.player) return;
    
    [self.player pause];
    self.isPlaying = NO;
    
    // 停止定时器
    // [self.timer invalidate];
    // self.timer = nil;
}

- (void)me_seekToTime:(float)time
{
    [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
        [self me_play];
    }];
}

- (void)me_downloadMusicWithURL:(NSString *)url
{
    NSString *urlStr = [[url componentsSeparatedByString:@"?"] firstObject];
    
    [SVProgressHUD show];
    NSURL *URL = [NSURL URLWithString:urlStr];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:URL];
    
    _downloadTask = [manager downloadTaskWithRequest:req progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // 获取下载进度
        float progress = downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        DLog(@"下载进度:%.4f", progress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        // 返回下载文件的本地文件路径
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // [HYFileManager createDirectoryAtPath:cachesPath];
        
        NSString *fileName = [NSString stringWithFormat:@"%@%@.mp3",musicDirectory,[MEUtil md5String:url]];
        NSString *filePath =  [cachesPath stringByAppendingPathComponent:fileName];
        DLog(@"filePath:%@",filePath);
        
        
        return [NSURL URLWithString:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            DLog(@"下载音乐发生错误:%@",error);
        } else {
        
            // 下载完成
            DLog(@"下载完成filePath:%@",filePath);
            [SVProgressHUD dismiss];
        }
        
    }];
    
    [_downloadTask resume];
}

#pragma mark - Private Methods

// 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _onlineMusicData = [NSMutableArray array];
        _playMode = MEPlayModeDefault;
        
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
- (void)updatePlayTime:(float)time
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(me_playingWithTime:)]) {
        
        NSTimeInterval timeInterval = (NSTimeInterval)time;
        [self.delegate me_playingWithTime:timeInterval];
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


@end

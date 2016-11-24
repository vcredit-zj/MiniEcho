//
//  MEOffLinePlayMusicController.m
//  MiniEcho
//
//  Created by vcredit on 2016/11/24.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEOffLinePlayMusicController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "LocalSoundsInfo.h"
#import "MESoundsDownloader.h"
@interface MEOffLinePlayMusicController ()<MEPlayerDelegate>
@property (nonatomic,strong) UIView *topNavigationBar;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation MEOffLinePlayMusicController

#pragma mark - ViewController LifeCycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    _currentIndex = self.index;
    NSString *source = [MEPlayer shareMEPlayer].onlineMusicData[_currentIndex];
        // 加载歌曲信息
    [self playOffLineMusicWithSongPath:source];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    [MEPlayer shareMEPlayer].delegate = self;
    _currentIndex = -1;
    // 开始接受远程事件<音频中断>
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    // 监听后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionEvent:) name:AVAudioSessionInterruptionNotification object:nil];
}
- (void)initSubViews {
    __weak typeof(self)weakSelf = self;
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cm2_default_play_bg"] ];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    // Dispose of any resources that can be recreated.
    UIView *topNavBar = [[UIView alloc] init];
    topNavBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64);
    topNavBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topNavBar];
    UILabel *centerLabel = [[UILabel alloc] init];
    [centerLabel setTextColor:[UIColor whiteColor]];
    [centerLabel setTextAlignment:NSTextAlignmentCenter];
    [centerLabel setFont:[UIFont systemFontOfSize:14.f]];
    centerLabel.tag = 0;
    centerLabel.text = @"text";
    [topNavBar addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topNavBar).with.offset(20);
        make.centerX.equalTo(topNavBar);
        make.height.equalTo(@16);
        make.width.equalTo(@200);
    }];
    UILabel *bottomLabel = [[UILabel alloc] init];
    [bottomLabel setTextColor:[UIColor whiteColor]];
    [bottomLabel setTextAlignment:NSTextAlignmentCenter];
    [bottomLabel setFont:[UIFont systemFontOfSize:12.f]];
    bottomLabel.tag = 0;
    bottomLabel.text = @"name";
    [topNavBar addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerLabel.mas_bottom).with.offset(2);
        make.centerX.equalTo(topNavBar);
        make.height.equalTo(@16);
        make.width.equalTo(@200);
    }];
    
    UIButton *BackBtn = [[UIButton alloc] init];
    //    BackBtn.tag = backBtnTag;
    [BackBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [BackBtn addActionHandler:^(NSInteger tag) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [topNavBar addSubview:BackBtn];
    [BackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topNavBar).with.offset(15);
        make.bottom.equalTo(topNavBar.mas_bottom).with.offset(-20);;
        make.height.equalTo(@25);
        make.width.equalTo(@14);
    }];
    _topNavigationBar = topNavBar;
    
    
    
}
#pragma mark - MEPlayerDelegate

- (void)me_endPlay {
    [self nextMusic];
}
- (void)me_playingWithTime:(NSTimeInterval)time {

}
#pragma mark - NSNotification Method<音频中断暂停播放>

- (void)audioSessionEvent:(NSNotification *)notify
{
    [self pauseMusic];
}

#pragma mark - Public Methods

+ (instancetype)sharePlayMusicController
{
    return [[self alloc] init];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    static MEOffLinePlayMusicController *playVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playVC = [super allocWithZone:zone];
    });
    return playVC;
}
- (void)playMusic
{
    [[MEPlayer shareMEPlayer] me_play];
}

- (void)pauseMusic
{
    [[MEPlayer shareMEPlayer] me_pause];
}

- (void)nextMusic
{
    // 判断播放模式, 选择播放哪一首歌曲
    MEPlayMode mode = [MEPlayer shareMEPlayer].playMode;
    if (mode == MEPlayModeDefault) {
        _currentIndex++;
    } else if (mode == MEPlayModeRandom) {
        NSInteger idx = arc4random() % ([MEPlayer shareMEPlayer].onlineMusicData.count);
        _currentIndex = idx;
    }
    
    // 防止越界
    if (_currentIndex >= [[[MEPlayer shareMEPlayer] onlineMusicData] count]) {
        _currentIndex = 0;
    }
    
    NSString *sound_id = [MEPlayer shareMEPlayer].onlineMusicData[_currentIndex];
    // 重新加载歌曲信息
    [self playOffLineMusicWithSongPath:sound_id];
}

- (void)previousMusic
{
    // 判断播放模式, 选择播放哪一首歌曲
    MEPlayMode mode = [MEPlayer shareMEPlayer].playMode;
    if (mode == MEPlayModeDefault) {
        _currentIndex--;
    } else if (mode == MEPlayModeRandom) {
        NSInteger idx = arc4random() % ([MEPlayer shareMEPlayer].onlineMusicData.count);
        _currentIndex = idx;
    }
    
    // 防止越界
    if (_currentIndex < 0) {
        _currentIndex = [[[MEPlayer shareMEPlayer] onlineMusicData] count] -1;
    }
    NSString *sound_id = [MEPlayer shareMEPlayer].onlineMusicData[_currentIndex];
    // 重新加载歌曲信息
    [self playOffLineMusicWithSongPath:sound_id];
}



#pragma mark - Util

- (void)playOffLineMusicWithSongPath:(NSString *)source
{
    
    LocalSoundsInfo *soundInfo = [[MESoundsDownloader shareMusicDownloader] getLocalSoundsInfo];
    NSString *songPath = [soundInfo.soundsInfo objectForKey:source];

   [[MEPlayer shareMEPlayer] me_playMusicWithOnlineURL:songPath];
}



@end

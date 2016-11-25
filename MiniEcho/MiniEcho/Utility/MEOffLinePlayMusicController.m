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
#import "MELocalSound.h"
static NSInteger BottomPlayBtnTag = 111;
static NSInteger BottomNextBtnTag = 121;
static NSInteger BottomPrevBtnTag = 131;

static NSInteger TopNavBarSongNameLabelTag = 120;
static NSInteger TopNavBarSongSingleLabelTag = 130;
@interface MEOffLinePlayMusicController ()<MEPlayerDelegate,UITextViewDelegate>
@property (nonatomic,strong) UIView *topNavigationBar;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) UITextView *lyricsTextView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation MEOffLinePlayMusicController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
    [MEPlayer shareMEPlayer].delegate = self;
    _currentIndex = -1;
    // 开始接受远程事件<音频中断>
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    // 监听后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionEvent:) name:AVAudioSessionInterruptionNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    _currentIndex = self.index;
    // 加载歌曲信息
    [self playOffLineMusic];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
    centerLabel.tag = TopNavBarSongNameLabelTag;
    centerLabel.text = @"text";
    [topNavBar addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topNavBar).with.offset(20);
        make.centerX.equalTo(topNavBar);
        make.height.equalTo(@16);
        make.width.equalTo(@250);
    }];
    UILabel *bottomLabel = [[UILabel alloc] init];
    [bottomLabel setTextColor:[UIColor whiteColor]];
    [bottomLabel setTextAlignment:NSTextAlignmentCenter];
    [bottomLabel setFont:[UIFont systemFontOfSize:12.f]];
    bottomLabel.tag = TopNavBarSongSingleLabelTag;
    bottomLabel.text = @"name";
    [topNavBar addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerLabel.mas_bottom).with.offset(2);
        make.centerX.equalTo(topNavBar);
        make.height.equalTo(@16);
        make.width.equalTo(@200);
    }];
    
    UIButton *BackBtn = [[UIButton alloc] init];
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
    
    UITextView *lyricsTextView = [[UITextView alloc] init];
    lyricsTextView.delegate = self;
    lyricsTextView.showsVerticalScrollIndicator = NO;
    lyricsTextView.showsHorizontalScrollIndicator = NO;
    lyricsTextView.backgroundColor = [UIColor clearColor];
    lyricsTextView.textAlignment = NSTextAlignmentCenter;
    lyricsTextView.textContainerInset = UIEdgeInsetsMake(30, 0, 10, 0);
    [self.view addSubview:lyricsTextView];
    NSString *lyric = @"Remembering me discover and see\nAll over the world she's known as a girl\nTo those who are free their minds shall be keep\nForgotten as the past 'cause history will last\nGod is a girl wherever you are\nDo you believe it can you receive it\nGod is a girl whatever you say\nDo you believe it can you receive it\nGod is a girl however you live\nDo you believe it can you receive it\nGod is a girl she's only a girl\nDo you believe it can you receive it\nShe wants to shine forever in time\nShe is so driven she's always mine\nClearly and free she wants you to be\nA part of the future a girl like me\nThere is a sky illuminating us\nSomeone is out there that we truly trust\nThere is a rainbow for you and me\nA beautiful sunrise eternally\nGod is a girl wherever you are\nDo you believe it can you receive it\nGod is a girl whatever you say\nDo you believe it can you receive it\nGod is a girl however you live\nDo you believe it can you receive it\nGod is a girl she's only a girl\nDo you believe it can you receive it\nGod is a girl wherever you are\nDo you believe it can you receive it\nGod is a girl whatever you say\nDo you believe it can you receive it\nGod is a girl however you live\nDo you believe it can you receive it\nGod is a girl she's only a girl\nDo you believe it can you receive it\nGod is a girl";
    NSMutableAttributedString *lyricAttr = [[NSMutableAttributedString alloc] initWithString:lyric];
    lyricAttr.yy_font = [UIFont systemFontOfSize:14.0];
    lyricAttr.yy_color = [UIColor whiteColor];
    lyricAttr.yy_lineSpacing = 15.f;
    lyricAttr.yy_alignment = NSTextAlignmentCenter;
    lyricsTextView.attributedText = lyricAttr;
    [lyricsTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topNavBar.mas_bottom).with.offset(13);
        make.bottom.equalTo(self.view).with.offset(-80);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    UIView *bottomBar = [[UIView alloc] init];
    [self.view addSubview:bottomBar];
    [bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-18);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    UIButton *playBtn = [[UIButton alloc] init];
    [bottomBar addSubview:playBtn];
    [playBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_pause"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"cm2_btn_play"] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    playBtn.tag = BottomPlayBtnTag;
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomBar);
        make.top.equalTo(bottomBar);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    UIButton *nextBtn = [[UIButton alloc] init];
    [bottomBar addSubview:nextBtn];
    UIImage *oriImage = [UIImage imageNamed:@"cm2_fm_btn_next"];
    [oriImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [nextBtn setImage:[oriImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(playBtn.mas_right).with.offset(10);
        make.centerY.equalTo(playBtn);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [nextBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.tag = BottomNextBtnTag;
    UIButton *prevBtn = [[UIButton alloc] init];
    [bottomBar addSubview:prevBtn];
    [prevBtn setImage:[[UIImage imageNamed:@"cm2_play_btn_prev"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
    [prevBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    prevBtn.tag = BottomPrevBtnTag;
    [prevBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(playBtn.mas_left).with.offset(-10);
        make.centerY.equalTo(playBtn);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
}
#pragma mark - BottomBtnAction
- (void)bottomBtnClick:(UIButton *)sender {

    if (sender.tag == BottomPlayBtnTag) {
        DLog(@"play");
        sender.selected = !sender.isSelected;
        if (!sender.selected) {
            [self playMusic];
        }else {
        
            [self pauseMusic];
        }
    }else if (sender.tag == BottomPrevBtnTag) {
    
        [self previousMusic];
        DLog(@"prev");
    } else if (sender.tag == BottomNextBtnTag) {
    
        [self nextMusic];
        DLog(@"next");
    }
    
}
#pragma mark - Lazy load
- (NSArray *)dataArray {
    
    if (!_dataArray) {
        NSMutableArray *tempArrayM = [NSMutableArray array];
        RLMResults<MELocalSound *> *results = [MELocalSound allObjects];
        for (MELocalSound *localSound in results) {
            [tempArrayM safeAddObject:localSound];
        }
        _dataArray = [NSArray arrayWithArray:tempArrayM];
    }
    return _dataArray;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

    return NO;
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
    // 重新加载歌曲信息
    [self playOffLineMusic];
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
    // 重新加载歌曲信息
    [self playOffLineMusic];
}

- (void)configLockedScreenPlayingInfo
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        MELocalSound *songModel = [self.dataArray safeObjectAtIndex:_currentIndex];
        //要一个字典存放要显示的信息
        NSMutableDictionary *musicDict = [[NSMutableDictionary alloc] init];
        
        //歌曲名称
        [musicDict setObject:songModel.name forKey:MPMediaItemPropertyTitle];
        //演唱者
        [musicDict setObject:songModel.singer forKey:MPMediaItemPropertyArtist];
        //专辑名
//        [musicDict setObject:_channel.name forKey:MPMediaItemPropertyAlbumTitle];
        //专辑缩略图
//        if (self.headerView.image != nil){
//            UIImage *image = self.headerView.image;
//            MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
//            [musicDict setObject:artwork forKey:MPMediaItemPropertyArtwork];
//        }
        //音乐剩余时长
//        [musicDict setObject:[NSNumber numberWithDouble:[_rootModel.length doubleValue]] forKey:MPMediaItemPropertyPlaybackDuration];
//        //音乐当前播放时间 在计时器中修改
//        [musicDict setObject:[NSNumber numberWithDouble:_currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        //设置锁屏状态下屏幕显示播放音乐信息
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:musicDict];
    }
}


#pragma mark - Util

- (void)playOffLineMusic
{
    NSString *source = [MEPlayer shareMEPlayer].onlineMusicData[_currentIndex];
    LocalSoundsInfo *soundInfo = [[MESoundsDownloader shareMusicDownloader] getLocalSoundsInfo];
    NSString *songPath = [soundInfo.soundsInfo objectForKey:source];

    MELocalSound *songModel = [self.dataArray safeObjectAtIndex:_currentIndex];
    UILabel *songNameLabel = [_topNavigationBar viewWithTag:TopNavBarSongNameLabelTag];
    songNameLabel.text = songModel.name;
    UILabel *songSingleLabel = [_topNavigationBar viewWithTag:TopNavBarSongSingleLabelTag];
    songSingleLabel.text = songModel.singer;
    [self configLockedScreenPlayingInfo];
   [[MEPlayer shareMEPlayer] me_playMusicWithOnlineURL:songPath];
}



@end

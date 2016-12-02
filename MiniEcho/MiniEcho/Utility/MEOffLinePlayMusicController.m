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
#import "MEOffLineSongTableViewCell.h"
#import "MEOffLinePlayBottomBar.h"
static NSInteger TopNavBarSongNameLabelTag = 120;
static NSInteger TopNavBarSongSingleLabelTag = 130;
static NSInteger BottomSheetViewBgViewTag = 140;
static NSInteger BottomSheetViewMainViewTag = 150;
static NSInteger BottomSheetViewTableViewTag = 160;
static CGFloat   BottomSheetViewTableViewCellHeight = 60.f;
@interface MEOffLinePlayMusicController ()<MEPlayerDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *topNavigationBar;
@property (nonatomic,strong) MEOffLinePlayBottomBar *bottomBar;
@property (nonatomic,strong) UIView *bottomSheetView;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) UITextView *lyricsTextView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIView *bottomSheetViewBgView;
@property (nonatomic,strong) UIView *bottomSheetViewMainView;
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

    NSMutableArray *tempArrayM = [NSMutableArray array];
    RLMResults<MELocalSound *> *results = [MELocalSound allObjects];
    for (MELocalSound *localSound in results) {
        [tempArrayM safeAddObject:localSound];
    }
    self.dataArray = [NSArray arrayWithArray:tempArrayM];
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
        make.centerY.equalTo(topNavBar).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(14, 25));
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
    _lyricsTextView = lyricsTextView;
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
    
    MEOffLinePlayBottomBar *bottomBar = [[MEOffLinePlayBottomBar alloc] initWithFrame:CGRectZero];
    _bottomBar = bottomBar;
    bottomBar.btnClickCallBcak = ^(BottomBarBtnType btnType, BOOL selected){
    
        switch (btnType) {
            case BottomBarBtnTypePlay:
            {
                DLog(@"play");
                if (selected) {
                    [weakSelf pauseMusic];
                } else {
                
                    [weakSelf playMusic];
                }
                
            }
                break;
            case BottomBarBtnTypeNext:
            {
                [weakSelf nextMusic];
                DLog(@"next");
                
            }
                break;
            case BottomBarBtnTypePrev:
            {
                [weakSelf previousMusic];
                DLog(@"prev");
            }
                break;
            case BottomBarBtnTypeList:
            {
                [weakSelf showList];
                DLog(@"list");
            }
                break;
            case BottomBarBtnTypeModel:
            {
                [weakSelf changePlaymodel];
                DLog(@"list");
            }
                break;
                
            default:
                break;
        }
    };
    [self.view addSubview:bottomBar];
    [bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-18);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@75);
    }];
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
- (UIView *)bottomSheetView {

    if (!_bottomSheetView) {
        UIView *bottomSheetView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:bottomSheetView];
        _bottomSheetView = bottomSheetView;
        UIView *bgview = [[UIView alloc] initWithFrame:bottomSheetView.bounds];
        bgview.tag = BottomSheetViewBgViewTag;
        _bottomSheetViewBgView = bgview;
        bgview.backgroundColor = [UIColor grayColor];
        bgview.alpha = 0;
        [bottomSheetView addSubview:bgview];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenList)];
        [bgview addGestureRecognizer:tap];
        
        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(bottomSheetView.frame), CGRectGetWidth(bottomSheetView.frame), 350)];
        mainView.tag = BottomSheetViewMainViewTag;
        mainView.alpha = 0.88;
        _bottomSheetViewMainView = mainView;
        mainView.backgroundColor = [UIColor clearColor];
        [bottomSheetView addSubview:mainView];

        UIButton *closeBtn = [[UIButton alloc] init];
        closeBtn.backgroundColor = [UIColor whiteColor];
        [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mainView addSubview:closeBtn];
        [closeBtn addTarget:self action:@selector(hiddenList) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(mainView);
            make.left.equalTo(mainView);
            make.right.equalTo(mainView);
            make.height.equalTo(@55);
        }];
        UIView *linegrayView = [[UIView alloc] init];
        linegrayView.backgroundColor = [UIColor grayColor];
        [mainView addSubview:linegrayView];
        [linegrayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(closeBtn.mas_top);
            make.left.equalTo(mainView);
            make.right.equalTo(mainView);
            make.height.equalTo(@(1/[UIScreen mainScreen].scale));
        }];
        
        
        UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.rowHeight = BottomSheetViewTableViewCellHeight;
        mainTableView.tag = BottomSheetViewTableViewTag;
        [mainTableView registerNib:[MEOffLineSongTableViewCell nib] forCellReuseIdentifier:MEOffLineSongTableViewCellID];
        [mainView addSubview:mainTableView];
        [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(closeBtn.mas_top);
            make.left.equalTo(mainView);
            make.right.equalTo(mainView);
            make.height.equalTo(@225);
        }];
        mainTableView.tableFooterView = ({
        
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor clearColor];
            view;
        });
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        [mainView addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(mainTableView.mas_top);
            make.left.equalTo(mainView);
            make.right.equalTo(mainView);
            make.height.equalTo(@50);
        }];
        UILabel *songNumberLabel = [[UILabel alloc] init];
        songNumberLabel.text = [NSString stringWithFormat:@"播放列表(%ld)",[self.dataArray count] ];
        songNumberLabel.font = [UIFont systemFontOfSize:12.f];
        [songNumberLabel setTextAlignment:NSTextAlignmentCenter];
        [headerView addSubview:songNumberLabel];
        [songNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerView);
            make.top.equalTo(headerView);
            make.bottom.equalTo(headerView);
            make.width.equalTo(@100);
        }];
        UIView *lineGrayView = [[UIView alloc] init];
        lineGrayView.backgroundColor = [UIColor grayColor];
        [mainView addSubview:lineGrayView];
        [lineGrayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(songNumberLabel.mas_bottom);
            make.left.equalTo(mainView);
            make.right.equalTo(mainView);
            make.height.equalTo(@(1/[UIScreen mainScreen].scale));
        }];

    }
    return _bottomSheetView;
}
- (void)showList {

    if (self.bottomSheetView) {
        _bottomSheetView.hidden = NO;
        UITableView *mainTableView = [_bottomSheetViewMainView viewWithTag:BottomSheetViewTableViewTag];
        [mainTableView reloadData];
        [mainTableView setContentOffset:CGPointMake(0, _currentIndex * BottomSheetViewTableViewCellHeight) animated:YES];
//        UIView *bottomMainView = [_bottomSheetView viewWithTag:BottomSheetViewBgViewTag];
//        UIView *bottomBgView = [_bottomSheetView viewWithTag:BottomSheetViewMainViewTag];
        CGRect oldFrame = _bottomSheetViewMainView.frame;
        oldFrame.origin.y = CGRectGetHeight(_bottomSheetView.frame) - oldFrame.size.height;
        _bottomSheetViewBgView.alpha = 0;
        [UIView animateWithDuration:0.8f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _bottomSheetViewMainView.frame = oldFrame;
            _bottomSheetViewBgView.alpha = 0.5;

        } completion:^(BOOL finished) {
            _bottomSheetViewMainView.frame = oldFrame;
            _bottomSheetViewBgView.alpha = 0.5;
        }];
        
    }
    
    
}
- (void)hiddenList {
//    UIView *bottomMainView = [_bottomSheetView viewWithTag:BottomSheetViewBgViewTag];
//    UIView *bottomBgView = [_bottomSheetView viewWithTag:BottomSheetViewMainViewTag];
    CGRect oldFrame = _bottomSheetViewMainView.frame;
    oldFrame.origin.y = CGRectGetHeight(_bottomSheetView.frame);
    [UIView animateWithDuration:0.8f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _bottomSheetViewMainView.frame = oldFrame;
        _bottomSheetViewBgView.alpha = 0;
    } completion:^(BOOL finished) {
        _bottomSheetViewMainView.frame = oldFrame;
        _bottomSheetViewBgView.alpha = 0;
        _bottomSheetView.hidden = YES;
    }];
}
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
- (void)changePlaymodel {

    if (MEPlayModeRandom != [MEPlayer shareMEPlayer].playMode) {
        [MEPlayer shareMEPlayer].playMode = MEPlayModeRandom;
    }else {
        [MEPlayer shareMEPlayer].playMode = MEPlayModeDefault;
    }
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

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MEOffLineSongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MEOffLineSongTableViewCellID];
    cell.model = [self.dataArray safeObjectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_currentIndex == indexPath.row) {
        [cell setSelected:YES animated:YES];
        cell.selected = YES;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (_currentIndex == indexPath.row) return;
    DLog(@"click");
    _currentIndex = indexPath.row;
//    [tableView reloadData];
    [self playOffLineMusic];
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
    NSMutableAttributedString *lyricAttr = [[NSMutableAttributedString alloc] initWithString:@"缺少歌词信息"];
    if (songModel.lyric && [songModel.lyric length] > 0) {
        lyricAttr = [[NSMutableAttributedString alloc] initWithString:songModel.lyric];
    }
    lyricAttr.yy_font = [UIFont systemFontOfSize:14.0];
    lyricAttr.yy_color = [UIColor whiteColor];
    lyricAttr.yy_lineSpacing = 15.f;
    lyricAttr.yy_alignment = NSTextAlignmentCenter;
    _lyricsTextView.attributedText = lyricAttr;
    [self configLockedScreenPlayingInfo];
    [[MEPlayer shareMEPlayer] me_playMusicWithOnlineURL:songPath];
}
@end

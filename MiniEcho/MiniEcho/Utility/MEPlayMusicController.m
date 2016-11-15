//
//  MEPlayMusicController.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

// tool
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


#import "MEPlayMusicController.h"


// view
#import "MEPlayToolBar.h"
#import "PMHeaderView.h"
#import "PMUserInfoCell.h"
#import "PMChannelInfoCell.h"
#import "PMSoundIntroductionCell.h"
#import "PMRecommendCell.h"

static NSString *userID = @"PMUserInfoCellID";
static NSString *channelID = @"PMChannelInfoCellID";
static NSString *soundID = @"PMSoundIntroductionCellID";
static NSString *recommendID = @"PMRecommendCellID";

@interface MEPlayMusicController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) PMHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MEPlayMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self initSubviews];
}

#pragma mark - Initialization

- (void)initSubviews
{
    _headerView = [[PMHeaderView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, kScreenWidth + 70.f)];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
    }];
    [_tableView registerNib:[PMUserInfoCell nib] forCellReuseIdentifier:userID];
    [_tableView registerNib:[PMChannelInfoCell nib] forCellReuseIdentifier:channelID];
    [_tableView registerNib:[PMSoundIntroductionCell nib] forCellReuseIdentifier:soundID];
    [_tableView registerNib:[PMRecommendCell nib] forCellReuseIdentifier:recommendID];
    
    MEPlayToolBar *toolBar = [[MEPlayToolBar alloc] init];
    [self.view addSubview:toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        PMUserInfoCell *uCell = [tableView dequeueReusableCellWithIdentifier:userID forIndexPath:indexPath];
        cell = uCell;
    } else if (indexPath.row == 1) {
        PMChannelInfoCell *cCell = [tableView dequeueReusableCellWithIdentifier:channelID forIndexPath:indexPath];
        cell = cCell;
    } else if (indexPath.row == 2) {
        PMSoundIntroductionCell *sCell = [tableView dequeueReusableCellWithIdentifier:soundID forIndexPath:indexPath];
        cell = sCell;
    } else if (indexPath.row == 3) {
        PMRecommendCell *rCell = [tableView dequeueReusableCellWithIdentifier:recommendID forIndexPath:indexPath];
        cell = rCell;
    }
    return cell;
}

#pragma mark - Public Methods

- (void)configLockedScreenPlayingInfo
{ /*
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        //要一个字典存放要显示的信息
        NSMutableDictionary *musicDict = [[NSMutableDictionary alloc] init];
        
        //歌曲名称
        [musicDict setObject:@"" forKey:MPMediaItemPropertyTitle];
        //演唱者
        [musicDict setObject:@"" forKey:MPMediaItemPropertyArtist];
        //专辑名
        [musicDict setObject:@"" forKey:MPMediaItemPropertyAlbumTitle];
        //专辑缩略图
        if (self.playerImgView.image != nil){
            UIImage *image = self.playerImgView.image;
            MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
            [musicDict setObject:artwork forKey:MPMediaItemPropertyArtwork];
        }
        //音乐剩余时长
        [musicDict setObject:[NSNumber numberWithDouble:[_currentSound.length doubleValue]] forKey:MPMediaItemPropertyPlaybackDuration];
        //音乐当前播放时间 在计时器中修改
        [musicDict setObject:[NSNumber numberWithDouble:_currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        //设置锁屏状态下屏幕显示播放音乐信息
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }  */
}

@end

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

// model
#import "PMRootModel.h"
#import "PMHerderModel.h"
#import "MEUser.h"
#import "PMChannel.h"
#import "PMSimilarSubSound.h"



static NSString *userID = @"PMUserInfoCellID";
static NSString *channelID = @"PMChannelInfoCellID";
static NSString *soundID = @"PMSoundIntroductionCellID";
static NSString *recommendID = @"PMRecommendCellID";

#define TopImageHeight  (kScreenWidth + 70.f)

@interface MEPlayMusicController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) PMHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PMRootModel *rootModel;

@property (nonatomic, strong) PMHerderModel *headerModel;

@property (nonatomic, strong) MEUser *user;
@property (nonatomic, strong) PMChannel *channel;
@property (nonatomic,   copy) NSArray *similar;

@end

@implementation MEPlayMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self initSubviews];
    [self requestSoundInfoFromServer];
}

#pragma mark - Initialization

- (void)initSubviews
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(TopImageHeight, 0, 0, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
    }];
    [_tableView registerNib:[PMUserInfoCell nib] forCellReuseIdentifier:userID];
    [_tableView registerNib:[PMChannelInfoCell nib] forCellReuseIdentifier:channelID];
    [_tableView registerNib:[PMSoundIntroductionCell nib] forCellReuseIdentifier:soundID];
    [_tableView registerNib:[PMRecommendCell nib] forCellReuseIdentifier:recommendID];
    
    _headerView = [[PMHeaderView alloc] initWithFrame:CGRectMake(0.f,-TopImageHeight, kScreenWidth, TopImageHeight)];
    [_tableView addSubview:_headerView];
    [_tableView insertSubview:_headerView atIndex:0];
    
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
    CGFloat itemWidth = (kScreenWidth - 40.f) / 3;
    if (indexPath.row == 0) { // 用户
        
        return 70.f;
    } else if (indexPath.row == 1) { // 频道
        
        return itemWidth + 110.f;
    } else if (indexPath.row == 2) { // 歌词
        
        if (_rootModel) {
            NSMutableAttributedString *lyric = [[NSMutableAttributedString alloc] initWithString:_rootModel.info];
            lyric.yy_font = [UIFont systemFontOfSize:12.0];
            lyric.yy_color = [UIColor colorWithHexString:@"#333333"];
            lyric.yy_lineSpacing = 5.f;
            lyric.yy_alignment = NSTextAlignmentCenter;
            
            CGFloat limitWidth = kScreenWidth - 20.f;
            
            return [MEUtil heightForAttributedString:lyric constrainedWidth:limitWidth];
        }
        
    } else if (indexPath.row == 3) { // 推荐
        
        return itemWidth + 30.f;
    }
    
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        PMUserInfoCell *uCell = [tableView dequeueReusableCellWithIdentifier:userID forIndexPath:indexPath];
        if (_rootModel) {
            uCell.user = _rootModel.user;
        }
        cell = uCell;
    } else if (indexPath.row == 1) {
        PMChannelInfoCell *cCell = [tableView dequeueReusableCellWithIdentifier:channelID forIndexPath:indexPath];
        if (_rootModel) {
            cCell.channel = _rootModel.channel;
        }
        cell = cCell;
    } else if (indexPath.row == 2) {
        PMSoundIntroductionCell *sCell = [tableView dequeueReusableCellWithIdentifier:soundID forIndexPath:indexPath];
        if (_rootModel) {
            sCell.lyric = _rootModel.info;
        }
        cell = sCell;
    } else if (indexPath.row == 3) {
        PMRecommendCell *rCell = [tableView dequeueReusableCellWithIdentifier:recommendID forIndexPath:indexPath];
        if (_rootModel) {
            rCell.sounds = _rootModel.similar;
        }
        cell = rCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    _headerView.offset = point.y;
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

#pragma mark - Util

- (void)requestSoundInfoFromServer
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *param = @{@"sound_id" : @"1322743"};
    [MEHttpUtil get:SoundInfo parameters:param showLoading:YES success:^(id result) {

        
        weakSelf.rootModel = [PMRootModel mj_objectWithKeyValues:result];
        weakSelf.user = [MEUser mj_objectWithKeyValues:result[@"user"]];
        weakSelf.channel = [PMChannel mj_objectWithKeyValues:result[@"channel"]];
        weakSelf.similar = [PMSimilarSubSound mj_objectArrayWithKeyValuesArray:result[@"similar"]];
        [weakSelf refreshScreen];
        
    } failure:^(NSError *error) {
        DLog(@"获取歌曲信息失败");
    }];
}

- (void)refreshScreen
{
    NSString *title = _rootModel.name;
    self.title = title;
    
    if (!_headerModel) {
        _headerModel = [PMHerderModel new];
    }
    _headerModel.picURL = _rootModel.pic_500;
    _headerModel.view_count = _rootModel.view_count;
    _headerModel.download_count = _rootModel.download_count;
    _headerModel.like_count = _rootModel.like_count;
    _headerView.model = _headerModel;
    
    [_tableView reloadData];
}

@end

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

@interface MEPlayMusicController ()

@end

@implementation MEPlayMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    MEPlayToolBar *toolBar = [[MEPlayToolBar alloc] init];
    [self.view addSubview:toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
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

//
//  MESoundsDownloader.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/22.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LocalSoundsInfo;

typedef void(^DownloadProgressCallback)(float progress);
typedef void(^DownloadCompletion)(NSURL *fileURL);

@interface MESoundsDownloader : NSObject

+ (instancetype)shareMusicDownloader;


/**
 根据链接下载MP3文件

 @param url 下载连接
 @param progress 下载进度回调<会调用多次>
 @param completion 下载完成的回调
 */
- (void)downloadSoundWithURL:(NSString *)url withDownloadProgress:(DownloadProgressCallback)progress downloadCompletion:(DownloadCompletion)completion;

/** 获取本地歌曲信息 */
- (LocalSoundsInfo *)getLocalSoundsInfo;

@end

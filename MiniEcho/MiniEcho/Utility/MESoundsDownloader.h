//
//  MESoundsDownloader.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/22.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LocalSoundsInfo, PMRootModel;

typedef void(^DownloadProgressCallback)(float progress);
typedef void(^DownloadCompletion)(BOOL flag);

@interface MESoundsDownloader : NSObject

+ (instancetype)shareMusicDownloader;


/**
 根据链接下载MP3文件

 @param model sound model
 @param progress 下载进度回调<会调用多次>
 @param completion 下载完成的回调
 */
- (void)downloadSoundWithModel:(PMRootModel *)model withDownloadProgress:(DownloadProgressCallback)progress downloadCompletion:(DownloadCompletion)completion;

/** 获取本地歌曲信息 */
- (LocalSoundsInfo *)getLocalSoundsInfo;

@end

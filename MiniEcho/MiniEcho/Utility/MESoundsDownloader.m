//
//  MESoundsDownloader.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/22.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MESoundsDownloader.h"
#import "LocalSoundsInfo.h"
#import "PMRootModel.h"
#import "MELocalSound.h"
#import <Realm/Realm.h>

static NSString *localMusicDirectory = @"/LocalMusic";

@interface MESoundsDownloader ()<NSURLSessionDownloadDelegate>


@property (nonatomic, copy) NSString *musicPath;

@property (nonatomic, strong) PMRootModel *currentSound;

@property (nonatomic, copy) DownloadCompletion completion;

@property (nonatomic, copy) DownloadProgressCallback progressCallback;

@end

@implementation MESoundsDownloader

+ (instancetype)shareMusicDownloader
{
    static MESoundsDownloader *downloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloader = [[MESoundsDownloader alloc] init];
    });
    return downloader;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *musicPath = [cachePath stringByAppendingPathComponent:localMusicDirectory];
        
        // 创建存放本地音乐的文件夹
        if (![[NSFileManager defaultManager] fileExistsAtPath:musicPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:musicPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        _musicPath = musicPath;
    }
    return self;
}

- (void)downloadSoundWithModel:(PMRootModel *)model withDownloadProgress:(DownloadProgressCallback)progress downloadCompletion:(DownloadCompletion)completion
{
    _currentSound = model;
    _progressCallback =  progress;
    _completion = completion;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    NSURL *URL = [NSURL URLWithString:model.source];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:URL];
    
    [task resume];
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error && _completion) {
        NSLog(@"下载出现错误:%@",error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _completion(NO);
        });
    }
}

// 断点下载会使用, 暂时对我们没用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 * 每当写入数据到临时文件时，就会调用一次这个方法
 * totalBytesExpectedToWrite:总大小
 * totalBytesWritten: 已经写入的大小
 * bytesWritten: 这次写入多少
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //    NSLog(@"--------%f", 1.0 * totalBytesWritten / totalBytesExpectedToWrite);
    float progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    if (_progressCallback) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _progressCallback(progress);
        });
    }
}

/**
 *
 * 下载完毕就会调用一次这个方法
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString *musicDirectory = [NSString stringWithFormat:@"%@/", _musicPath];
    NSString *destinationPath = [musicDirectory stringByAppendingString:downloadTask.response.suggestedFilename];
    
    NSLog(@"file path: %@",destinationPath);
    
    // 剪切location的临时文件到真实路径
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSURL *localURL = [NSURL fileURLWithPath:destinationPath];
    [mgr moveItemAtURL:location toURL:localURL error:nil];
    
    LocalSoundsInfo *info = [self getLocalSoundsInfo];
    [info.soundsInfo setObject:localURL forKey:_currentSound.source];
    info.totalSoundsCount = info.soundsInfo.count;
    [self saveLocalSoundsInfoWith:info];
    
    MELocalSound *localSound = [MELocalSound localSoundWithModel:_currentSound];
    // 数据持久化操作十分简单
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:localSound];
    }];
    NSLog(@"realm path-%@",[RLMRealmConfiguration defaultConfiguration].fileURL.absoluteString);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _completion(YES);
    });
}

- (LocalSoundsInfo *)getLocalSoundsInfo
{
    LocalSoundsInfo *info = [NSKeyedUnarchiver unarchiveObjectWithFile:MESoundsInfoFileName];
    if (!info) {
        info = [[LocalSoundsInfo alloc] init];
    }
    return info;
}

- (void)saveLocalSoundsInfoWith:(LocalSoundsInfo *)info
{
    if (info) {
        [NSKeyedArchiver archiveRootObject:info toFile:MESoundsInfoFileName];
    }
}

@end

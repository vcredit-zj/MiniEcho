//
//  LocalSoundsInfo.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/22.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalSoundsInfo : NSObject<NSCoding>

/** 本地歌曲信息字典<key:歌曲链接, value:歌曲的本地路径> */
@property (nonatomic, strong) NSMutableDictionary *soundsInfo;

/** 本地歌曲总数 */
@property (nonatomic, assign) NSInteger totalSoundsCount;

@end

//
//  MELocalSound.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/22.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <Realm/Realm.h>
#import <Foundation/Foundation.h>
@class PMRootModel;

@interface MELocalSound : RLMObject

/** id */
@property NSString *sound_id;

/** 歌曲名称 */
@property NSString *name;

/** 歌曲歌词 */
@property NSString *lyric;

/** 歌手 */
@property NSString *singer;

/** 在线音乐链接 */
@property NSString *source;

+ (instancetype)localSoundWithModel:(PMRootModel *)model;

@end

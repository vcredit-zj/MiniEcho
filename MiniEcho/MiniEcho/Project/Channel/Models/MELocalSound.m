//
//  MELocalSound.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/22.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MELocalSound.h"
#import "PMRootModel.h"
#import "MEUser.h"

@implementation MELocalSound

+ (instancetype)localSoundWithModel:(PMRootModel *)model
{
    MELocalSound *sound = [[MELocalSound alloc] init];
    sound.sound_id = model.soundID;
    sound.name = model.name;
    sound.singer = model.user.name;
    sound.source = model.source;
    return sound;
}

@end

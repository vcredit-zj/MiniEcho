//
//  PMSoundCollectionCell.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "PMSoundCollectionCell.h"

@implementation PMSoundCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSound:(PMSimilarSubSound *)sound
{
    _sound = sound;
    
    [_posterImage sd_setImageWithURL:[NSURL URLWithString:_sound.pic_200]];
    _namelabel.text = _sound.name;
    _countLabel.text = _sound.like_count;
}

@end

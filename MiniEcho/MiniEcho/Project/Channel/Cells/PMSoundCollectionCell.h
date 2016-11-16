//
//  PMSoundCollectionCell.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.

/**
 *  播放音乐的界面的歌曲cell
 */
#import <UIKit/UIKit.h>
#import "PMSimilarSubSound.h"

@interface PMSoundCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (nonatomic, strong) PMSimilarSubSound *sound;


@end

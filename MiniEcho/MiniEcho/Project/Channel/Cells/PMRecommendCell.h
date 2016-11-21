//
//  PMRecommendCell.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.

/**
 *  播放音乐界面推荐歌曲cell
 */
#import <UIKit/UIKit.h>
#import "PMSimilarSubSound.h"

@protocol PMRecommendCellDelegate <NSObject>

- (void)didTapSoundWithID:(NSString *)sound_id;

@end

@interface PMRecommendCell : UITableViewCell


@property (nonatomic, copy) NSArray *sounds;

@property (nonatomic, weak) id <PMRecommendCellDelegate> delegate;


@end

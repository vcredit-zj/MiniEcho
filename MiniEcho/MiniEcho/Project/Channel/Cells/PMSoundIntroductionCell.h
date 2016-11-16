//
//  PMSoundIntroductionCell.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.


/**
 *  播放音乐界面回声简介cell
 */
#import <UIKit/UIKit.h>

@interface PMSoundIntroductionCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lyricLabel;


@property (nonatomic, copy) NSString *lyric;



@end

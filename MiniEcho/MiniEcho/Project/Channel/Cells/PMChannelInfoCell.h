//
//  PMChannelInfoCell.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.


/**
 *  播放音乐界面所属cell
 */
#import <UIKit/UIKit.h>
#import "PMChannel.h"

@interface PMChannelInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *channelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *channelDescLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *posterImageWidthCons;

@property (nonatomic, strong) PMChannel *channel;

@end

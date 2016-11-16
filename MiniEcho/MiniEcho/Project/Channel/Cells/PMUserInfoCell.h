//
//  PMUserInfoCell.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.


/**
 *  播放音乐界面用户信息cell <height:70.f>
 */
#import <UIKit/UIKit.h>
@class MEUser;

@interface PMUserInfoCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *uploadAuthorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatorImage;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@property (nonatomic, strong) MEUser *user;

@end

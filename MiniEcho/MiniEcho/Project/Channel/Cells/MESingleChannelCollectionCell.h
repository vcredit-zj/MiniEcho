//
//  MESingleChannelCollectionCell.h
//  MiniEcho
//
//  Created by vcredit on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *MESingleChannelCollectionCellID;
@class MESingleChannelSounds;
@interface MESingleChannelCollectionCell : UICollectionViewCell
@property (nonatomic,strong) MESingleChannelSounds *model;
@end

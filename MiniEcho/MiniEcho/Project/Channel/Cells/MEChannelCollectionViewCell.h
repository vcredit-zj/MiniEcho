//
//  MEChannelCollectionViewCell.h
//  MiniEcho
//
//  Created by vcredit on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEChannelHotData.h"
extern NSString *MEChannelCollectionViewCellID;
@interface MEChannelCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) MEChannelHotData *model;
@end

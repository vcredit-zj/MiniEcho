//
//  MEchannelCollectionViewAnotherCell.h
//  MiniEcho
//
//  Created by vcredit on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MEChannelCategrayData;
extern NSString *MEchannelCollectionViewAnotherCellID;

typedef void(^CallBackBlock)(MEChannelCategrayData *model);
@interface MEchannelCollectionViewAnotherCell : UICollectionViewCell

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic, copy) CallBackBlock callBcak;
@end

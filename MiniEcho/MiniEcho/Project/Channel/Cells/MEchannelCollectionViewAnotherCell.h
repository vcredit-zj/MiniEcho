//
//  MEchannelCollectionViewAnotherCell.h
//  MiniEcho
//
//  Created by vcredit on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MEChannelCategrayChildren;
extern NSString *MEchannelCollectionViewAnotherCellID;

typedef void(^CallBackBlock)(MEChannelCategrayChildren *model);
@interface MEchannelCollectionViewAnotherCell : UICollectionViewCell

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic, copy) CallBackBlock callBcak;
@end

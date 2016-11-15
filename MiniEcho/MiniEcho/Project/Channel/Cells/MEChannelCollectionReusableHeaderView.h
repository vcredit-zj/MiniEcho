//
//  MEChannelCollectionReusableHeaderView.h
//  MiniEcho
//
//  Created by vcredit on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderModel : NSObject
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@end
typedef void(^CallBackBlock)(NSInteger index);
@interface MEChannelCollectionReusableHeaderView : UICollectionReusableView
+ (UINib *)nib;

@property (nonatomic,strong) HeaderModel *model;
@property (nonatomic, copy) CallBackBlock callBcak;
@end

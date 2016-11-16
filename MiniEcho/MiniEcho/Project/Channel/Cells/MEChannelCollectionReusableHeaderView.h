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

@interface MEChannelCollectionReusableHeaderView : UICollectionReusableView
+ (UINib *)nib;

@end

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
<<<<<<< HEAD

@interface MEChannelCollectionReusableHeaderView : UICollectionReusableView
+ (UINib *)nib;

@property (nonatomic,strong) HeaderModel *model;

=======
@interface MEChannelCollectionReusableHeaderView : UICollectionReusableView
+ (UINib *)nib;

@property (nonatomic,strong) HeaderModel *model; 
>>>>>>> 27f33c8f06a8f634ae67f488f446558e8d7eca67
@end

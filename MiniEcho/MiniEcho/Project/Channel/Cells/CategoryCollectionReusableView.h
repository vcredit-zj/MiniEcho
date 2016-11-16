//
//  CategoryCollectionReusableView.h
//  MiniEcho
//
//  Created by 潘杨东 on 2016/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MEChannelCategrayData;
typedef void(^CategoryCollectionDidSelectedBlock)(NSString *buttonTag);

@interface CategoryCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) CategoryCollectionDidSelectedBlock block;

@property (nonatomic, strong) NSMutableArray <NSString*>*array;

@property (nonatomic, strong) MEChannelCategrayData *model;

@end

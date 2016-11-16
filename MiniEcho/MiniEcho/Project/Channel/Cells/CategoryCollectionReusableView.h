//
//  CategoryCollectionReusableView.h
//  MiniEcho
//
//  Created by 潘杨东 on 2016/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CategoryCollectionDidSelectedBlock)(void);

@interface CategoryCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) CategoryCollectionDidSelectedBlock block;

@end

//
//  YYTagListView.h
//  YYTagViewDemo
//
//  Created by 胡阳 on 2016/11/20.
//  Copyright © 2016年 young4ever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "YYTagViewLayout.h"

@protocol YYTagListViewDelegate <NSObject>

@optional
- (void)didSelectedTagAtIndex:(NSInteger)index;

@end

@interface YYTagListView : UIView

/** 代理 */
@property (nonatomic, weak) id <YYTagListViewDelegate> delegate;

/** 颜色 */
@property (nonatomic, strong) UIColor *tintColor; 

/** 圆角 */
@property (nonatomic, assign) CGFloat radius;

- (instancetype)initWithFrame:(CGRect)frame WithLayout:(YYTagViewLayout *)layout;

- (void)addYYTags:(NSArray *)tags;

@end

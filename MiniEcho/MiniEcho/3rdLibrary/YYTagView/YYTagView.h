//
//  YYTagView.h
//  YYTagViewDemo
//
//  Created by 胡阳 on 2016/11/20.
//  Copyright © 2016年 young4ever. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonAction)(NSInteger index);

@interface YYTagView : UIView

/** 标题 */
@property (nonatomic,   copy) NSString *title;

/** 标题字体颜色 */
@property (nonatomic, strong) UIColor *titleColor;

/** 标题字体大小 */
@property (nonatomic, assign) CGFloat fontSize;

/** 事件回调 */
@property (nonatomic,   copy) ButtonAction action;

/** 圆角大小 */
@property (nonatomic, assign) CGFloat radius;

/** 索引 */
@property (nonatomic, assign) NSInteger index;

@end

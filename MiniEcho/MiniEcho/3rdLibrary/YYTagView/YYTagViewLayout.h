//
//  YYTagViewLayout.h
//  YYTagViewDemo
//
//  Created by 胡阳 on 2016/11/20.
//  Copyright © 2016年 young4ever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface YYTagViewLayout : NSObject

/** 内边距 */
@property (nonatomic, assign) UIEdgeInsets contentInset;

/** 标签高度 */
@property (nonatomic, assign) CGFloat      itemHeight;

/** 标签之间的纵向间距 */
@property (nonatomic, assign) CGFloat      verticalSpace;

/** 标签之间的横向间距 */
@property (nonatomic, assign) CGFloat      horizontalSpace;


+ (instancetype)layoutWithInset:(UIEdgeInsets)contentInset
                     itemHeight:(CGFloat)itemHeight
                  verticalSpace:(CGFloat)verticalSpace
                horizontalSpace:(CGFloat)horizontalSpace;

@end

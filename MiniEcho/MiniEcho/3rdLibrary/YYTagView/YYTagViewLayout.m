//
//  YYTagViewLayout.m
//  YYTagViewDemo
//
//  Created by 胡阳 on 2016/11/20.
//  Copyright © 2016年 young4ever. All rights reserved.
//

#import "YYTagViewLayout.h"

@implementation YYTagViewLayout

+ (instancetype)layoutWithInset:(UIEdgeInsets)contentInset itemHeight:(CGFloat)itemHeight verticalSpace:(CGFloat)verticalSpace horizontalSpace:(CGFloat)horizontalSpace
{
    YYTagViewLayout *layout = [YYTagViewLayout new];
    layout.contentInset = contentInset;
    layout.itemHeight = itemHeight;
    layout.verticalSpace = verticalSpace;
    layout.horizontalSpace = horizontalSpace;
    return layout;
}

@end

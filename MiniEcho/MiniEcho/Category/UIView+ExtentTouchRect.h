//
//  UIView+ExtentTouchRect.h
//  StarCredit
//
//  Created by 胡阳 on 16/4/18.
//  Copyright © 2016年 VCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ExtentTouchRect)

/**
 *  负值表示扩大点击区域, 例如: UIEdgeInsetsMake(-10, -10, -10, -10)
 *  正值表示缩小点击区域, 例如: UIEdgeInsetsMake(5, 5, 5, 5)
 */
@property (nonatomic) UIEdgeInsets touchExtendInset;

@end

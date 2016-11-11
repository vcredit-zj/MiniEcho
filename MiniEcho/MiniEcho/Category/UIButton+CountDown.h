//
//  UIButton+countDown.h
//  NetworkEgOc
//
//  Created by iosdev on 15/3/17.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)

/**
 *  创建一个倒计时功能的button
 *
 *  @param timeout     倒计时时间<单位: 秒>
 *  @param title       title
 *  @param waitTitle   计时的时候的副标题<秒>
 *  @param normalColor 正常的背景色
 *  @param enableColor 倒计时状态时的背景色
 */
- (void)startTime:(NSInteger)timeout
            title:(NSString *)title
        waitTitle:(NSString *)waitTitle
      normalColor:(UIColor *)normalColor
        waitColor:(UIColor *)waitColor ;

/**
 *  创建一个倒计时功能的button
 *
 *  @param timeout     倒计时时间<单位: 秒>
 *  @param title       按钮正常标题
 *  @param prefix      按钮等待标题前缀
 *  @param suffix      按钮等待标题后缀
 *  @param normalColor 按钮正常标题颜色
 *  @param waitColor   按钮等待标题颜色
 */
- (void)cp_startTime:(NSInteger)timeout
               title:(NSString *)title
     waitTitlePrefix:(NSString *)prefix
     waitTitleSuffix:(NSString *)suffix
    normalTitleColor:(UIColor *)normalColor
      waitTitleColor:(UIColor *)waitColor;

/**
 *  快速创建有高亮颜色button
 *
 *  @param title            标题
 *  @param disableColor     不可点击的状态颜色
 *  @param normalColor      背景颜色
 *  @param heightLightColor 高亮颜色
 *  @param radius           圆角大小<不需要设置圆角给个负数即可>
 */
//+ (instancetype)buttonWithTitle:(NSString *)title
//                   disableColor:(UIColor *)disableColor
//                    normalColor:(UIColor *)normalColor
//               heightLightColor:(UIColor *)heightLightColor
//                   cornerRadius:(CGFloat)radius ;

@end

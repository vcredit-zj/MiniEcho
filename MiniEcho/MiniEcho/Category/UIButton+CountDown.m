//
//  UIButton+countDown.m
//  NetworkEgOc
//
//  Created by iosdev on 15/3/17.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

#import "UIButton+countDown.h"

@implementation UIButton (countDown)

/**
 *  倒计时 UIButton
 */
- (void)startTime:(NSInteger)timeout
            title:(NSString *)title
        waitTitle:(NSString *)waitTitle
      normalColor:(UIColor *)normalColor
        waitColor:(UIColor *)waitColor
{
    __block NSInteger time = timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setBackgroundColor:normalColor];
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }
        else {
            int seconds = time % ((int)timeout + 1);
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setBackgroundColor:waitColor];
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            time --;
        }
    });
    dispatch_resume(_timer);
    
    // 取消timer
    //    dispatch_source_cancel(_timer) ;
}

- (void)cp_startTime:(NSInteger)timeout title:(NSString *)title waitTitlePrefix:(NSString *)prefix waitTitleSuffix:(NSString *)suffix normalTitleColor:(UIColor *)normalColor waitTitleColor:(UIColor *)waitColor
{
    __block NSInteger time = timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitleColor:normalColor forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }
        else {
            int seconds = time % ((int)timeout + 1);
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitleColor:waitColor forState:UIControlStateNormal];
                [self setTitle:[NSString stringWithFormat:@"%@%@%@",prefix,strTime,suffix] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            time --;
        }
    });
    dispatch_resume(_timer);
}

//+ (instancetype)buttonWithTitle:(NSString *)title
//                   disableColor:(UIColor *)disableColor
//                    normalColor:(UIColor *)normalColor
//               heightLightColor:(UIColor *)heightLightColor
//                   cornerRadius:(CGFloat)radius
//{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    if (radius > 0.0) {
//        btn.layer.cornerRadius = radius;
//        btn.clipsToBounds = YES;
//    }
//    
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
//    [btn setBackgroundImage:[CPUtil imageWithColor:normalColor] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[CPUtil imageWithColor:disableColor] forState:UIControlStateDisabled];
//    [btn setBackgroundImage:[CPUtil imageWithColor:heightLightColor] forState:UIControlStateHighlighted];
//    
//    return btn;
//}

@end

//
//  UIBarButtonItem+Action.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BarButtonActionBlock)();

@interface UIBarButtonItem (Action)

/// A block that is run when the UIBarButtonItem is tapped.
//@property (nonatomic, copy) dispatch_block_t actionBlock;
- (void)setActionBlock:(BarButtonActionBlock)actionBlock;

+ (instancetype)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action;

/**
 *  快速创建纯文字的UIBarButtonItem
 *
 *  @param title  标题 
 */
+ (instancetype)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end

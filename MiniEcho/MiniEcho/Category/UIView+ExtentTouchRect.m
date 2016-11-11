//
//  UIView+ExtentTouchRect.m
//  StarCredit
//
//  Created by 胡阳 on 16/4/18.
//  Copyright © 2016年 VCredit. All rights reserved.
//

#import "UIView+ExtentTouchRect.h"
#import <objc/runtime.h>

/**
 *  苹果的黑魔法<Swizzle 交换方法>
 *
 *  @param c    类
 *  @param orig 系统原本自带的方法
 *  @param new  自己重写的新方法
 */
void Swizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

@implementation UIView (ExtentTouchRect)

+ (void)load
{
    // 交换方法
    Swizzle(self, @selector(pointInside:withEvent:), @selector(myPointInside:withEvent:));
}

/**
 *  自己写的新方法
 */
- (BOOL)myPointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.touchExtendInset, UIEdgeInsetsZero) || self.hidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled)) {
        return [self myPointInside:point withEvent:event]; // original implementation
    }
    
    /*
     UIKIT_STATIC_INLINE CGRect UIEdgeInsetsInsetRect(CGRect rect, UIEdgeInsets insets) {
         rect.origin.x    += insets.left;
         rect.origin.y    += insets.top;
         rect.size.width  -= (insets.left + insets.right);
         rect.size.height -= (insets.top  + insets.bottom);
         return rect;
     }
     
     故:传入正值为缩小点击区域, 负值为扩大点击区域
     */
    
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.touchExtendInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0); // don't allow negative sizes
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

static char touchExtendInsetKey;
/**
 *  setter
 */
- (void)setTouchExtendInset:(UIEdgeInsets)touchExtendInset
{
    objc_setAssociatedObject(self, &touchExtendInsetKey, [NSValue valueWithUIEdgeInsets:touchExtendInset],
                             OBJC_ASSOCIATION_RETAIN);
}
/**
 *  getter
 */
- (UIEdgeInsets)touchExtendInset
{
    return [objc_getAssociatedObject(self, &touchExtendInsetKey) UIEdgeInsetsValue];
}

@end

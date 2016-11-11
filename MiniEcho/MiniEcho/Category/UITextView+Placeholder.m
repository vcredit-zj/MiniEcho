//
//  UITextView+Placeholder.m
//  YYTextViewDemo
//
//  Created by 胡阳 on 16/4/20.
//  Copyright © 2016年 young4ever. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

static char * placeholderKey = "_placeholderKey";
static char * placeholderLabelKey = "_placeholderLabelKey";

static const CGFloat labelHorizontalGap = 15.f ; // 左右两边的间距之和
static const CGFloat labelLeftPadding = 15.f ;   // 左间距
static const CGFloat labelTopPadding = 15.f ;     // 上间距
static const CGFloat labelHeight = 25.f ;        // 高度

@interface UITextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation UITextView (Placeholder)

#pragma mark - setter & getter

/**
 *  getter
 */
- (NSString *)placeholder
{
    return objc_getAssociatedObject(self, placeholderKey) ;
}

/**
 *  setter
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    self.placeholderLabel.text = placeholder ;
    self.placeholderLabel.hidden = NO ;
    objc_setAssociatedObject(self, placeholderKey, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC) ;
}

- (UILabel *)placeholderLabel
{
    UILabel *label = objc_getAssociatedObject(self, placeholderLabelKey) ;
    
    if (label == nil) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yy_textViewDidBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yy_textViewDidEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yy_textViewDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
        CGRect frame = CGRectMake(labelLeftPadding, labelTopPadding, self.bounds.size.width - labelHorizontalGap, labelHeight);
        label = [[UILabel alloc] initWithFrame:frame];
        label.font = self.font ;
        label.textColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft ;
        [self addSubview:label];
        objc_setAssociatedObject(self, placeholderLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return label ;
}

#pragma mark - NSNotification methods
- (void)yy_textViewDidBeginEditing
{
    self.placeholderLabel.hidden = YES ;
}
- (void)yy_textViewDidEndEditing
{
    if (self.text.length > 0 ) {
        self.placeholderLabel.hidden = YES ;
    }else{
        self.placeholderLabel.hidden = NO ;
    }
}
- (void)yy_textViewDidChange
{
    if ([self.text isEqualToString:@""]) {
        self.placeholderLabel.hidden = NO ;
    }else if (self.text.length > 0){
        self.placeholderLabel.hidden = YES ;
    }
}
#pragma mark - dealloc (remove self from NSNotificationCenter)
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

//
//  MEUtil.h
//  MiniEcho
//
//  Created by vcredit on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MEUtil : NSObject
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (CGFloat)widthForSingleLineText:(NSString *)text fontSize:(CGFloat)font ;

+ (CGFloat)heightForText:(NSString *)text fontSize:(CGFloat)font constrainedWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

+ (CGFloat)heightForAttributedString:(NSAttributedString *)string constrainedWidth:(CGFloat)width;

+ (NSString*)md5String:(NSString *)str;
@end

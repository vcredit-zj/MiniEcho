//
//  MEUtil.m
//  MiniEcho
//
//  Created by vcredit on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEUtil.h"

@implementation MEUtil
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.f, 1.f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (CGFloat)widthForSingleLineText:(NSString *)text fontSize:(CGFloat)font
{
    NSAssert(text.length > 0, @"被计算的文本不能为空");
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 40.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return ceilf(textRect.size.width);
}
@end

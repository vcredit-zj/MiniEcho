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

+ (CGFloat)heightForText:(NSString *)text fontSize:(CGFloat)font constrainedWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragraphStyle};
    CGRect boundingRect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    CGSize textSize = CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    return textSize.height;
}

+ (CGFloat)heightForAttributedString:(NSAttributedString *)string constrainedWidth:(CGFloat)width
{
    CGSize constrainedSize = CGSizeMake(width, MAXFLOAT);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:constrainedSize text:string];
    return layout.textBoundingSize.height;
}

@end

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
@end

//
//  MEMacros.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#ifndef MEMacros_h
#define MEMacros_h


// 屏幕相关
#define kAppWindow      [UIApplication sharedApplication].keyWindow
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenBounds   [UIScreen mainScreen].bounds


// 自定义log日志
#ifdef DEBUG
#define MEString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define DLog(...) printf("%s 第%d行: %s\n\n", [MEString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define DLog(...) do { } while (0)
#endif

#define kLogFunction  CPLog(@"%s",__FUNCTION__);


#endif /* MEMacros_h */

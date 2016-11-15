//
//  MEHttpUtil.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/14.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEHttpUtil : NSObject


/**
 *  get 请求
 *
 *  @param URLString 请求链接
 *  @param params    请求参数
 *  @param yesOrNo   是否需要显示loadingView
 *  @param success   成功的回调
 *  @param failure   失败的回调
 */
+ (void)get:(NSString *)URLString parameters:(id)params showLoading:(BOOL)yesOrNo success:(void(^)(id result))success failure:(void (^)(NSError *error))failure ;

/**
 *  get 请求
 *
 *  @param URLString 请求链接
 *  @param params    请求参数 
 *  @param success   成功的回调
 *  @param failure   失败的回调
 */
+ (void)get:(NSString *)URLString parameters:(id)params success:(void(^)(id result))success failure:(void (^)(NSError *error))failure ;


@end

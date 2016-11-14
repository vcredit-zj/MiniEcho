//
//  MEResult.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/14.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEResult : NSObject

/** 状态码 */
@property (nonatomic, assign) NSInteger    state;

/** 响应信息 */
@property (nonatomic,   copy) NSString     *message;

/** 响应内容 */
@property (nonatomic,   copy) NSDictionary *result;



@end

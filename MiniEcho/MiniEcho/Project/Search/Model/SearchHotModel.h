//
//  SearchHotModel.h
//  MiniEcho
//
//  Created by ALittleNasty on 2016/11/25.
//  Copyright © 2016年 vcredit. All rights reserved.

/**
 *  热门搜索的标签模型
 */
#import <Foundation/Foundation.h>

@interface SearchHotModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *type;



@end

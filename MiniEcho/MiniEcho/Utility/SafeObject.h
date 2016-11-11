//
//  SafeObject.h
//  CP
//
//  Created by vcredit on 16/9/19.
//  Copyright © 2016年 VCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

//-----------------------------------------------------
//-----------------------------------------------------

@interface NSArray(SafeObject)

//NSArray objectAtIndex:的安全方法，避免数组越界造成的崩溃
- (id)safeObjectAtIndex:(NSInteger)index;

@end

//-----------------------------------------------------
//-----------------------------------------------------

@interface NSMutableArray(SafeObject)

//NSMutableArray addObject:的安全方法，避免anObject为nil时造成的崩溃
- (void)safeAddObject:(id)anObject;

//NSMutableArray insertObject:atIndex:的安全方法，避免index越界以及anObject为nil时造成的崩溃
- (void)safeInsertObject:(id)anObject atIndex:(NSInteger)index;

//NSMutableArray removeObjectAtIndex:的安全方法，避免数组越界造成的崩溃
- (void)safeRemoveObjectAtIndex:(NSInteger)index;

//NSMutableArray replaceObjectAtIndex:withObject:的安全方法，避免index越界以及anObject为nil时造成的崩溃
- (void)safeReplaceObjectAtIndex:(NSInteger)index withObject:(id)anObject;

@end

//-----------------------------------------------------
//-----------------------------------------------------

@interface NSDictionary(SafeObject)

//空值返回@""
- (NSString *)stringObjectForKey:(id <NSCopying>)key;

//空值返回nil
- (id)safeJsonObjectForKey:(id <NSCopying>)key;

@end

//-----------------------------------------------------
//-----------------------------------------------------

@interface NSMutableDictionary(SafeObject)

//NSMutableDictionary setObject:forKey:的安全方法，避免anObject或aKey为nil时造成的崩溃
- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end

//-----------------------------------------------------
//-----------------------------------------------------


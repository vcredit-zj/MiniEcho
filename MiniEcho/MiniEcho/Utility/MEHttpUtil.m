//
//  MEHttpUtil.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/14.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEHttpUtil.h"
#import "MEResult.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <AdSupport/AdSupport.h> // 系统自带的广告库头文件


@implementation MEHttpUtil

+ (void)get:(NSString *)URLString parameters:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self get:URLString parameters:params showLoading:NO success:success failure:failure];
}

+ (void)get:(NSString *)URLString parameters:(id)params showLoading:(BOOL)yesOrNo success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self defaultManager] ;
    
    NSString *finalURL = [NSString stringWithFormat:@"%@%@",EchoDomain,URLString] ;
    
    if (yesOrNo) {
        [SVProgressHUD show];
    }
    
    [manager GET:finalURL parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (yesOrNo) {
            [SVProgressHUD dismiss];
        }
        
        MEResult *result = [MEResult mj_objectWithKeyValues:responseObject];
        if (result.state == 1) {
            success(result.result);
        } else {
            NSError *error = [NSError errorWithDomain:@"https://miniecho.com" code:-99 userInfo:nil];
            failure(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (yesOrNo) {
            [SVProgressHUD dismiss];
        }
        failure(error);
    }];
}


/**
 * AFHTTPSessionManager 默认配置
 */
+ (AFHTTPSessionManager *)defaultManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = 60.0;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *ua = [NSString stringWithFormat:@"echo ios 5.8 2016111903;(iPhone,iPhone OS10.0.2);IDFA %@;",idfa];
    
//    NSString *ua = @"echo ios 5.8 2016111903;(iPhone,iPhone OS10.0.2);IDFA F0A81261-96A9-4370-BD1B-E98C88B6D7EA";
//    [manager.requestSerializer setValue:@"echo ios 5.7.3 2016102902;" forHTTPHeaderField:@"User-Agent"];
     [manager.requestSerializer setValue:ua forHTTPHeaderField:@"User-Agent"];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone] ;
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml"]];
    
    return manager ;
}

@end

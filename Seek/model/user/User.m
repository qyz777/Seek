//
//  User.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/13.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "User.h"
#import <AFNetworking.h>
#import "NSString+Custom.h"

@implementation User

// 单例
YZ_SINGLETON(User, user);

+ (void)stashToken:(NSString *)token {
    [USER_DEFAULT setObject:token forKey:tokenKey];
    [USER_DEFAULT synchronize];
}

+ (NSString *)token {
    return [USER_DEFAULT objectForKey:tokenKey];
}

+ (void)stashTimestamp:(NSTimeInterval)time {
    [USER_DEFAULT setObject:[NSNumber numberWithDouble:time] forKey:timestampKey];
    [USER_DEFAULT synchronize];
}

+ (NSTimeInterval)timestamp {
    NSNumber *number = [USER_DEFAULT objectForKey:timestampKey];
    return [number doubleValue];
}

+ (void)userRegisterWithPhone:(NSString*)phone
                     Password:(NSString*)psd
                      success:(void(^)(void))success
                      failure:(void(^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/User/register";
    psd = [psd MD5];
    psd = [psd MD5];
    NSDictionary *parameters = @{@"phone":phone, @"password": psd};
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        int code = [json[@"code"] intValue];
        if (code == 0) {
            User *user = [User sharedUser];
            user.phone = phone;
            user.password = psd;
            NSDictionary *data = json[@"data"];
            user.userId = [data[@"id"] integerValue];
            user.token = data[@"token"];
            NSNumber *t = data[@"time"];
            user.timestamp = [t doubleValue];
            [User stashToken:data[@"token"]];
            [User stashTimestamp:[t doubleValue]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)loginWithPhone:(NSString*)phone
              Password:(NSString*)psd
               success:(void(^)(void))success
               failure:(void(^)(NSError* error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/User/login";
    psd = [psd MD5];
    psd = [psd MD5];
    NSDictionary *parameters = @{@"phone":phone, @"password": psd};
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        int code = [json[@"code"] intValue];
        if (code == 0) {
            User *user = [User sharedUser];
            user.phone = phone;
            user.password = psd;
            NSDictionary *data = json[@"data"];
            user.userId = [data[@"id"] integerValue];
            user.token = data[@"token"];
            NSNumber *t = data[@"time"];
            user.timestamp = [t doubleValue];
            [User stashToken:data[@"token"]];
            [User stashTimestamp:[t doubleValue]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end

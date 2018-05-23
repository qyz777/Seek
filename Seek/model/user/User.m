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

static NSString *tokenKey = @"token";
static NSString *phoneKey = @"phone";
static NSString *passwordKey = @"password";
static NSString *timestampKey = @"timestamp";
static NSString *userIdKey = @"userId";

@implementation User

// 单例
YZ_SINGLETON(User, user);

#pragma make - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_token forKey:tokenKey];
    [aCoder encodeObject:_phone forKey:phoneKey];
    [aCoder encodeObject:_password forKey:passwordKey];
    [aCoder encodeDouble:_timestamp forKey:timestampKey];
    [aCoder encodeInteger:_userId forKey:userIdKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [User sharedUser];
    if (self) {
        self.token = [aDecoder decodeObjectForKey:tokenKey];
        self.phone = [aDecoder decodeObjectForKey:phoneKey];
        self.password = [aDecoder decodeObjectForKey:passwordKey];
        self.timestamp = [aDecoder decodeDoubleForKey:timestampKey];
        self.userId = [aDecoder decodeIntegerForKey:userIdKey];
    }
    return self;
}

+ (void)userStash {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.data"];
    [NSKeyedArchiver archiveRootObject:[User sharedUser] toFile:filePath];
}

+ (void)userStashPop {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.data"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        User *user = [User sharedUser];
        user = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
}

+ (void)userRegisterWithPhone:(NSString*)phone
                     Password:(NSString*)psd
                      success:(void(^)(void))success
                      failure:(void(^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/User/register";
    psd = [psd MD5];
    psd = [psd MD5];
    NSDictionary *parameters = @{@"username":phone, @"password": psd};
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
            [User userStash];
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
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/User/login";
    psd = [psd MD5];
    psd = [psd MD5];
    NSDictionary *parameters = @{@"username":phone, @"password": psd};
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
            [User userStash];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)updateLoginWithToken:(NSString *)token
                        time:(NSTimeInterval)time
                     success:(void(^)(void))success
                     failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/User/updateStatus";
    NSDictionary *parameters = @{@"token":token, @"time": @(time)};
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        int code = [json[@"code"] intValue];
        if (code == 0) {
            User *user = [User sharedUser];
            NSDictionary *data = json[@"data"];
            user.userId = [data[@"id"] integerValue];
            user.token = data[@"token"];
            NSNumber *t = data[@"time"];
            user.timestamp = [t doubleValue];
            [User userStash];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end

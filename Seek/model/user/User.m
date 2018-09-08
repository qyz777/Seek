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
static NSString *nickNameKey = @"nickName";
static NSString *timestampKey = @"timestamp";
static NSString *userIdKey = @"userId";
static NSString *expKey = @"exp";
static NSString *needExpKey = @"needExp";
static NSString *rankKey = @"rank";
static NSString *levelKey = @"level";
static NSString *gameCountKey = @"gameCount";
static NSString *winCountKey = @"winCount";

@implementation User

// 单例
YZ_SINGLETON(User, user);

#pragma make - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_token forKey:tokenKey];
    [aCoder encodeObject:_phone forKey:phoneKey];
    [aCoder encodeObject:_password forKey:passwordKey];
    [aCoder encodeObject:_nickName forKey:nickNameKey];
    [aCoder encodeDouble:_timestamp forKey:timestampKey];
    [aCoder encodeInteger:_userId forKey:userIdKey];
    [aCoder encodeInteger:_exp forKey:expKey];
    [aCoder encodeInteger:_needExp forKey:needExpKey];
    [aCoder encodeInteger:_rank forKey:rankKey];
    [aCoder encodeInteger:_level forKey:levelKey];
    [aCoder encodeInteger:_gameCount forKey:gameCountKey];
    [aCoder encodeInteger:_winCount forKey:winCountKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [User sharedUser];
    if (self) {
        self.token = [aDecoder decodeObjectForKey:tokenKey];
        self.phone = [aDecoder decodeObjectForKey:phoneKey];
        self.password = [aDecoder decodeObjectForKey:passwordKey];
        self.nickName = [aDecoder decodeObjectForKey:nickNameKey];
        self.timestamp = [aDecoder decodeDoubleForKey:timestampKey];
        self.userId = [aDecoder decodeIntegerForKey:userIdKey];
        self.exp = [aDecoder decodeIntegerForKey:expKey];
        self.needExp = [aDecoder decodeIntegerForKey:needExpKey];
        self.rank = [aDecoder decodeIntegerForKey:rankKey];
        self.level = [aDecoder decodeIntegerForKey:levelKey];
        self.gameCount = [aDecoder decodeIntegerForKey:gameCountKey];
        self.winCount = [aDecoder decodeIntegerForKey:winCountKey];
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

+ (void)logOut {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.data"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
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
        success();
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
            success();
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
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        int code = [json[@"code"] intValue];
        if (code == 0) {
            User *user = [User sharedUser];
            user.timestamp = time;
            [User userStash];
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)fetchUserDataWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/User/myInfo";
    NSDictionary *parameters = @{@"token": [User sharedUser].token, @"id": @([User sharedUser].userId)};
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        int code = [json[@"code"] intValue];
        if (code == 0) {
            User *user = [User sharedUser];
            NSDictionary *data = json[@"data"];
            user.nickName = data[@"nickname"] ? data[@"nickname"] : @"";
            user.exp = data[@"my_exp"] ? [data[@"my_exp"] integerValue] : 0;
            user.needExp = data[@"up_exp"] ? [data[@"up_exp"] integerValue] : 0;
            user.rank = data[@"dan"] ? [data[@"dan"] integerValue] : 0;
            user.level = data[@"grade"] ? [data[@"grade"] integerValue] : 0;
            user.gameCount = data[@"game_all"] ? [data[@"game_all"] integerValue] : 0;
            user.winCount = data[@"game_win"] ? [data[@"game_win"] integerValue] : 0;
            [User userStash];
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end

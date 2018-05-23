//
//  User.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/13.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *tokenKey = @"user_token";
static NSString *timestampKey = @"user_timestamp";

@interface User : NSObject

@property(nonatomic, strong)NSString *token;
@property(nonatomic, strong)NSString *phone;
@property(nonatomic, strong)NSString *password;
@property(nonatomic, assign)NSTimeInterval timestamp;
@property(nonatomic, assign)NSInteger userId;

+ (instancetype)sharedUser;

// 储存到token
+ (void)stashToken:(NSString *)token;

// 获取token
+ (NSString *)token;

// 储存时间戳
+ (void)stashTimestamp:(NSTimeInterval)time;

// 获取时间戳
+ (NSTimeInterval)timestamp;

/**
 用户注册
 
 @param phone 手机号
 @param psd 密码
 @param success 成功block
 @param failure 失败block
 */
+ (void)userRegisterWithPhone:(NSString *)phone
                     Password:(NSString *)psd
                      success:(void(^)(void))success
                      failure:(void(^)(NSError *error))failure;


/**
 用户登入
 
 @param phone 手机号
 @param psd 密码
 @param success 成功block
 @param failure 失败block
 */
+ (void)loginWithPhone:(NSString*)phone
              Password:(NSString*)psd
               success:(void(^)(void))success
               failure:(void(^)(NSError *error))failure;

@end

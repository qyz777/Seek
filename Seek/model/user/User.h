//
//  User.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/13.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) NSTimeInterval timestamp;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger exp;
@property (nonatomic, assign) NSInteger needExp;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger gameCount;
@property (nonatomic, assign) NSInteger winCount;

+ (instancetype)sharedUser;

// 储存用户信息
+ (void)userStash;

// 获得用户信息
+ (void)userStashPop;

// 退出
+ (void)logOut;

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


/**
 更新用户登入

 @param token token
 @param time 时间戳
 @param success 成功block
 @param failure 失败block
 */
+ (void)updateLoginWithToken:(NSString *)token
                        time:(NSTimeInterval)time
                     success:(void(^)(void))success
                     failure:(void(^)(NSError *error))failure;


+ (void)fetchUserDataWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure;

@end

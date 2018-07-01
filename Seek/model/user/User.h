//
//  User.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/13.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property(nonatomic, strong)NSString *token;
@property(nonatomic, strong)NSString *phone;
@property(nonatomic, strong)NSString *password;
@property(nonatomic, assign)NSTimeInterval timestamp;
@property(nonatomic, assign)NSInteger userId;

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

@end

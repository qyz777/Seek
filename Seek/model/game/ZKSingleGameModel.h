//
//  ZKSingleGameModel.h
//  Seek
//
//  Created by 徐正科 on 2018/5/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKSingleGameModel : NSObject

//获取题库
+ (void)getSingleSystemWithSuccess:(void(^)(NSMutableArray *resArray))success failure:(void(^)(NSError *error))failure;

+ (void)finishGame:(NSString *)type;

@end

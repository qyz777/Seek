//
//  Rank.h
//  Seek
//
//  Created by 徐正科 on 2018/9/10.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rank : NSObject


@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *headimg;


+ (void)getRankWithSuccess:(void(^)(NSMutableDictionary *res))success failure:(void(^)(NSError *error))failure;

@end

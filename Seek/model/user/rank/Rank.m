//
//  Rank.m
//  Seek
//
//  Created by 徐正科 on 2018/9/10.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "Rank.h"

@implementation Rank


+ (void)getRankWithSuccess:(void(^)(NSMutableDictionary *res))success failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://seek-api.xuzhengke.cn/index.php/Api/User/rank" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *res = [(NSDictionary *)responseObject mutableCopy];
        success(res);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end

//
//  ZKSingleGameModel.m
//  Seek
//
//  Created by 徐正科 on 2018/5/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKSingleGameModel.h"
#import <AFNetworking.h>

@implementation ZKSingleGameModel

+ (void)getSingleSystemWithSuccess:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://seek-api.xuzhengke.cn/index.php/Api/Game/singleGame" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject[@"data"]);
        NSMutableArray *resArray = responseObject[@"data"];
        success(resArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end

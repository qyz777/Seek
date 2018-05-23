//
//  YZWord.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZWord.h"
#import <AFNetworking.h>

@implementation YZWord

+ (void)searchWordWithString:(NSString *)str
                     success:(void(^)(NSArray<NSDictionary *> *dataArray))success
                     failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlString = @"http://dict.youdao.com/suggest";
    NSDictionary *parameters = @{@"q": str,@"le": @"eng",@"num": @15,@"doctype": @"json"};
    [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        if (json) {
            NSDictionary *data = json[@"data"];
            success(data[@"entries"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end

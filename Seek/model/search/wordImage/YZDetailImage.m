//
//  YZDetailImage.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/25.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZDetailImage.h"
#import <AFNetworking.h>

@implementation YZDetailImage

+ (void)wordDetailImageSuccess:(void(^)(NSURL *imageUrl))success
                       failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/Common/getBGImage";
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        if (json) {
            NSURL *imageUrl = [NSURL URLWithString:json[@"data"][@"image"]];
            success(imageUrl);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end

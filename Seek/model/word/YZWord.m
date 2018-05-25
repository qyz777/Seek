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

#pragma make - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    YZWord *word = [[YZWord alloc]init];
    word.word = self.word;
    word.sentence = self.sentence;
    word.senTranslate = self.senTranslate;
    word.ukPhone = self.ukPhone;
    word.ukPhoneUrl = self.ukPhoneUrl;
    word.usPhone = self.usPhone;
    word.usPhoneUrl = self.usPhoneUrl;
    word.translate = self.translate;
    word.isLiked = self.isLiked;
    return word;
}

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

+ (void)searchDetailsWithWord:(NSString *)word
                      success:(void(^)(YZWord *yzWord))success
                      failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/Word/wordDetail";
//    NSDictionary *parameters = @{@"word": word, @"user_id": @([User sharedUser].userId)};
    NSDictionary *parameters =  @{@"word": word};
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        if (json) {
            int code = [json[@"code"]intValue];
            if (code == 0) {
                YZWord *dataWord = [YZWord new];
                NSDictionary *data = json[@"data"];
                dataWord.word = data[@"word"];
                dataWord.sentence = [self filterHTML:data[@"sen"]];
                dataWord.senTranslate = data[@"sen_tran"];
                NSDictionary *speech = data[@"speech"];
                NSDictionary *uk = speech[@"uk"];
                NSDictionary *us = speech[@"us"];
                dataWord.ukPhone = uk[@"phone"];
                dataWord.ukPhoneUrl = uk[@"speech"];
                dataWord.usPhone = us[@"phone"];
                dataWord.usPhoneUrl = us[@"speech"];
                dataWord.translate = data[@"trans"];
                if ([json[@"like"]intValue] == 0) {
                    dataWord.isLiked = false;
                }else {
                    dataWord.isLiked = true;
                }
                success(dataWord);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)likeWithWord:(NSString *)word
             success:(void(^)(BOOL isLike))success
             failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/Word/likeWord";
    NSDictionary *parameters = @{@"user_id": @([User sharedUser].userId),@"token": [User sharedUser].token,@"word": word};
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        if (json) {
            int code = [json[@"code"] intValue];
            if (code == 1) {
                success(false);
            }
            if (code == 0) {
                success(true);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)findWordSuccess:(void(^)(NSArray<NSString *> *data))success
                failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://seek-api.xuzhengke.cn/index.php/Api/Word/getTwentyWords";
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
        if (json) {
            success(json[@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma make - 去除HTML标签
+ (NSString *)filterHTML:(NSString *)html {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

@end

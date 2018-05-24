//
//  YZWord.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZWord : NSObject<NSCopying>

@property(nonatomic, strong)NSString *word;
@property(nonatomic, strong)NSString *sentence;
@property(nonatomic, strong)NSString *senTranslate;
@property(nonatomic, strong)NSString *ukPhone;
@property(nonatomic, strong)NSString *usPhone;
@property(nonatomic, strong)NSURL *ukPhoneUrl;
@property(nonatomic, strong)NSURL *usPhoneUrl;
@property(nonatomic, strong)NSArray *translate;
@property(nonatomic, assign)BOOL isLiked;


// 搜索页搜索单词使用
+ (void)searchWordWithString:(NSString *)str
                     success:(void(^)(NSArray<NSDictionary *> *dataArray))success
                     failure:(void(^)(NSError *error))failure;

// 根据单词搜索单词详情
+ (void)searchDetailsWithWord:(NSString *)word
                      success:(void(^)(YZWord *yzWord))success
                      failure:(void(^)(NSError *error))failure;

// 添加或删除单词
+ (void)likeWithWord:(NSString *)word
             success:(void(^)(BOOL isLike))success
             failure:(void(^)(NSError *error))failure;

@end

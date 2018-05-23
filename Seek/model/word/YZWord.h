//
//  YZWord.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZWord : NSObject

@property(nonatomic, strong)NSString *word;
@property(nonatomic, strong)NSString *sentence;
@property(nonatomic, strong)NSString *ukPhone;
@property(nonatomic, strong)NSString *usPhone;
@property(nonatomic, strong)NSURL *ukPhoneUrl;
@property(nonatomic, strong)NSURL *usPhoneUrl;
@property(nonatomic, strong)NSArray *translate;


// 搜索页搜索单词使用
+ (void)searchWordWithString:(NSString *)str
                     success:(void(^)(NSArray<NSDictionary *> *dataArray))success
                     failure:(void(^)(NSError *error))failure;

@end

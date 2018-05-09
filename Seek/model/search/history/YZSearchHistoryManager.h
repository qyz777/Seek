//
//  YZSearchHistoryManager.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZWord.h"

UIKIT_EXTERN NSString * const historyKey;

@interface YZSearchHistoryManager : NSObject

+ (NSArray<YZWord *> *)arrayFromSearchHistory;

+ (void)searchHistoryCacheWithArray:(NSArray<YZWord *> *)array;

+ (void)removeAllSearchHistory;

@end

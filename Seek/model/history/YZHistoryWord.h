//
//  YZHistoryWord.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/23.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZHistoryWord : NSObject

+ (NSMutableArray *)arrayFromSearchHistory;

+ (void)searchHistoryCacheWithArray:(NSArray<NSDictionary *> *)array;

+ (void)removeAllSearchHistory;


@end

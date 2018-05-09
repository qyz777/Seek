//
//  YZSearchHistoryManager.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZSearchHistoryManager.h"

NSString * const historyKey = @"searchHistory";

@implementation YZSearchHistoryManager

+ (NSArray<YZWord *> *)arrayFromSearchHistory{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:historyKey];
    return array;
}

+ (void)searchHistoryCacheWithArray:(NSArray<YZWord *> *)array{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i++){
        if ([categoryArray containsObject:[array objectAtIndex:i]] == false){
            [categoryArray addObject:[array objectAtIndex:i]];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:categoryArray.copy forKey:historyKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeAllSearchHistory{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:historyKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

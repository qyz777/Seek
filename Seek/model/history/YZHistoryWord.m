//
//  YZHistoryWord.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/23.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZHistoryWord.h"

static NSString *const historyWordKey = @"historyWordKey";

@implementation YZHistoryWord

+ (NSMutableArray *)arrayFromSearchHistory {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:historyWordKey];
    return array.mutableCopy;
}

+ (void)searchHistoryCacheWithArray:(NSArray<NSDictionary *> *)array {
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:historyWordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeAllSearchHistory {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:historyWordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end

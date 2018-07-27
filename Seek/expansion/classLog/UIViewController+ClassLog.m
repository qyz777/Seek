//
//  UIViewController+ClassLog.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "UIViewController+ClassLog.h"
#import <objc/runtime.h>

@implementation UIViewController (ClassLog)

+ (void)load {
#ifdef DEBUG
    //原本的viewWillAppear方法
    Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
    //需要替换成 能够输出日志的viewWillAppear
    Method logViewWillAppear = class_getInstanceMethod(self, @selector(logViewWillAppear:));
    //两方法进行交换
    method_exchangeImplementations(viewWillAppear, logViewWillAppear);
#endif
}

- (void)logViewWillAppear:(BOOL)animated {
    NSString *className = NSStringFromClass([self class]);
    if ([self controllerFilter:className]) {
        NSLog(@"class:%@",className);
    }
    //下面方法的调用，其实是调用viewWillAppear
    [self logViewWillAppear:animated];
}

- (BOOL)controllerFilter:(NSString *)className {
    if ([className isEqualToString:@"YZTabBarController"]) {
        return false;
    }
    if ([className hasPrefix:@"UI"]) {
        return false;
    }
    return true;
}


@end

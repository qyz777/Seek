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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzlingSelector = @selector(logViewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzlingMethod = class_getInstanceMethod(self, swizzlingSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
        if (success) {
            class_replaceMethod(class, swizzlingSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzlingMethod);
        }
    });
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

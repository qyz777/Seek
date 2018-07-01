//
//  UIViewController+YZTabBarController.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/1.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "UIViewController+YZTabBarController.h"
#import <objc/runtime.h>

@implementation UIViewController (YZTabBarController)

- (YZTabBarController *)yz_tabBarController {
    return objc_getAssociatedObject(self, @selector(yz_tabBarController));
}

- (void)setYz_tabBarController:(YZTabBarController *)yz_tabBarController {
    objc_setAssociatedObject(self, @selector(yz_tabBarController), yz_tabBarController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

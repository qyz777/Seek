//
//  UIViewController+YZNavigationBar.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/6.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "UIViewController+YZNavigationBar.h"
#import <objc/runtime.h>

@implementation UIViewController (YZNavigationBar)

- (YZNavigationBar *)yz_navigationBar {
    return objc_getAssociatedObject(self, @selector(yz_navigationBar));
}

- (void)setYz_navigationBar:(YZNavigationBar *)yz_navigationBar {
    objc_setAssociatedObject(self, @selector(yz_navigationBar), yz_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)navigationBar {
    self.navigationController.navigationBar.hidden = true;
    self.yz_navigationBar = [[YZNavigationBar alloc]init];
    [self.view addSubview:self.yz_navigationBar];
    [self.yz_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(NavigationBarHeight);
        make.left.right.top.offset(0);
    }];
}


@end

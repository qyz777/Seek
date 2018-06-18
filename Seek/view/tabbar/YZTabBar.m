//
//  YZTabBar.m
//  Seek
//
//  Created by Q YiZhong on 2018/6/18.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZTabBar.h"
#import <objc/runtime.h>

@implementation YZTabBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    
    self.tabBarView = [[YZTabBarView alloc]init];
    [self addSubview:self.tabBarView];
    [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

- (void)layoutSubviews {
    [self bringSubviewToFront:self.tabBarView];
}

@end

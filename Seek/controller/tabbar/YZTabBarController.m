//
//  YZTabBarController.m
//  Seek
//
//  Created by Q YiZhong on 2018/6/18.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZTabBarController.h"
#import "YZTabBar.h"
#import "MainViewController.h"
#import "ZKGameIndexViewController.h"
#import "ZKSettingViewController.h"

@interface YZTabBarController ()<YZTabBarViewDelegate>

@property (nonatomic, strong)YZTabBar *yz_tabBar;

@end

@implementation YZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addChildViewController:[ZKGameIndexViewController new]];
    [self addChildViewController:[MainViewController new]];
    [self addChildViewController:[ZKSettingViewController new]];
    self.selectedIndex = 1;
}

- (void)initView {
    self.yz_tabBar = [[YZTabBar alloc]init];
    self.yz_tabBar.tabBarView.yz_delegate = self;
    [self setValue:self.yz_tabBar forKey:@"tabBar"];
}

#pragma make - YZTabBarViewDelegate
- (void)tabBarView:(YZTabBarView *)tabBarView didSelectItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
}

@end

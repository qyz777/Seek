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
#import "MeViewController.h"

@interface YZTabBarController ()<YZTabBarViewDelegate>

@property (nonatomic, strong)YZTabBar *yz_tabBar;

@end

@implementation YZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addViewController:[ZKGameIndexViewController new]];
    [self addViewController:[MainViewController new]];
    [self addViewController:[MeViewController new]];
    self.selectedIndex = 1;
}

- (void)initView {
    self.yz_tabBar = [[YZTabBar alloc]init];
    self.yz_tabBar.tabBarView.yz_delegate = self;
    [self setValue:self.yz_tabBar forKey:@"tabBar"];
}

- (void)addViewController:(UIViewController *)viewController {
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

#pragma make - YZTabBarViewDelegate
- (void)tabBarView:(YZTabBarView *)tabBarView didSelectItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
}

@end

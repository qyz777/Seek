//
//  ZKSettingViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/5/26.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKSettingViewController.h"
#import "ZKSettingView.h"

@interface ZKSettingViewController ()

@end

@implementation ZKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yz_navigationBar.navigationBarColor = RGB(245, 245, 245);
    [self.yz_navigationBar addCenterTitleLabelWithTitle:@"设置" font:[UIFont systemFontOfSize:18.0f weight:UIFontWeightBold] color:[UIColor blackColor]];
    [self.popButton setImage:[UIImage imageNamed:@"pop_black"] forState:UIControlStateNormal];
    ZKSettingView *settingView = [[ZKSettingView alloc] init];
    [self.view addSubview:settingView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

@end

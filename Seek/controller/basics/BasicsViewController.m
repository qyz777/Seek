//
//  BasicsViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/1.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "BasicsViewController.h"

@interface BasicsViewController ()

@end

@implementation BasicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
}

- (void)viewConfig {
    [self navigationBar];
    self.yz_navigationBar.navigationBarColor = BACKGROUND_COLOR_STYLE_TWO;
    UIButton *popButton = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"pop"]];
    [popButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:true];
}

@end

//
//  MainViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/5.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "UIViewController+YZNavigationBar.h"

@interface MainViewController ()

@property(nonatomic, strong)MainView *mainView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationBar];
    self.yz_navigationBar.navigationBarColor = RGB(141, 255, 255);
    UIButton *leftBtn = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"搜索"]];
    
    self.mainView = [MainView new];
    [self.view addSubview:self.mainView];
}

@end

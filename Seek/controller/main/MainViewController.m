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
#import "YZSearchViewController.h"

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
    self.yz_navigationBar.navigationBarColor = BACKGROUND_COLOR_STYLE_ONE;
    self.searchBtn = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"搜索"]];
    [self.searchBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [self.yz_navigationBar addRightButtonWithImage:[UIImage imageNamed:@"更多"]];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mainView = [MainView new];
    [self.view addSubview:self.mainView];
}

- (void)clickLeftBtn:(id)sender {
    YZSearchViewController *vc = [[YZSearchViewController alloc]init];
    [self presentViewController:vc animated:true completion:^{
        
    }];
}

- (void)clickRightBtn:(id)sender {
    
}

@end

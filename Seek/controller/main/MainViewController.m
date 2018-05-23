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
#import "YZMoreViewController.h"
#import "YZLoginViewController.h"

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
    
//    判断用户是否登入
    if ([self isUserNeedLogin]) {
        YZLoginViewController *vc = [YZLoginViewController new];
        [self presentViewController:vc animated:true completion:nil];
    }else {
        [User loginWithPhone:[User sharedUser].phone Password:[User sharedUser].password success:^{
            
        } failure:^(NSError *error) {

        }];
    }
}

- (BOOL)isUserNeedLogin {
    User *user = [User sharedUser];
    if (!user.token) {
        return true;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [date timeIntervalSince1970];
    NSTimeInterval timestamp = [User timestamp];
    if (now - timestamp >= 60 * 60 * 24 * 7) {
        return true;
    }
    return false;
}

- (void)clickLeftBtn:(id)sender {
    YZSearchViewController *vc = [[YZSearchViewController alloc]init];
    [self presentViewController:vc animated:true completion:^{
        
    }];
}

- (void)clickRightBtn:(id)sender {
    YZMoreViewController *vc = [[YZMoreViewController alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:true completion:^{
        
    }];
}

@end

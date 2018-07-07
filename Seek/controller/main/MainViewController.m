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
#import "YZFindViewController.h"
#import "YZLoginViewController.h"
#import "YZWord.h"

@interface MainViewController ()<MainViewDelegate>

@property(nonatomic, strong)MainView *mainView;
@property(nonatomic, copy)NSArray<YZWord *> *fiveWordArray;
@property(nonatomic, assign)NSInteger wordIndex;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationBar];
    self.yz_navigationBar.navigationBarColor = BACKGROUND_COLOR_STYLE_TWO;
    self.searchBtn = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"main_search_btn"]];
    [self.searchBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [self.yz_navigationBar addRightButtonWithImage:[UIImage imageNamed:@"main_find_btn"]];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mainView = [MainView new];
    self.mainView.yz_delegate = self;
    [self.view addSubview:self.mainView];
    
    self.wordIndex = 0;
    
//    判断用户是否登入
    if ([self isUserNeedLogin]) {
        YZLoginViewController *vc = [YZLoginViewController new];
        [self presentViewController:vc animated:true completion:nil];
    }else {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval now = [date timeIntervalSince1970];
        [User sharedUser].timestamp = now;
        [User updateLoginWithToken:[User sharedUser].token time:now success:^{

        } failure:^(NSError *error) {

        }];
    }
    [self requestData];
    [self requestFiveWordData];
}

- (BOOL)isUserNeedLogin {
    User *user = [User sharedUser];
    if (!user.token) {
        return true;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [date timeIntervalSince1970];
    NSTimeInterval timestamp = user.timestamp;
    if (now - timestamp >= 60 * 60 * 24 * 7) {
        return true;
    }
    return false;
}

- (void)requestData {
    [YZWord indexOneWordSuccess:^(YZWord *wordData) {
        self.mainView.wordData = wordData;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestFiveWordData {
    [YZWord indexFiveWordSuccess:^(NSArray<YZWord *> *dataArray) {
        self.fiveWordArray = dataArray;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)clickLeftBtn:(id)sender {
    YZSearchViewController *vc = [[YZSearchViewController alloc]init];
    [self presentViewController:vc animated:true completion:^{
        
    }];
}

- (void)clickRightBtn:(id)sender {
    YZFindViewController *vc = [[YZFindViewController alloc]init];
    [self presentViewController:vc animated:false completion:^{
        
    }];
}

#pragma make - mainViewDelegate
- (void)wordDidSwipeRight {
    if (self.fiveWordArray.count > 0) {
        self.mainView.wordData = self.fiveWordArray[_wordIndex];
        if (self.wordIndex != 4) {
            self.wordIndex++;
        }else {
            [self requestFiveWordData];
            self.wordIndex = 0;
        }
    }
}

- (void)arrowButtonDidClicked {
    if (self.tabBarController.tabBar.alpha == 0) {
        [UIView animateWithDuration:0.2f animations:^{
            self.tabBarController.tabBar.alpha = 1;
        }];
    }else {
        [UIView animateWithDuration:0.2f animations:^{
            self.tabBarController.tabBar.alpha = 0;
        }];
    }
}

@end

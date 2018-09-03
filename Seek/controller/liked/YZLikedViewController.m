//
//  YZLikedViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/25.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZLikedViewController.h"
#import "UIViewController+YZNavigationBar.h"
#import "YZWord.h"
#import "YZLikedView.h"

@interface YZLikedViewController ()

@property(nonatomic, strong)YZLikedView *likedView;

@end

@implementation YZLikedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.yz_navigationBar.navigationBarColor = [UIColor whiteColor];
    [self.popButton setImage:[UIImage imageNamed:@"pop_black"] forState:UIControlStateNormal];
    [self.yz_navigationBar addCenterTitleLabelWithTitle:@"喜欢" font:[UIFont systemFontOfSize:18.0f weight:UIFontWeightBold] color:[UIColor blackColor]];
    
    self.likedView = [[YZLikedView alloc]init];
    [self.view addSubview:self.likedView];
    [self requestData];
}

- (void)requestData {
    [YZWord likedWordWithUserId:[User sharedUser].userId Success:^(NSArray<NSDictionary *> *data) {
        self.likedView.dataArray = data;
        [self.likedView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end

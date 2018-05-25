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
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationBar];
    UIButton *leftBtn = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"返回"]];
    [leftBtn addTarget:self action:@selector(leftBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.likedView = [[YZLikedView alloc]init];
    [self.view addSubview:self.likedView];
    [self requestData];
}

- (void)leftBtnDidClicked:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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

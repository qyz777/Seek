//
//  YZFindViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZFindViewController.h"
#import "YZFindView.h"
#import "UIViewController+YZNavigationBar.h"
#import "YZDetailViewController.h"

@interface YZFindViewController ()<YZFindViewDelegate>

@property(nonatomic, strong)YZFindView *findView;

@property(nonatomic, strong)UIView *refreshView;

@end

@implementation YZFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (BOOL)prefersStatusBarHidden {
    return true;
}

- (void)initView {
    [self navigationBar];
    self.yz_navigationBar.backgroundColor = [UIColor blackColor];
    UIButton *rightButton = [self.yz_navigationBar addRightButtonWithImage:[UIImage imageNamed:@"叉"]];
    [rightButton addTarget:self action:@selector(rightBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"寻找";
    titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLabel.textColor = [UIColor whiteColor];
    [self.yz_navigationBar addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60, 40));
        make.left.equalTo(self.yz_navigationBar).offset(15);
        make.centerY.equalTo(rightButton);
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    self.findView = [[YZFindView alloc]init];
    self.findView.yz_delegate = self;
    [self.view addSubview:self.findView];
    
    self.refreshView = [UIView new];
    self.refreshView.layer.cornerRadius = 5;
    self.refreshView.hidden = true;
    self.refreshView.backgroundColor = RGB(arc4random() % 255, arc4random() % 255, arc4random() % 255);
    [self.view addSubview:self.refreshView];
    [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(10);
        make.center.equalTo(self.view);
    }];
    
    Add_Observer(WordDidLikedNotification, self, wordDidLiked, nil);
}

- (void)dealloc {
    Remove_Observer(self);
}

- (void)wordDidLiked {
    //    TODO:网络请求
}

- (void)rightBtnDidClicked:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma make - YZfindViewDelegate
- (void)cellDidSelectedWithDict:(NSDictionary *)dict color:(UIColor *)color {
    YZDetailViewController *vc = [YZDetailViewController new];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:false completion:^{
        [vc setDetailViewBackgroundColor:color];
    }];
}

- (void)viewWillRefreshWithHeight:(CGFloat)height {
    [self.view setNeedsUpdateConstraints];
    self.refreshView.hidden = false;
    [self.refreshView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.view layoutIfNeeded];
}

- (void)viewDidEndRefresh {
    self.refreshView.hidden = true;
}

@end

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
#import "YZWord.h"

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
    self.yz_navigationBar.backgroundColor = BACKGROUND_COLOR_STYLE_TWO;
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
    
    UILabel *remindLabel = [UILabel new];
    remindLabel.text = @"请左右滑动";
    remindLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 21));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    Add_Observer(WordDidLikedNotification, self, wordDidLiked:, nil);
    
    [self requestData];
}

- (void)dealloc {
    Remove_Observer(self);
}

- (void)wordDidLiked:(NSNotification *)notification {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [YZWord likeWithWord:notification.userInfo[@"word"] success:^(BOOL isLike) {
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    });
}

- (void)rightBtnDidClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)requestData {
    [YZWord findWordSuccess:^(NSArray<NSString *> *data) {
        self.findView.dataArray = data;
        [self.findView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma make - YZfindViewDelegate
- (void)cellDidSelectedWithWord:(NSString *)word color:(UIColor *)color {
    YZDetailViewController *vc = [YZDetailViewController new];
    vc.word = word;
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
//    刷新
    [self requestData];
}

- (void)viewNotShowRefresh {
    self.refreshView.hidden = true;
}

@end

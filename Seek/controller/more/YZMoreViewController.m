//
//  YZMoreViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZMoreViewController.h"
#import "UIViewController+YZNavigationBar.h"
#import "YZMoreView.h"
#import "YZFindViewController.h"
#import "YZLikedViewController.h"

@interface YZMoreViewController ()<YZMoreViewDelegate>

@property(nonatomic, strong)YZMoreView *moreView;

@end

@implementation YZMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationBar];
    self.yz_navigationBar.backgroundColor = BACKGROUND_COLOR_STYLE_ONE;
    UIButton *rightButton = [self.yz_navigationBar addRightButtonWithImage:[UIImage imageNamed:@"收缩"]];
    [rightButton addTarget:self action:@selector(rightButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"更多";
    titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLabel.textColor = [UIColor whiteColor];
    [self.yz_navigationBar addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(60, 40));
        make.left.equalTo(self.yz_navigationBar).offset(15);
        make.centerY.equalTo(rightButton);
    }];
    self.moreView = [[YZMoreView alloc]init];
    self.moreView.yz_delegate = self;
    [self.view addSubview:self.moreView];
}

- (void)rightButtonDidClicked:(id)sender {
    [self dismissViewControllerAnimated:false completion:^{
        
    }];
}

#pragma make - YZMoreViewDelegate
- (void)findTitleDidTouch {
    YZFindViewController *vc = [[YZFindViewController alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:true completion:nil];
}

- (void)likedTitleDidTouch {
    YZLikedViewController *vc = [[YZLikedViewController alloc]init];
    [self presentViewController:vc animated:true completion:nil];
}

- (void)pkTitleDidTouch {
    
}

- (void)settingTitleDidTouch {
    
}

@end

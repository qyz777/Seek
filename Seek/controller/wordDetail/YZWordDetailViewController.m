//
//  YZWordDetailViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/23.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZWordDetailViewController.h"
#import "UIViewController+YZNavigationBar.h"
#import "YZWord.h"
#import "YZWordDetailView.h"

@interface YZWordDetailViewController ()

@property(nonatomic, strong)YZWordDetailView *detailView;

@end

@implementation YZWordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationBar];
    UIButton *leftBtn = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"返回"]];
    [leftBtn addTarget:self action:@selector(leftBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [self.yz_navigationBar addRightButtonWithImage:[UIImage imageNamed:@"喜欢爱心"]];
    rightBtn.tag = -1;
    [rightBtn addTarget:self action:@selector(rightBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.detailView = [[YZWordDetailView alloc]init];
    [self.view addSubview:self.detailView];
    [self requestData];
}

- (void)leftBtnDidClicked:(id)sender {
    [self dismissViewControllerAnimated:false completion:nil];
}

- (void)rightBtnDidClicked:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == -1) {
        [btn setImage:[UIImage imageNamed:@"喜欢的爱心"] forState:UIControlStateNormal];
        btn.tag = 1;
    }else {
        [btn setImage:[UIImage imageNamed:@"喜欢爱心"] forState:UIControlStateNormal];
        btn.tag = -1;
    }
    [YZWord likeWithWord:_word success:^(BOOL isLike) {

    } failure:^(NSError *error) {

    }];
}

- (void)requestData {
    [YZWord searchDetailsWithWord:_word success:^(YZWord *yzWord) {
        self.detailView.wordData = yzWord;
    } failure:^(NSError *error) {
        
    }];
}

#pragma make - setter
- (void)setWord:(NSString *)word {
    _word = word;
    [self requestData];
}

@end

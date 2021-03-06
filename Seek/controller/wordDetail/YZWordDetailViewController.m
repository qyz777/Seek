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
#import "YZDetailImage.h"

@interface YZWordDetailViewController ()

@property(nonatomic, strong)YZWordDetailView *detailView;

@end

@implementation YZWordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor clearColor];
    [self navigationBar];
    self.yz_navigationBar.navigationBarColor = [UIColor clearColor];
    UIButton *leftBtn = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"pop"]];
    [leftBtn addTarget:self action:@selector(leftBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [self.yz_navigationBar addRightButtonWithImage:[UIImage imageNamed:@"detail_heart_like"]];
    rightBtn.tag = -1;
    [rightBtn addTarget:self action:@selector(rightBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.detailView = [[YZWordDetailView alloc]init];
    [self.view addSubview:self.detailView];
    [self.view bringSubviewToFront:self.yz_navigationBar];
    [self requestData];
}

- (void)leftBtnDidClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)rightBtnDidClicked:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == -1) {
        [btn setImage:[UIImage imageNamed:@"detail_heart_liked"] forState:UIControlStateNormal];
        btn.tag = 1;
    }else {
        [btn setImage:[UIImage imageNamed:@"detail_heart_like"] forState:UIControlStateNormal];
        btn.tag = -1;
    }
    [YZWord likeWithWord:_word success:^(BOOL isLike) {

    } failure:^(NSError *error) {

    }];
}

- (void)requestData {
    [SVProgressHUD show];
    __block YZWord *shortWord = [YZWord new];
    __block NSURL *shortImageUrl = nil;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [YZWord searchDetailsWithWord:self.word success:^(YZWord *yzWord) {
            shortWord = yzWord;
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [YZDetailImage wordDetailImageSuccess:^(NSURL *imageUrl) {
            shortImageUrl = imageUrl;
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.detailView.wordData = shortWord;
        [self.detailView.backImageView sd_setImageWithURL:shortImageUrl];
        [SVProgressHUD dismiss];
    });
}

@end

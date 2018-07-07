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
    [SVProgressHUD show];
    __block YZWord *shortWord = [YZWord new];
    __block UIImage *shortImage = [UIImage new];
    
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
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                shortImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl] scale:0.05f];
                dispatch_group_leave(group);
            });
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.detailView.wordData = shortWord;
        self.detailView.headerImageView.image = shortImage;
        [SVProgressHUD dismiss];
    });
}

@end

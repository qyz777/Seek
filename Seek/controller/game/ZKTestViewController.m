//
//  ZKTestViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/8/24.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKTestViewController.h"
#import "ZKGameAnswerTipView.h"

@interface ZKTestViewController ()

@property(nonatomic,weak)ZKGameAnswerTipView *tipView;

@end

@implementation ZKTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = UIColor.whiteColor;
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
//    ZKGameAnswerTipView *tipView = [ZKGameAnswerTipView new];
//
//    tipView.y = self.view.center_x;
//
//    [self.view addSubview:tipView];
//    self.tipView = tipView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    YZLog(@"点击");
    [ZKGameAnswerTipView showTipWithType:ZKGameAnswerTipViewTypeWrong];
}

@end

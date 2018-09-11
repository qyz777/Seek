//
//  ZKTestViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/8/24.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKTestViewController.h"
#import "ZKGameAnswerTipView.h"
#import "ZKMainCardView.h"
#import "ZKGameProgressView.h"
#import "ZKGameFinishTipView.h"

@interface ZKTestViewController ()

@property(nonatomic,weak)ZKGameAnswerTipView *tipView;
@property(nonatomic,weak)ZKMainCardView *cardView;

@property(nonatomic,weak)ZKGameProgressView *leftView;
@property(nonatomic,weak)ZKGameProgressView *rightView;

@end

@implementation ZKTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = BACKGROUND_COLOR_STYLE_TWO;
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
    
//    ZKMainCardView *cardView = [ZKMainCardView new];
//    [self.view addSubview:cardView];
//    self.cardView = cardView;
    
    ZKGameProgressView *leftView = [[ZKGameProgressView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    leftView.type = ZKGameProgressViewTypeLeft;
    
    [self.view addSubview:leftView];
    self.leftView = leftView;
    
    ZKGameProgressView *rightView = [[ZKGameProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 0, 0, 0 )];
    rightView.type = ZKGameProgressViewTypeRight;
    [self.view addSubview:rightView];
    self.rightView = rightView;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [ZKGameFinishTipView showWithType:ZKGameFinishTipViewTypePing];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    YZLog(@"点击");
//    [ZKGameAnswerTipView showTipWithType:ZKGameAnswerTipViewTypeWrong];
//}

@end

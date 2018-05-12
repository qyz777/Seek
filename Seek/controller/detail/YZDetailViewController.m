//
//  YZDetailViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZDetailViewController.h"
#import "YZDetailView.h"

@interface YZDetailViewController ()

@property(nonatomic, strong)YZDetailView *detailView;

@end

@implementation YZDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor clearColor];
    self.detailView = [[YZDetailView alloc]init];
    [self.view addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, SCREEN_HEIGHT - 120));
        make.center.equalTo(self.view);
    }];
}

- (void)setDetailViewBackgroundColor:(UIColor *)color {
    self.detailView.backgroundColor = color;
    self.detailView.layer.cornerRadius = 12.0f;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if (!CGRectContainsPoint(self.detailView.frame, point)) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end

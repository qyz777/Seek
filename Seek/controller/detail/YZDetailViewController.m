//
//  YZDetailViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZDetailViewController.h"
#import "YZDetailView.h"

NSNotificationName const WordDidLikedNotification = @"WordDidLikedNotification";

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
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, SCREEN_HEIGHT - 150));
        make.center.equalTo(self.view);
    }];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDetailView:)];
    [self.detailView addGestureRecognizer:pan];
}

- (void)setDetailViewBackgroundColor:(UIColor *)color {
    self.detailView.backgroundColor = color;
    self.detailView.layer.cornerRadius = 12.0f;
}

- (void)panDetailView:(UIPanGestureRecognizer *)pan {
    CGFloat offsetX = [pan translationInView:self.detailView].x;
    if (pan.state == UIGestureRecognizerStateEnded) {
//        绝对值大于70，则可以直接判断喜欢还是不喜欢
        if (fabs(offsetX) >= 70) {
            if (offsetX > 0) {
//                往右划是喜欢
                [UIView animateWithDuration:0.2f animations:^{
                    self.detailView.center = CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT / 2 + 50);
                    self.detailView.imageView.alpha = 1;
                }completion:^(BOOL finished) {
                    [self dismissViewControllerAnimated:true completion:^{
                        Post_Notify(WordDidLikedNotification, nil, nil);
                    }];
                }];
            }else {
//                往左划是不喜欢
                [UIView animateWithDuration:0.2f animations:^{
                    self.detailView.center = CGPointMake(0, SCREEN_HEIGHT / 2 + 50);
                    self.detailView.imageView.alpha = 1;
                }completion:^(BOOL finished) {
                    [self dismissViewControllerAnimated:true completion:nil];
                }];
            }
        }else {
            [UIView animateWithDuration:0.2f animations:^{
                self.detailView.imageView.alpha = 0;
                self.detailView.transform = CGAffineTransformIdentity;
            }];
        }
    }
    if (pan.state == UIGestureRecognizerStateChanged) {
        if (offsetX > 0) {
            self.detailView.imageView.image = [UIImage imageNamed:@"喜欢表情"];
        }else {
            self.detailView.imageView.image = [UIImage imageNamed:@"不喜欢表情"];
        }
        CGAffineTransform t1 = CGAffineTransformMakeRotation(M_PI * offsetX * 0.0006);
        CGAffineTransform t2 = CGAffineTransformTranslate(t1, offsetX * 2, 0);
        self.detailView.transform = t2;
        self.detailView.imageView.alpha = fabs(offsetX * 0.01);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if (!CGRectContainsPoint(self.detailView.frame, point)) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end

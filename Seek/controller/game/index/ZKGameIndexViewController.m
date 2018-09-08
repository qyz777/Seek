//
//  ZKGameIndexViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/5/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameIndexViewController.h"
#import "ZKGameIndexView.h"
#import "ZKGameSingleViewController.h"
#import "ZKGameBattleViewController.h"
#import "YZGameInterludeViewController.h"
#import "YZCameraController.h"
#import "YZCameraTransition.h"

@interface ZKGameIndexViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) YZCameraController *cameraController;

@end

@implementation ZKGameIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationBar];
    self.yz_navigationBar.navigationBarColor = BACKGROUND_COLOR_STYLE_TWO;
    [self.yz_navigationBar addCenterTitleLabelWithTitle:@"游戏大厅" font:[UIFont systemFontOfSize:18.0f weight:UIFontWeightBold] color:[UIColor whiteColor]];
    UIButton *leftBtn = [self.yz_navigationBar addLeftButtonWithImage:[UIImage imageNamed:@"game_photo"]];
    [leftBtn addTarget:self action:@selector(leftBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    ZKGameIndexView *indexView = [[ZKGameIndexView alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:indexView];
    
    [indexView setTagActionHandle:^(NSInteger tag) {
        switch (tag) {
            case 1001:{
                ZKGameSingleViewController *singleVC = [[ZKGameSingleViewController alloc] init];
                [self presentViewController:singleVC animated:YES completion:nil];
            }
                break;
            case 1002:{
                YZGameInterludeViewController *findVC = [[YZGameInterludeViewController alloc] init];
                findVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:findVC animated:YES completion:nil];
            }
                break;
            case 1003:{
                self.cameraController.isQuery = NO;
                [self presentViewController:self.cameraController animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    }];
    
    self.cameraController = [[YZCameraController alloc] init];
    self.cameraController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (void)loadingTap {
    
}

- (void)leftBtnDidClicked:(id)sender {
    self.cameraController.isQuery = YES;
    [self presentViewController:self.cameraController animated:YES completion:nil];
}

- (void)onPan:(UIPanGestureRecognizer *)pan {
    CGPoint velocity = [pan velocityInView:self.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            if (velocity.x > 0) {
                [self.cameraController beginPresentTransition];
                [self presentViewController:self.cameraController animated:YES completion:nil];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint currentPoint = [pan translationInView:self.view];
            [self.cameraController updatePresentTransition:fabs(currentPoint.x) / SCREEN_WIDTH];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            CGPoint currentPoint = [pan translationInView:self.view];
            [self.cameraController endPresentTransition:fabs(currentPoint.x) / SCREEN_WIDTH];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end

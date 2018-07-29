//
//  YZCameraTransition.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/29.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZCameraTransition.h"

@interface YZCameraTransition()

@property(nonatomic, assign)BOOL isPresent;

@end

@implementation YZCameraTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL isParent = (toVC.presentingViewController == fromVC);
    if (isParent) {
        [self presentViewController:transitionContext];
        _isPresent = true;
    }else {
        [self dismissViewController:transitionContext];
        _isPresent = false;
    }
}

- (void)presentViewController:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect toVCFrame = toVC.view.frame;
    toVCFrame.origin.x = -SCREEN_WIDTH;
    toVC.view.frame = toVCFrame;
    [[transitionContext containerView] addSubview:toVC.view];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration animations:^{
        CGRect toVCFrame = toVC.view.frame;
        toVCFrame.origin.x = 0;
        toVC.view.frame = toVCFrame;
        CGRect fromVCFrame = fromVC.view.frame;
        fromVCFrame.origin.x = SCREEN_WIDTH;
        fromVC.view.frame = fromVCFrame;
    } completion:^(BOOL finished) {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
}

- (void)dismissViewController:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC= [transitionContext viewControllerForKey:( UITransitionContextToViewControllerKey)];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect toVCFrame = toVC.view.frame;
    toVCFrame.origin.x = SCREEN_WIDTH;
    toVC.view.frame = toVCFrame;
    [[transitionContext containerView] addSubview:toVC.view];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration animations:^{
        CGRect toVCFrame = toVC.view.frame;
        toVCFrame.origin.x = 0;
        toVC.view.frame = toVCFrame;
        CGRect fromVCFrame = fromVC.view.frame;
        fromVCFrame.origin.x = -SCREEN_WIDTH;
        fromVC.view.frame = fromVCFrame;
    } completion:^(BOOL finished) {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
}

#pragma mark -  CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (_isPresent) {
        id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
        [transitionContext completeTransition:true];
    }else {
        id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
        }
    }
}

@end

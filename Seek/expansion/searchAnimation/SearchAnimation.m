//
//  SearchAnimation.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "SearchAnimation.h"
#import "MainViewController.h"

@interface SearchAnimation()

@property(nonatomic, assign)BOOL isPush;

@end


@implementation SearchAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UINavigationController *nav = (UINavigationController *)toVC.parentViewController;
    MainViewController *mainVC = nav.viewControllers[0];
    
    BOOL isPush = (mainVC == fromVC);
    if (isPush) {
        [self pushViewController:transitionContext];
        _isPush = true;
    }else {
        [self popViewController:transitionContext];
        _isPush = false;
    }
}

- (void)pushViewController:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    MainViewController *fromVC = (MainViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:fromVC.searchBtn.frame];
    CGFloat x = MAX(fromVC.searchBtn.frame.origin.x, containerView.frame.size.width - fromVC.searchBtn.frame.origin.x);
    CGFloat y = MAX(fromVC.searchBtn.frame.origin.y, containerView.frame.size.height - fromVC.searchBtn.frame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center
                                                           radius:radius
                                                       startAngle:0
                                                         endAngle:M_PI * 2
                                                        clockwise:true];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:animation forKey:@"path"];
}

- (void)popViewController:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * fromVC= [transitionContext viewControllerForKey:( UITransitionContextFromViewControllerKey)];
    UIViewController * toVC= [transitionContext viewControllerForKey:( UITransitionContextToViewControllerKey)];

    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView   = [transitionContext viewForKey:UITransitionContextToViewKey];

    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame   = [transitionContext finalFrameForViewController:toVC];
    fromView.alpha = 1.0f;
    toView.alpha   = 0.0f;

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toView];

    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration animations:^{
        fromView.alpha = 0.0f;
        toView.alpha   = 1.0f;
    } completion:^(BOOL finished) {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
}

#pragma mark -  CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (_isPush) {
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

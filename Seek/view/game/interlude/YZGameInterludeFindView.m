//
//  YZGameInterludeFindView.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZGameInterludeFindView.h"

#define AnimationDuration 2.5
#define PulsingCount 3.0
#define ScaleRange 1.8

@implementation YZGameInterludeFindView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CALayer *animationLayer = [CALayer layer];
    for (int i=0;i<PulsingCount;i++) {
        NSArray *animationArray = [self animationArray];
        CAAnimationGroup *animationGroup = [self animationGroupAnimations:animationArray index:i];
        CALayer *pulsingLayer = [self pulsingLayer:rect animation:animationGroup];
        [animationLayer addSublayer:pulsingLayer];
    }
    [self.layer addSublayer:animationLayer];
}

- (NSArray *)animationArray {
    NSArray *animationArray = nil;
    CABasicAnimation *scaleAnimation = [self scaleAnimation];
    CAKeyframeAnimation *borderColorAnimation = [self borderColorAnimation];
    animationArray = @[scaleAnimation, borderColorAnimation];
    
    return animationArray;
}

- (CAAnimationGroup *)animationGroupAnimations:(NSArray *)array {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.duration = 3;
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.animations = array;
    animationGroup.removedOnCompletion = NO;
    return animationGroup;
}

- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(1);
    scaleAnimation.toValue = @(ScaleRange);
    return scaleAnimation;
}

// 使用关键帧动画，使得颜色动画不要那么的线性变化
- (CAKeyframeAnimation *)borderColorAnimation {
    CAKeyframeAnimation *borderColorAnimation = [CAKeyframeAnimation animation];
    borderColorAnimation.keyPath = @"borderColor";
    borderColorAnimation.values = @[(__bridge id)RGB_ALPHA(255, 182, 193, 0.8).CGColor,
                                    (__bridge id)RGB_ALPHA(255, 182, 193, 0.6).CGColor,
                                    (__bridge id)RGB_ALPHA(255, 182, 193, 0.3).CGColor,
                                    (__bridge id)RGB_ALPHA(255, 182, 193, 0).CGColor];
    borderColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return borderColorAnimation;
}

- (CALayer *)pulsingLayer:(CGRect)rect animation:(CAAnimationGroup *)animationGroup {
    CALayer *pulsingLayer = [CALayer layer];
    pulsingLayer.borderWidth = 0.5;
    pulsingLayer.borderColor = UIColorFromRGB(0xFFFAFA).CGColor;
    pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    pulsingLayer.cornerRadius = rect.size.height / 2;
    [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
    return pulsingLayer;
}

- (CAAnimationGroup *)animationGroupAnimations:(NSArray *)array index:(int)index {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    animationGroup.beginTime = CACurrentMediaTime() + (index * AnimationDuration) / PulsingCount;
    animationGroup.duration = AnimationDuration;
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.animations = array;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animationGroup;
}

@end

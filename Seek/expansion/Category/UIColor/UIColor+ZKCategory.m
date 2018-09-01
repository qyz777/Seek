//
//  UIColor+ZKCategory.m
//  Seek
//
//  Created by 徐正科 on 2018/8/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "UIColor+ZKCategory.h"

@implementation UIColor (ZKCategory)

// 渐变色
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor direction:(GradientLayerDirection)direction{
    //  CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    // 设置渐变色数组
    gradientLayer.colors = @[
                             (__bridge id)fromColor.CGColor,
                             (__bridge id)toColor.CGColor
                             ];
    
    CGPoint startPoint;
    CGPoint endPoint;
    
    if (direction == GradientLayerDirectionHorizontal) {
        // 水平
        startPoint = CGPointMake(0,0.5);
        endPoint = CGPointMake(1,0.5);
    }else{
        // 竖直
        startPoint = CGPointMake(0.5, 0);
        endPoint = CGPointMake(0.5, 1);
    }
    
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    
    // 设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}

@end

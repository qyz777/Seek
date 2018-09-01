//
//  UIColor+ZKCategory.h
//  Seek
//
//  Created by 徐正科 on 2018/8/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,GradientLayerDirection){
    GradientLayerDirectionHorizontal,//水平
    GradientLayerDirectionVertical  //垂直
};

@interface UIColor (ZKCategory)

+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor direction:(GradientLayerDirection)direction;

@end

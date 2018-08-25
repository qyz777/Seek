//
//  ZKAnswerButton.m
//  Seek
//
//  Created by 徐正科 on 2018/8/24.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKAnswerButton.h"

typedef NS_ENUM(NSInteger,ZKAnswerButtonAnimationType){
    ZKAnswerButtonAnimationTypeNormal,  //正常 背景色和颜色正常
    ZKAnswerButtonAnimationTypeRight, //正确 背景色绿色 字体白色
    ZKAnswerButtonAnimationTypeWrong, //错误 背景色红色 字体白色
};


@interface ZKAnswerButton()


@end

@implementation ZKAnswerButton

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
        
    }
    
    return self;
}

- (void)initView {
    
    self.frame = CGRectMake(kInterval, 0, SCREEN_WIDTH - 2 * kInterval, 50);
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor colorWithRed:72 / 255.0 green:197 / 355.0 blue:149 / 255.0 alpha:1.0];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = UIColor.whiteColor;
}

/**
 * 正确动画
 */

- (void)rightAnimation {
    [self changeColorWithType:ZKAnswerButtonAnimationTypeRight];
}

/**
 * 错误动画
 */

- (void)wrongAnimation {
    [self changeColorWithType:ZKAnswerButtonAnimationTypeWrong];
}


- (void)changeColorWithType:(ZKAnswerButtonAnimationType)type {
    if (type == ZKAnswerButtonAnimationTypeNormal) {
        self.textColor = [UIColor colorWithRed:72 / 255.0 green:197 / 355.0 blue:149 / 255.0 alpha:1.0];
        self.backgroundColor = UIColor.whiteColor;
    }else{
        self.textColor = UIColor.whiteColor;
        
        if (type == ZKAnswerButtonAnimationTypeRight) {
            self.backgroundColor = UIColorFromRGB(0x5FB878);
        }else{
            self.backgroundColor = UIColorFromRGB(0xFF5722);
        }
        
        // 1秒后恢复正常颜色
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self changeColorWithType:ZKAnswerButtonAnimationTypeNormal];
        });
    }
}

@end

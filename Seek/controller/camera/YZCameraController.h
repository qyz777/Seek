//
//  YZCameraController.h
//  Seek
//
//  Created by Q YiZhong on 2018/7/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZCameraController : UIViewController

- (void)beginPresentTransition;

- (void)updatePresentTransition:(CGFloat)percent;

- (void)endPresentTransition:(CGFloat)percent;

@end

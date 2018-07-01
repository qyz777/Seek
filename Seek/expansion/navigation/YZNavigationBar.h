//
//  YZNavigationBar.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/6.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZNavigationBar : UIView

// navigationBar background-color
@property(nonatomic, strong)UIColor *navigationBarColor;

// default is left
- (UILabel *)addTitleLabelWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;

// default is center
- (UILabel *)addCenterTitleLabelWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;

// add navigationBar left button
- (UIButton *)addLeftButtonWithImage:(UIImage *)image;

- (UIButton *)addLeftButtonWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;

// add navigationBar right button
- (UIButton *)addRightButtonWithImage:(UIImage *)image;

- (UIButton *)addRightButtonWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;


@end

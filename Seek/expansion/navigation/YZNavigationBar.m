//
//  YZNavigationBar.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/6.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZNavigationBar.h"
#import "NSString+Custom.h"

@implementation YZNavigationBar

- (instancetype)init {
    self = [super init];
    [self initView];
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
}

- (UILabel *)addTitleLabelWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color {
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = title;
    titleLabel.font = font;
    titleLabel.textColor = color;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.left.equalTo(self).offset(80);
        make.bottom.equalTo(self.mas_bottom).offset(-4);
    }];
    
    return titleLabel;
}

- (UILabel *)addCenterTitleLabelWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color {
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = title;
    titleLabel.font = font;
    titleLabel.textColor = color;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(25);
    }];
    
    return titleLabel;
}

- (UIButton *)addLeftButtonWithImage:(UIImage *)image {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:image forState:UIControlStateNormal];
    [self addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-4);
    }];
    return leftButton;
}

- (UIButton *)addLeftButtonWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:title forState:UIControlStateNormal];
    leftButton.titleLabel.font = font;
    [leftButton setTitleColor:color forState:UIControlStateNormal];
    [self addSubview:leftButton];
    CGSize size = [title sizeWithFont:font];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(size.width + 8, size.height + 8));
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    return leftButton;
}

- (UIButton *)addRightButtonWithImage:(UIImage *)image {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:image forState:UIControlStateNormal];
    [self addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-4);
    }];
    return rightButton;
}

- (UIButton *)addRightButtonWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:title forState:UIControlStateNormal];
    rightButton.titleLabel.font = font;
    [rightButton setTitleColor:color forState:UIControlStateNormal];
    [self addSubview:rightButton];
    CGSize size = [title sizeWithFont:font];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(size.width + 8, size.height + 8));
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    return rightButton;
}

#pragma make - setter
- (void)setNavigationBarColor:(UIColor *)navigationBarColor {
    _navigationBarColor = navigationBarColor;
    self.backgroundColor = _navigationBarColor;
}

@end

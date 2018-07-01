//
//  YZTabBarView.m
//  Seek
//
//  Created by Q YiZhong on 2018/6/18.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZTabBarView.h"

@implementation YZTabBarView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = RGB_ALPHA(0, 0, 0, 0.85);
    
    [self addSubview:self.homeButton];
    [self.homeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(self).offset(-20);
    }];
    [self.homeButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.gameButton];
    [self.gameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.gameButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.meButton];
    [self.meButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.meButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonDidClicked:(id)sender {
    UIButton *btn = sender;
    if ([self.yz_delegate respondsToSelector:@selector(tabBarView:didSelectItemAtIndex:)]) {
        [self.yz_delegate tabBarView:self didSelectItemAtIndex:btn.tag];
    }
    
    [self setNeedsUpdateConstraints];
    if (btn.tag == 0) {
        [UIView animateWithDuration:0.2f animations:^{
            [self.homeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            [self.gameButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(30);
                make.size.mas_equalTo(CGSizeMake(40, 40));
                make.bottom.equalTo(self).offset(-20);
            }];
            [self.meButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-30);
                make.centerY.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            [self layoutIfNeeded];
        }];
    }else if (btn.tag == 1) {
        [UIView animateWithDuration:0.2f animations:^{
            [self.homeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(40, 40));
                make.bottom.equalTo(self).offset(-20);
            }];
            [self.gameButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(30);
                make.centerY.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            [self.meButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-30);
                make.centerY.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            [self layoutIfNeeded];
        }];
    }else {
        [UIView animateWithDuration:0.2f animations:^{
            [self.homeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            [self.gameButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(30);
                make.centerY.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            [self.meButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-30);
                make.size.mas_equalTo(CGSizeMake(40, 40));
                make.bottom.equalTo(self).offset(-20);
            }];
            [self layoutIfNeeded];
        }];
    }
}

#pragma make - getter
- (UIButton *)homeButton {
    if (!_homeButton) {
        _homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _homeButton.tag = 1;
        [_homeButton setImage:[UIImage imageNamed:@"tabbar_home"] forState:UIControlStateNormal];
    }
    return _homeButton;
}

- (UIButton *)gameButton {
    if (!_gameButton) {
        _gameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _gameButton.tag = 0;
        [_gameButton setImage:[UIImage imageNamed:@"tabbar_game"] forState:UIControlStateNormal];
    }
    return _gameButton;
}

- (UIButton *)meButton {
    if (!_meButton) {
        _meButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _meButton.tag = 2;
        [_meButton setImage:[UIImage imageNamed:@"tabbar_me"] forState:UIControlStateNormal];
    }
    return _meButton;
}

@end

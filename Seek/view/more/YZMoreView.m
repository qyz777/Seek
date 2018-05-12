
//
//  YZMoreView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZMoreView.h"

@implementation YZMoreView

- (instancetype)init {
    self = [super init];
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
    [self initSubViews];
    return self;
}

- (void)initSubViews {
    self.backgroundColor = BACKGROUND_COLOR_STYLE_ONE;
    self.findTitle = [[YZMoreTitleView alloc]init];
    UITapGestureRecognizer *findTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(findTitleDidTouch)];
    [self.findTitle addGestureRecognizer:findTap];
    self.findTitle.imageView.image = [UIImage imageNamed:@"寻找单词"];
    self.findTitle.label.text = @"寻找单词";
    [self addSubview:self.findTitle];
    [self.findTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3 + 10, 30));
        make.top.equalTo(self).offset(160);
        make.centerX.equalTo(self);
    }];
    
    self.likedTitle = [[YZMoreTitleView alloc]init];
    self.likedTitle.imageView.image = [UIImage imageNamed:@"喜欢"];
    self.likedTitle.label.text = @"喜欢过的";
    [self addSubview:self.likedTitle];
    [self.likedTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3 + 10, 30));
        make.top.equalTo(self.findTitle.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
    
    self.pkTitle = [[YZMoreTitleView alloc]init];
    self.pkTitle.imageView.image = [UIImage imageNamed:@"面对面PK"];
    self.pkTitle.label.text = @"面对面PK";
    [self addSubview:self.pkTitle];
    [self.pkTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3 + 10, 30));
        make.top.equalTo(self.likedTitle.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
    
    self.settingTitle = [[YZMoreTitleView alloc]init];
    self.settingTitle.imageView.image = [UIImage imageNamed:@"设置"];
    self.settingTitle.label.text = @"设置";
    [self addSubview:self.settingTitle];
    [self.settingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3 + 10, 30));
        make.top.equalTo(self.pkTitle.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
}

- (void)findTitleDidTouch {
    if ([self.yz_delegate respondsToSelector:@selector(findTitleDidTouch)]) {
        [self.yz_delegate findTitleDidTouch];
    }
}

@end

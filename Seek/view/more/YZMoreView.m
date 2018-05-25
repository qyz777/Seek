
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
//    self.findTitle.imageView.image = [UIImage imageNamed:@"寻找单词"];
    self.findTitle.label.text = @"寻找";
    [self addSubview:self.findTitle];
    [self.findTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 30, SCREEN_WIDTH / 2 - 30));
        make.top.equalTo(self).offset(100);
        make.left.equalTo(self).offset(20);
    }];
    
    self.likedTitle = [[YZMoreTitleView alloc]init];
//    self.likedTitle.imageView.image = [UIImage imageNamed:@"喜欢"];
    UITapGestureRecognizer *likedTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(likedTitleDidTouch)];
    [self.likedTitle addGestureRecognizer:likedTap];
    self.likedTitle.label.text = @"喜欢";
    [self addSubview:self.likedTitle];
    [self.likedTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 30, SCREEN_WIDTH / 2 - 30));
        make.top.equalTo(self).offset(100);
        make.right.equalTo(self).offset(-20);
    }];

    self.pkTitle = [[YZMoreTitleView alloc]init];
//    self.pkTitle.imageView.image = [UIImage imageNamed:@"面对面PK"];
    UITapGestureRecognizer *pkTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pkTitleDidTouch)];
    [self.pkTitle addGestureRecognizer:pkTap];
    self.pkTitle.label.text = @"PK";
    [self addSubview:self.pkTitle];
    [self.pkTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 30, SCREEN_WIDTH / 2 - 30));
        make.top.equalTo(self.findTitle.mas_bottom).offset(20);
        make.centerX.equalTo(self.findTitle);
    }];

    self.settingTitle = [[YZMoreTitleView alloc]init];
//    self.settingTitle.imageView.image = [UIImage imageNamed:@"设置"];
    UITapGestureRecognizer *settingTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settingTitleDidTouch)];
    [self.settingTitle addGestureRecognizer:settingTap];
    self.settingTitle.label.text = @"设置";
    [self addSubview:self.settingTitle];
    [self.settingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 30, SCREEN_WIDTH / 2 - 30));
        make.top.equalTo(self.likedTitle.mas_bottom).offset(20);
        make.centerX.equalTo(self.likedTitle);
    }];
}

- (void)findTitleDidTouch {
    if ([self.yz_delegate respondsToSelector:@selector(findTitleDidTouch)]) {
        [self.yz_delegate findTitleDidTouch];
    }
}

- (void)likedTitleDidTouch {
    if ([self.yz_delegate respondsToSelector:@selector(likedTitleDidTouch)]) {
        [self.yz_delegate likedTitleDidTouch];
    }
}

- (void)pkTitleDidTouch {
    if ([self.yz_delegate respondsToSelector:@selector(pkTitleDidTouch)]) {
        [self.yz_delegate pkTitleDidTouch];
    }
}

- (void)settingTitleDidTouch {
    if ([self.yz_delegate respondsToSelector:@selector(settingTitleDidTouch)]) {
        [self.yz_delegate settingTitleDidTouch];
    }
}

@end

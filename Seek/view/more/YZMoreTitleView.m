//
//  YZMoreTitleView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/10.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZMoreTitleView.h"

@implementation YZMoreTitleView

- (instancetype)init {
    self = [super init];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2 - 30, SCREEN_WIDTH / 2 - 30);
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    self.imageView = [UIImageView new];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 50, SCREEN_WIDTH / 2 - 50));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(0);
    }];
    self.label = [UILabel new];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:20.0f];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 30, 21));
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
    }];
}


@end

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
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3 + 10, 30);
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    self.imageView = [UIImageView new];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self).offset(0);
        make.centerY.equalTo(self);
    }];
    self.label = [UILabel new];
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:20.0f];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3 + 10 - 40, 30));
        make.right.equalTo(self).offset(0);
        make.centerY.equalTo(self);
    }];
}


@end

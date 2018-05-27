//
//  ZKGameIndexView.m
//  Seek
//
//  Created by 徐正科 on 2018/5/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameIndexView.h"

static const CGFloat kInterval = 20;

@implementation ZKGameIndexView

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.frame = [UIScreen mainScreen].bounds;
    
    UIView *view = [self getCardWithIcon:@"" background:@"" shadowColor:UIColor.redColor title:@"" star:1 andTags:@[]];
    [self addSubview:view];
}


- (UIView *)getCardWithIcon:(NSString *)iconName background:(NSString *)bgName shadowColor:(UIColor *)color title:(NSString *)title star:(NSInteger)starCoun andTags:(NSArray<NSString *> *)tags {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 2 * kInterval, 60)];
    view.backgroundColor = UIColor.redColor;
    return view;
}


@end

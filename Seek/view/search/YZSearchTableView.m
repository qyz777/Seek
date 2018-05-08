//
//  YZSearchTableView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/8.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZSearchTableView.h"

@implementation YZSearchTableView

- (instancetype)init {
    self = [super init];
    self.backgroundColor = RGB_ALPHA(0, 0, 0, 0.4);
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    
}

@end

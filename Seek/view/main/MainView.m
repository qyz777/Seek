//
//  MainView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/5.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (instancetype)init {
    self = [super init];
    [self initSubViews];
    return self;
}

- (void)initSubViews {
    self.frame = CGRectMake(0, navigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - navigationBarHeight);
//    self.backgroundColor = RGB(141, 255, 255);
    
}

@end

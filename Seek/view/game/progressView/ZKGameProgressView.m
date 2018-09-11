
//
//  ZKGameProgressView.m
//  Seek
//
//  Created by 徐正科 on 2018/9/11.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameProgressView.h"

@interface ZKGameProgressView()

// 进度条
@property(nonatomic,weak)UIView *progressView;

@end

@implementation ZKGameProgressView

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame.size.height = 20;
    frame.size.width = SCREEN_WIDTH * 0.5;
    
    self = [super initWithFrame:frame];
    return self;
}

- (void)setType:(ZKGameProgressViewType)type {
    _type = type;
    
    [self initView];
}

- (void)initView {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;

    UIView *progressView = [UIView new];
    progressView.height = 20;
    
    if (_type == ZKGameProgressViewTypeLeft) {
        self.x -= 10;

        progressView.x = 0;
        progressView.backgroundColor = UIColorFromRGB(0x5FB878);
    }else{
        self.x += 10;
        progressView.x = self.width;
        progressView.backgroundColor = UIColorFromRGB(0xFF5722);
    }
    
    [self addSubview:progressView];
    
    self.progressView = progressView;
}

- (void)updateProgress {
    CGRect frame = self.progressView.frame;
    
    frame.size.width += self.width * 0.2;
    if (_type == ZKGameProgressViewTypeLeft) {
        
    }else{
        frame.origin.x -= self.width * 0.2;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.progressView.frame = frame;
    }];
}

@end

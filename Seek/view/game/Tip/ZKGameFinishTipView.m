//
//  ZKGameFinishTipView.m
//  Seek
//
//  Created by 徐正科 on 2018/9/11.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameFinishTipView.h"

@implementation ZKGameFinishTipView

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    
    return self;
}

- (void)initView {
//    self.width = SCREEN_WIDTH * 0.5;
//    self.height = self.width;
    
    self.center_x = SCREEN_WIDTH * 0.5;
    self.center_y = SCREEN_HEIGHT * 0.5;
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
}

- (void)showWithType:(ZKGameFinishTipViewType)type {
    
    UIImageView *imgView = [UIImageView new];
    
    NSString *imgName = nil;
    switch (type) {
        case ZKGameFinishTipViewTypeWin:
            imgName = @"game_win";
            break;
        case ZKGameFinishTipViewTypeLose:
            imgName = @"game_lose";
            break;
        case ZKGameFinishTipViewTypePing:
            imgName = @"game_ping";
            break;
        default:
            break;
    }
    
    imgView.image = [UIImage imageNamed:imgName];
    
    [self addSubview:imgView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.width = SCREEN_WIDTH * 0.5;
        self.height = self.width;
        
        self.center_x = SCREEN_WIDTH * 0.5;
        self.center_y = SCREEN_HEIGHT * 0.5;
        
        imgView.width = self.width * 0.8;
        imgView.height = self.height * 0.5;
        imgView.center_x = self.width * 0.5;
        imgView.center_y = self.height * 0.5;
    }];
}

+ (void)showWithType:(ZKGameFinishTipViewType)type{
    ZKGameFinishTipView *view = [ZKGameFinishTipView new];
    [view showWithType:type];
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
}

@end

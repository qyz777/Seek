//
//  ZKMainCardViewCell.m
//  Seek
//
//  Created by 徐正科 on 2018/8/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKMainCardViewCell.h"

@implementation ZKMainCardViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    
    return self;
}

- (void)initView {
    
    self.width = SCREEN_WIDTH * 0.8;
    self.height = SCREEN_HEIGHT * 2/3;
    self.center_x = SCREEN_WIDTH * 0.5;
    self.center_y = SCREEN_HEIGHT * 0.5;
    
//    UIColor *randColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255) / 255.0 alpha:0.5];
//    [self.layer addSublayer:[UIColor setGradualChangingColor:self fromColor:UIColor.whiteColor toColor: randColor direction:GradientLayerDirectionVertical]];

    self.backgroundColor = UIColorFromRGB(0x616161);
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_bg"]];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:imgView];
}

@end

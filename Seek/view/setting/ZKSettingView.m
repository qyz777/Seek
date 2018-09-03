//
//  ZKSettingView.m
//  Seek
//
//  Created by 徐正科 on 2018/5/26.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKSettingView.h"

#define DEFAULT_COLOR [UIColor colorWithRed:81 / 255.0 green:81 / 255.0 blue:81 / 255.0 alpha:1.0]

static const NSInteger kInterval = 20;

@implementation ZKSettingView

- (instancetype)init {
    if (self = [super init]) {
        // 初始化界面
        [self initView];
    }
    
    return self;
}

//初始化界面
- (void)initView {
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - TabBarHeight);
    self.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    
    //test: 允许对战
    UIView *gameView = [self getViewWithFrame:CGRectMake(kInterval, kInterval, SCREEN_WIDTH - 2 * kInterval, 50) andTitle:@"允许对战"];
    UISwitch *gameSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(gameView.width - 50 - 25, 0, 32, 32)];
    gameSwitch.on = YES;
    gameSwitch.center_y = gameView.height * 0.5;
    [gameView addSubview:gameSwitch];
    [self addSubview:gameView];
    
    //test: 显示排行
    UIView *rankView = [self getViewWithFrame:CGRectMake(kInterval, gameView.bottom + kInterval, SCREEN_WIDTH - 2 * kInterval, 50) andTitle:@"允许排行榜显示"];
    UISwitch *rankSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(rankView.width - 50 - 25, 0, 32, 32)];
    rankSwitch.on = YES;
    rankSwitch.center_y = rankView.height * 0.5;
    [rankView addSubview:rankSwitch];
    [self addSubview:rankView];
}

//生成白底View
- (UIView *)getViewWithFrame:(CGRect)frame andTitle:(NSString *)title {
    if (frame.size.height < 50) {
        frame.size.height = 50;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = UIColor.whiteColor;
    view.layer.cornerRadius = 25;
    view.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, view.width - 20 * 2, 50)];
    label.text = title;
    label.textColor = DEFAULT_COLOR;
    [view addSubview:label];

    return view;
}

- (UIView *)getViewWithFrame:(CGRect)frame andRadius:(CGFloat)radius {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = UIColor.whiteColor;
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    return view;
}


@end

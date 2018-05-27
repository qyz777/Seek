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
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    
    //设置顶部主题
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60 + kInterval)];
    titleView.backgroundColor = UIColor.whiteColor;
    [self addSubview:titleView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kInterval, kInterval, SCREEN_WIDTH - 2  *kInterval, 60)];
    titleLabel.text = @"设置";
    titleLabel.textColor = DEFAULT_COLOR;
    titleLabel.font = [UIFont systemFontOfSize:25];
    [titleView addSubview:titleLabel];
    
    //设置左部icon
    UIImageView *titleImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"设置"]];
    titleImgView.frame = CGRectMake(kInterval, 0, 32, 32);
    titleImgView.center_y = titleLabel.center_y;
    [titleView addSubview:titleImgView];
    
    
    //设置右部编辑
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 32, 32);
    [closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    closeBtn.center_y = titleLabel.center_y;
    [titleView addSubview:closeBtn];
    
    self.closeBtn = closeBtn;
    
    CGFloat left_width = titleImgView.x + titleImgView.width + 10;
//    CGFloat right_width = closeBtn.width + 10;
    titleLabel.x = left_width;
    titleLabel.width -= (left_width + kInterval);
    closeBtn.x = titleLabel.x + titleLabel.width + 10;
    
    
    //设置个人信息区域
    UIView *infoView = [self getViewWithFrame:CGRectMake(kInterval, titleView.bottom + kInterval, SCREEN_WIDTH - 2 * kInterval, 60) andRadius:30];
    [self addSubview:infoView];
    
    //个人头像
    UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    headerImgView.layer.cornerRadius = 30;
    headerImgView.layer.masksToBounds = YES;
    headerImgView.image = [UIImage imageNamed:@"testheadimg"];
    [infoView addSubview:headerImgView];
    
    UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerImgView.x + headerImgView.width + kInterval, 0, infoView.width - 100, infoView.height)];
    nicknameLabel.text = @"用户昵称";
    [infoView addSubview:nicknameLabel];
    nicknameLabel.textColor = DEFAULT_COLOR;
    
    //test: 允许对战
    UIView *gameView = [self getViewWithFrame:CGRectMake(kInterval, infoView.bottom + kInterval, SCREEN_WIDTH - 2 * kInterval, 50) andTitle:@"允许对战"];
    UISwitch *gameSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(gameView.width - 50 - 25, 0, 32, 32)];
    gameSwitch.center_y = gameView.height * 0.5;
    [gameView addSubview:gameSwitch];
    [self addSubview:gameView];
    
    //test: 允许每日提醒
    UIView *dayTipView = [self getViewWithFrame:CGRectMake(kInterval, gameView.bottom + kInterval, SCREEN_WIDTH - 2 * kInterval, 50) andTitle:@"允许每日提醒"];
    UISwitch *dayTipSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(dayTipView.width - 50 - 25, 0, 32, 32)];
    dayTipSwitch.center_y = dayTipView.height * 0.5;
    [dayTipView addSubview:dayTipSwitch];
    [self addSubview:dayTipView];
    
    //换肤
    UIView *skinView = [self getViewWithFrame:CGRectMake(kInterval, dayTipView.bottom + kInterval, SCREEN_WIDTH - 2 * kInterval, 150) andTitle:@"请选择皮肤"];
    CGFloat width = (skinView.width - 4 * 10 ) / 3;
    for(int i = 0;i < 3;i++){
        UIView *skin = [[UIView alloc] initWithFrame:CGRectMake((width + 10) * i + 10, 60, width, 60)];
        skin.backgroundColor = UIColor.grayColor;
        skin.layer.cornerRadius = 20;
        skin.layer.masksToBounds = YES;
        [skinView addSubview:skin];
    }
    [self addSubview:skinView];
    
    //退出按钮
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(0, skinView.bottom + kInterval, SCREEN_WIDTH * 0.5, 40);
    logoutBtn.center_x = SCREEN_WIDTH * 0.5;
    [logoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [logoutBtn setBackgroundColor:[UIColor colorWithRed:34 / 255.0 green:204 / 255.0 blue:183 / 255.0 alpha:0.8]];
    logoutBtn.layer.cornerRadius = 20;
    logoutBtn.layer.masksToBounds = YES;
    [self addSubview:logoutBtn];
    
    
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

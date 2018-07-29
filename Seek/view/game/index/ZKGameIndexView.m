//
//  ZKGameIndexView.m
//  Seek
//
//  Created by 徐正科 on 2018/5/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameIndexView.h"

#define DEFAULT_COLOR [UIColor colorWithRed:81 / 255.0 green:81 / 255.0 blue:81 / 255.0 alpha:1.0]


static const CGFloat kInterval = 20;


@implementation ZKGameIndexView

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - TabBarHeight);
    self.backgroundColor = BACKGROUND_COLOR_STYLE_TWO;
    
    
    UIView *view1 = [self getCardWithIcon:@"game-1" background:@"bg2-1" shadowColor:[UIColor colorWithRed:77 / 255.0 green:194 / 255.0 blue:193 / 255.0 alpha:1.0] title:@"单人挑战" star:1 andViewTag:@"突破个人收藏夹" y:kInterval * 2  tag:1001];
    [self addSubview:view1];
    
    UIView *view2 = [self getCardWithIcon:@"game-2" background:@"bg2-2" shadowColor:[UIColor colorWithRed:42 / 255.0 green:46 / 255.0 blue:136 / 255.0 alpha:1.0] title:@"联机挑战" star:1 andViewTag:@"双人对抗赛" y:view1.bottom + kInterval  tag:1002];
    [self addSubview:view2];

    UIView *view3 = [self getCardWithIcon:@"game-3" background:@"bg2-3" shadowColor:[UIColor colorWithRed:139 / 255.0 green:183 / 255.0 blue:252 / 255.0 alpha:1.0] title:@"提词随机查" star:1 andViewTag:@"课本单词轻松检查" y:view2.bottom + kInterval  tag:1003];
    [self addSubview:view3];
    
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    UIView *view = (UIView *)sender.view;
    self.tagActionHandle(view.tag);
}

- (UIView *)getCardWithIcon:(NSString *)iconName background:(NSString *)bgName shadowColor:(UIColor *)color title:(NSString *)title star:(NSInteger)starCoun andViewTag:(NSString *)viewTag y:(CGFloat)y tag:(NSInteger)tag {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kInterval, 0, SCREEN_WIDTH - 2 * kInterval, 100)];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    //设置阴影
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = 0.5;
    view.layer.shadowOffset = CGSizeMake(0, 20);
    
    
    //背景
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:view.frame];
    bgImgView.x -= kInterval;
    bgImgView.image = [UIImage imageNamed:bgName];
    [view addSubview:bgImgView];
    
    //图标View
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(kInterval, kInterval * 0.5, 80, 80)];
//    iconView.backgroundColor = UIColor.whiteColor;
    iconView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    iconView.layer.cornerRadius = 40;
    iconView.layer.masksToBounds = YES;
    [view addSubview:iconView];
    
    //图标Img
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    iconImgView.center_x = iconView.width * 0.5;
    iconImgView.center_y = iconView.height * 0.5;

    iconImgView.image = [UIImage imageNamed:iconName];
    [iconView addSubview:iconImgView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.x + iconView.width + 10, iconView.y + 10, 200, 40)];
    titleLabel.text = title;
    titleLabel.textColor = UIColor.whiteColor;
//    titleLabel.backgroundColor = UIColor.blackColor;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:titleLabel];
    
    //标签View
    UIView *tagsView = [[UIView alloc] initWithFrame:titleLabel.frame];
    tagsView.y = titleLabel.bottom + 5;
    tagsView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];;
    [view addSubview:tagsView];
    
    //标签
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.x += kInterval * 0.5;
    tagLabel.y = 5;
    tagLabel.text = viewTag;
    tagLabel.font = [UIFont boldSystemFontOfSize:12];
    [tagLabel sizeToFit];
    tagLabel.textColor = color;
    [tagsView addSubview:tagLabel];
    
    tagsView.width = tagLabel.width + kInterval;
    tagsView.height = tagLabel.height + 10;
    tagsView.layer.cornerRadius = tagsView.height * 0.5;
    tagsView.layer.masksToBounds = YES;
    
    
    view.tag = tag;
    view.y = y;
    
    //手势
    UITapGestureRecognizer *tagGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapAction:)];
    [view addGestureRecognizer:tagGesture];
    
    return view;
}


@end

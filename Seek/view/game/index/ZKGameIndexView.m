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
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    
    //设置顶部主题
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60 + kInterval)];
    titleView.backgroundColor = UIColor.whiteColor;
    [self addSubview:titleView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kInterval, kInterval, SCREEN_WIDTH - 2  *kInterval, 60)];
    titleLabel.text = @"游戏大厅";
    titleLabel.textColor = DEFAULT_COLOR;
    titleLabel.font = [UIFont systemFontOfSize:25];
    [titleView addSubview:titleLabel];
    
    //设置右部编辑
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(SCREEN_WIDTH - kInterval - 32, 0, 32, 32);
    [closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    closeBtn.center_y = titleLabel.center_y;
    [titleView addSubview:closeBtn];
    
    self.closeBtn = closeBtn;
    
    
    UIView *view1 = [self getCardWithIcon:@"game-1" background:@"bg-1" shadowColor:[UIColor colorWithRed:253 / 255.0 green:145 / 255.0 blue:189 / 255.0 alpha:1.0] title:@"单人挑战" star:1 andTag:@"突破个人收藏夹"];
    view1.y = titleView.bottom + kInterval * 2;
    view1.tag = 1001;
    [self addSubview:view1];
    
    UIView *view2 = [self getCardWithIcon:@"game-2" background:@"bg-2" shadowColor:[UIColor colorWithRed:44 / 255.0 green:227 / 255.0 blue:252 / 255.0 alpha:1.0] title:@"联机挑战" star:1 andTag:@"双人对抗赛"];
    view2.y = view1.bottom + kInterval;
    view2.tag = 1002;
    [self addSubview:view2];
    
    UIView *view3 = [self getCardWithIcon:@"game-3" background:@"bg-3" shadowColor:[UIColor colorWithRed:139 / 255.0 green:183 / 255.0 blue:252 / 255.0 alpha:1.0] title:@"提词随机查" star:1 andTag:@"课本单词轻松检验"];
    view3.y = view2.bottom + kInterval;
    view3.tag = 1003;
    [self addSubview:view3];
}


- (UIView *)getCardWithIcon:(NSString *)iconName background:(NSString *)bgName shadowColor:(UIColor *)color title:(NSString *)title star:(NSInteger)starCoun andTag:(NSString *)tag {
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
    iconView.backgroundColor = UIColor.whiteColor;
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
    tagsView.backgroundColor = UIColor.whiteColor;
    [view addSubview:tagsView];
    
    //标签
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.x += kInterval * 0.5;
    tagLabel.y = 5;
    tagLabel.text = tag;
    tagLabel.font = [UIFont boldSystemFontOfSize:12];
    [tagLabel sizeToFit];
    tagLabel.textColor = color;
    [tagsView addSubview:tagLabel];
    
    tagsView.width = tagLabel.width + kInterval;
    tagsView.height = tagLabel.height + 10;
    tagsView.layer.cornerRadius = tagsView.height * 0.5;
    tagsView.layer.masksToBounds = YES;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    return view;
}


@end
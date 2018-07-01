//
//  YZTabBarView.h
//  Seek
//
//  Created by Q YiZhong on 2018/6/18.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZTabBarView;

@protocol YZTabBarViewDelegate <NSObject>

- (void)tabBarView:(YZTabBarView *)tabBarView didSelectItemAtIndex:(NSInteger)index;

@end


@interface YZTabBarView : UIView

@property (nonatomic, strong) UIButton *homeButton;
@property (nonatomic, strong) UIButton *gameButton;
@property (nonatomic, strong) UIButton *meButton;

@property (nonatomic, weak) id<YZTabBarViewDelegate> yz_delegate;

@end

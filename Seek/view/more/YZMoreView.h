//
//  YZMoreView.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZMoreTitleView.h"

@protocol YZMoreViewDelegate <NSObject>

- (void)findTitleDidTouch;


@end


@interface YZMoreView : UIView

@property(nonatomic, strong)YZMoreTitleView *findTitle;
@property(nonatomic, strong)YZMoreTitleView *likedTitle;
@property(nonatomic, strong)YZMoreTitleView *pkTitle;
@property(nonatomic, strong)YZMoreTitleView *settingTitle;


@property(nonatomic, weak)id<YZMoreViewDelegate> yz_delegate;

@end

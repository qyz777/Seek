//
//  UIViewController+YZNavigationBar.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/6.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZNavigationBar.h"

@interface UIViewController (YZNavigationBar)

@property(nonatomic, strong)YZNavigationBar *yz_navigationBar;


- (void)navigationBar;

@end

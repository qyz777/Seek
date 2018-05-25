//
//  YZDetailViewController.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSNotificationName const WordDidLikedNotification;

@interface YZDetailViewController : UIViewController

@property(nonatomic, copy)NSString *word;

- (void)setDetailViewBackgroundColor:(UIColor *)color;

@end

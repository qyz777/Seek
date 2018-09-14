//
//  YZGameInterludeViewController.h
//  Seek
//
//  Created by Q YiZhong on 2018/7/10.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^matchSuccess)(void);

@interface YZGameInterludeViewController : UIViewController

@property (nonatomic, copy) matchSuccess block;

@end

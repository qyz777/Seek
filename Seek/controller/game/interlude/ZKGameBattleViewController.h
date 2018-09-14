//
//  ZKGameBattleViewController.h
//  Seek
//
//  Created by 徐正科 on 2018/7/23.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKGameBattleView.h"

@interface ZKGameBattleViewController : UIViewController

@property(nonatomic,weak)ZKGameBattleView *battleView;

@property(nonatomic,copy)NSString *questionID;

@property(nonatomic,assign)NSInteger btnIndex;

- (void)back;

- (void)startCountDown;

@end

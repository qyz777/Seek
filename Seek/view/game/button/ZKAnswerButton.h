//
//  ZKAnswerButton.h
//  Seek
//
//  Created by 徐正科 on 2018/8/24.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

/**
 * ZK 封装答题按钮 优化效果
 */

 
#import <UIKit/UIKit.h>

static const CGFloat kInterval = 20;

@interface ZKAnswerButton : UILabel

// 选中状态
@property(nonatomic,assign)BOOL selected;


// 正确动画
- (void)rightAnimation;

// 错误动画
- (void)wrongAnimation;

@end

//
//  ZKGameAnswerTipView.h
//  Seek
//
//  Created by 徐正科 on 2018/8/24.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZKGameAnswerTipViewType) {
    ZKGameAnswerTipViewTypeRight,   //回答正确
    ZKGameAnswerTipViewTypeWrong    //回答错误
};

@interface ZKGameAnswerTipView : UIView

- (instancetype)initWithType:(ZKGameAnswerTipViewType)type;

- (void)rightAnimation;

// 外部调用接口
+ (void)showTipWithType:(ZKGameAnswerTipViewType)type;

@end

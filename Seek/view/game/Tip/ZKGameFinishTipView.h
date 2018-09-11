//
//  ZKGameFinishTipView.h
//  Seek
//
//  Created by 徐正科 on 2018/9/11.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZKGameFinishTipViewType){
    ZKGameFinishTipViewTypeWin,
    ZKGameFinishTipViewTypeLose,
    ZKGameFinishTipViewTypePing
};

@interface ZKGameFinishTipView : UIView

+ (void)showWithType:(ZKGameFinishTipViewType)type;

@end

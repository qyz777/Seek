//
//  ZKGameBattleView.h
//  Seek
//
//  Created by 徐正科 on 2018/7/24.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKGameProgressView.h"

typedef NS_ENUM(NSInteger,GameProgressType){
    GameProgressTypeLeft = 0,
    GameProgressTypeRight = 1
};

typedef void (^answerHandle)(NSInteger index);

@interface ZKGameBattleView : UIView

//关闭按钮
@property(nonatomic,weak)UIButton *closeBtn;

//当前第几题
@property(nonatomic,assign)NSInteger quesIndex;

//题目
@property(nonatomic,copy)NSString *question;

//选项
@property(nonatomic,strong)NSMutableArray *ansArray;

//答案事件
@property(nonatomic,strong)answerHandle answerHandle;

//倒计时标签
@property(nonatomic,weak)UILabel *timerLabel;

//进度条
@property(nonatomic,weak)ZKGameProgressView *leftProgress;
@property(nonatomic,weak)ZKGameProgressView *rightProgress;

@property(nonatomic,assign)BOOL isDisabled;

//设置用户信息
- (void)setLeftUserWithInfo:(NSMutableDictionary *)left andRightInfo:(NSMutableDictionary *)right;

//更新进度
- (void)setProgress:(GameProgressType)type;

@end

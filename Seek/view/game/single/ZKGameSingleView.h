//
//  ZKGameSingleView.h
//  Seek
//
//  Created by 徐正科 on 2018/5/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^answerHandle)(NSInteger index);

@interface ZKGameSingleView : UIView

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

@end

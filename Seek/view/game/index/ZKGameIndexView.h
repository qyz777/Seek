//
//  ZKGameIndexView.h
//  Seek
//
//  Created by 徐正科 on 2018/5/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tagActionHandle)(NSInteger tag);

@interface ZKGameIndexView : UIView

//关闭按钮
@property(nonatomic,weak)UIButton *closeBtn;

//block
@property(nonatomic,strong)tagActionHandle tagActionHandle;

@end

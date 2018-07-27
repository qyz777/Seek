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

//block
@property(nonatomic,strong)tagActionHandle tagActionHandle;

@end

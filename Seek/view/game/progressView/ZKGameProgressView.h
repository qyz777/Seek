//
//  ZKGameProgressView.h
//  Seek
//
//  Created by 徐正科 on 2018/9/11.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZKGameProgressViewType){
    ZKGameProgressViewTypeLeft,
    ZKGameProgressViewTypeRight
};

@interface ZKGameProgressView : UIView

@property(nonatomic,assign)ZKGameProgressViewType type;


- (void)updateProgress;

@end

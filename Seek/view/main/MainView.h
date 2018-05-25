//
//  MainView.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/5.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZWord.h"

@protocol MainViewDelegate <NSObject>

// click top arrow
- (void)arrowButtonDidClicked;
// clcik like button
- (void)likeButtonDidClickedWithWord:(NSString *)word;

@end


@interface MainView : UIView<CAAnimationDelegate>

@property(nonatomic, strong)UILabel *wordLabel;
@property(nonatomic, strong)UILabel *enSentenceLabel;
@property(nonatomic, strong)UILabel *cnSentenceLabel;
@property(nonatomic, strong)UIButton *arrowButton;
@property(nonatomic, strong)UIButton *likeButton;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UILabel *leftSymLabel;
@property(nonatomic, strong)UILabel *rightSymLabel;
@property(nonatomic, strong)UILabel *firstTranslateLabel;
@property(nonatomic, strong)UILabel *secondTranslateLabel;


@property(nonatomic, copy)YZWord *wordData;

@property(nonatomic, weak)id<MainViewDelegate> yz_delegate;


@end

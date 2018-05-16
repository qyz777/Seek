//
//  YZLoginView.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/13.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZLoginViewDelegate <NSObject>

- (void)loginBtnDidClicked;
- (void)registerBtnDidClicked;
- (void)messageBtnDidClicked;
- (void)messageFail;

@end

@interface YZLoginView : UIView

@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UITextField *userName;
@property(nonatomic, strong)UITextField *password;
@property(nonatomic, strong)UITextField *phoneNumber;
@property(nonatomic, strong)UITextField *message;
@property(nonatomic, strong)UIButton *messageBtn;
@property(nonatomic, strong)UIButton *loginBtn;
@property(nonatomic, strong)UIButton *registerBtn;
@property(nonatomic, strong)UILabel *stateLabel;

@property(nonatomic, strong)dispatch_source_t timer;

@property(nonatomic, weak)id<YZLoginViewDelegate> yz_delegate;

@end

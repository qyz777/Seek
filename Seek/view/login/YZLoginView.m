//
//  YZLoginView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/13.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZLoginView.h"

@implementation YZLoginView

- (instancetype)init {
    self = [super init];
    self.backgroundColor = BACKGROUND_COLOR_STYLE_ONE;
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
    self.isRegister = false;
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    self.imageView = [UIImageView new];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(100, 100));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(30);
    }];
    
    self.userName = [UITextField new];
    self.userName.placeholder = @"请输入手机号";
    self.userName.textColor = BACKGROUND_COLOR_STYLE_ONE;
    self.userName.backgroundColor = [UIColor whiteColor];
    self.userName.layer.cornerRadius = 12.0f;
    self.userName.keyboardType = UIKeyboardTypeNumberPad;
    UIView *nameLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
    self.userName.leftView = nameLeftView;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 40));
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(20);
    }];
    
    self.password = [UITextField new];
    self.password.placeholder = @"请输入密码";
    self.password.secureTextEntry = true;
    self.password.backgroundColor = [UIColor whiteColor];
    self.password.layer.cornerRadius = 12.0f;
    UIView *pwLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
    self.password.leftView = pwLeftView;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.password];
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 40));
        make.centerX.equalTo(self);
        make.top.equalTo(self.userName.mas_bottom).offset(18);
    }];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.backgroundColor = [UIColor whiteColor];
    [self.loginBtn setTitle:@"登入" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:30.0f];
    [self.loginBtn setTitleColor:BACKGROUND_COLOR_STYLE_ONE forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 60;
    [self.loginBtn addTarget:self action:@selector(loginBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(120, 120));
        make.top.equalTo(self.password.mas_bottom).offset(18);
        make.centerX.equalTo(self);
    }];
    
    self.stateLabel = [UILabel new];
    self.stateLabel.text = @"右扫切换到注册";
    self.stateLabel.font = [UIFont systemFontOfSize:14.0f];
    self.stateLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(100, 21));
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    self.phoneNumber = [UITextField new];
    self.phoneNumber.hidden = true;
    self.phoneNumber.textColor = BACKGROUND_COLOR_STYLE_ONE;
    self.phoneNumber.placeholder = @"请输入手机号";
    self.phoneNumber.backgroundColor = [UIColor whiteColor];
    self.phoneNumber.layer.cornerRadius = 12.0f;
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    UIView *pnLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
    self.phoneNumber.leftView = pnLeftView;
    self.phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.phoneNumber];
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 100, 40));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(80);
    }];
    
    self.message = [UITextField new];
    self.message.hidden = true;
    self.message.textColor = BACKGROUND_COLOR_STYLE_ONE;
    self.message.placeholder = @"请输入验证码";
    self.message.backgroundColor = [UIColor whiteColor];
    self.message.layer.cornerRadius = 12.0f;
    self.message.clearsOnBeginEditing = true;
    self.message.keyboardType = UIKeyboardTypeNumberPad;
    UIView *mLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
    self.message.leftView = mLeftView;
    self.message.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.message];
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH / 2, 40));
        make.left.equalTo(self).offset(50);
        make.top.equalTo(self.phoneNumber.mas_bottom).offset(10);
    }];
    
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageBtn.hidden = true;
    self.messageBtn.backgroundColor = [UIColor whiteColor];
    [self.messageBtn setTitle:@"短信验证" forState:UIControlStateNormal];
    self.messageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.messageBtn setTitleColor:BACKGROUND_COLOR_STYLE_ONE forState:UIControlStateNormal];
    self.messageBtn.layer.cornerRadius = 12.0f;
    [self.messageBtn addTarget:self action:@selector(messageBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.messageBtn];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(70, 40));
        make.centerY.equalTo(self.message);
        make.right.equalTo(self).offset(-50);
    }];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeButton:)];
    [self addGestureRecognizer:swipe];
}

- (void)loginBtnDidClicked:(id)sender {
    if ([self.loginBtn.titleLabel.text isEqualToString:@"登入"]) {
        if ([self.yz_delegate respondsToSelector:@selector(loginBtnDidClicked)]) {
            [self.yz_delegate loginBtnDidClicked];
        }
    }else {
        if ([self.yz_delegate respondsToSelector:@selector(registerBtnDidClicked)]) {
            [self.yz_delegate registerBtnDidClicked];
        }
    }
}

- (void)messageBtnDidClicked:(id)sender {
    [self.phoneNumber resignFirstResponder];
    self.isRegister = true;
    if (self.phoneNumber.text.length != 11) {
        if ([self.yz_delegate respondsToSelector:@selector(messageFail)]) {
            [self.yz_delegate messageFail];
        }
    }else {
        [self setNeedsUpdateConstraints];
        self.password.hidden = false;
        [UIView animateWithDuration:0.3f animations:^{
            [self.password mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 100, 40));
                make.centerX.equalTo(self);
                make.top.equalTo(self.message.mas_bottom).offset(10);
            }];
            [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(180, 180));
                make.top.equalTo(self.password.mas_bottom).offset(18);
                make.centerX.equalTo(self);
            }];
        }];
        [self layoutIfNeeded];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
        uint64_t interval = (uint64_t)(1 * NSEC_PER_SEC);
        dispatch_source_set_timer(self.timer, start, interval, 0);
        __block int sec = 0;
        YZWeakObject(self);
        dispatch_source_set_event_handler(weakself.timer, ^{
            sec++;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (sec == 60) {
                    weakself.messageBtn.userInteractionEnabled = true;
                    [weakself.messageBtn setTitle:@"短信验证" forState:UIControlStateNormal];
                    dispatch_source_cancel(weakself.timer);
                }else {
                    NSString *title = [NSString stringWithFormat:@"%d",sec];
                    title = [title stringByAppendingString:@"s"];
                    weakself.messageBtn.userInteractionEnabled = false;
                    [weakself.messageBtn setTitle:title forState:UIControlStateNormal];
                }
            });
        });
        dispatch_resume(self.timer);
        
        if ([self.yz_delegate respondsToSelector:@selector(messageBtnDidClicked)]) {
            [self.yz_delegate messageBtnDidClicked];
        }
    }
}

- (void)swipeButton:(UISwipeGestureRecognizer *)swipe {
    if (self.userName.isHidden) {
        [self.loginBtn setTitle:@"登入" forState:UIControlStateNormal];
        self.stateLabel.text = @"右扫切换到注册";
        self.messageBtn.hidden = true;
        self.phoneNumber.hidden = true;
        self.message.hidden = true;
        self.loginBtn.layer.cornerRadius = 60;
        [self setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.3f animations:^{
            [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(120, 120));
                make.top.equalTo(self.password.mas_bottom).offset(18);
                make.centerX.equalTo(self);
            }];
            [self.password mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 40));
                make.centerX.equalTo(self);
                make.top.equalTo(self.userName.mas_bottom).offset(18);
            }];
        }completion:^(BOOL finished) {
            self.userName.hidden = false;
            self.password.hidden = false;
            self.imageView.hidden = false;
        }];
        [self layoutIfNeeded];
    }else {
        [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        self.stateLabel.text = @"右扫切换到登入";
        self.userName.hidden = true;
        self.password.hidden = true;
        self.imageView.hidden = true;
        self.messageBtn.hidden = false;
        self.phoneNumber.hidden = false;
        self.message.hidden = false;
        self.loginBtn.layer.cornerRadius = 90;
        [self setNeedsUpdateConstraints];
        if (self.isRegister) {
            self.password.hidden = false;
            [UIView animateWithDuration:0.3f animations:^{
                [self.password mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 100, 40));
                    make.centerX.equalTo(self);
                    make.top.equalTo(self.message.mas_bottom).offset(10);
                }];
                [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_offset(CGSizeMake(180, 180));
                    make.top.equalTo(self.password.mas_bottom).offset(18);
                    make.centerX.equalTo(self);
                }];
            }];
        }else {
            [UIView animateWithDuration:0.3f animations:^{
                [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_offset(CGSizeMake(180, 180));
                    make.center.equalTo(self);
                }];
            }];
        }
        [self layoutIfNeeded];
    }
}

@end

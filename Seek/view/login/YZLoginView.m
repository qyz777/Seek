//
//  YZLoginView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/13.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZLoginView.h"
#import <SVProgressHUD.h>

@interface YZLoginView()

@property(nonatomic,weak)UIView *messageLine;

@end

@implementation YZLoginView

- (instancetype)init {
    self = [super init];    
    self.backgroundColor = UIColorFromRGB(0x2c3b49);
//    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
    self.frame = [UIScreen mainScreen].bounds;
    self.isRegister = false;
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    // 背景图
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"login-bg"]];
    bgImgView.frame = [UIScreen mainScreen].bounds;
    bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImgView];
    
    // Seek
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 40)];
    logoLabel.text = @"Seek";
    logoLabel.textColor = UIColor.whiteColor;
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.font = [UIFont boldSystemFontOfSize:40];
    [self addSubview:logoLabel];
    
    self.imageView = [UIImageView new];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(100, 100));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(30);
    }];
    
    self.userName = [UITextField new];
    self.userName.placeholder = @"手机号";
    self.userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor}];
    self.userName.textColor = UIColor.whiteColor;
//    self.userName.backgroundColor = [UIColor whiteColor];
    self.userName.layer.cornerRadius = 20.0f;
//    self.userName.textAlignment = NSTextAlignmentCenter;
    self.userName.keyboardType = UIKeyboardTypeNumberPad;
//    UIView *nameLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
//    self.userName.leftView = nameLeftView;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 40));
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(100);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = UIColor.lightGrayColor;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 1));
        make.centerX.equalTo(self);
        make.top.equalTo(self.userName.mas_bottom).offset(2);
    }];
    
    
    self.password = [UITextField new];
    self.password.placeholder = @"密码";
    self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor}];

    self.password.secureTextEntry = true;
//    self.password.backgroundColor = [UIColor whiteColor];
    self.password.textColor = UIColor.whiteColor;
    self.password.layer.cornerRadius = 20.0f;
//    self.password.textAlignment = NSTextAlignmentCenter;
//    UIView *pwLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
//    self.password.leftView = pwLeftView;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.password];
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 40));
        make.centerX.equalTo(self);
        make.top.equalTo(self.userName.mas_bottom).offset(18);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = UIColor.lightGrayColor;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 1));
        make.centerX.equalTo(self);
        make.top.equalTo(self.password.mas_bottom).offset(2);
    }];
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.backgroundColor = [UIColor whiteColor];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.loginBtn setTitleColor:UIColorFromRGB(0x9977db) forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 25.0f;
    [self.loginBtn addTarget:self action:@selector(loginBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 50));
        make.top.equalTo(self.password.mas_bottom).offset(18);
        make.centerX.equalTo(self);
    }];
    
    self.stateLabel = [UILabel new];
    self.stateLabel.text = @"注册";
    self.stateLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(100, 21));
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    self.stateLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *registerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeStatus)];
    [self.stateLabel addGestureRecognizer:registerTap];
    
    self.phoneNumber = [UITextField new];
    self.phoneNumber.hidden = true;
    self.phoneNumber.textColor = UIColor.whiteColor;
    self.phoneNumber.placeholder = @"手机号";
    self.phoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor}];
//    self.phoneNumber.backgroundColor = [UIColor whiteColor];
    self.phoneNumber.layer.cornerRadius = 20.0f;
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
//    UIView *pnLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
//    self.phoneNumber.leftView = pnLeftView;
    self.phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.phoneNumber];
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 40));
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(100);
    }];
    
    self.message = [UITextField new];
    self.message.textColor = UIColor.whiteColor;
    self.message.placeholder = @"验证码";
    self.message.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"验证码" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor}];
//    self.message.backgroundColor = [UIColor whiteColor];
//    self.message.layer.cornerRadius = 20.0f;
    self.message.clearsOnBeginEditing = true;
    self.message.keyboardType = UIKeyboardTypeNumberPad;
//    UIView *mLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
//    self.message.leftView = mLeftView;
    self.message.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.message];
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH / 2, 40));
        make.left.equalTo(self.phoneNumber);
        make.top.equalTo(self.password.mas_bottom).offset(18);
    }];
    self.message.hidden = true;

    
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.messageBtn.backgroundColor = [UIColor whiteColor];
    [self.messageBtn setTitle:@"短信验证" forState:UIControlStateNormal];
    self.messageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
//    [self.messageBtn setTitleColor:BACKGROUND_COLOR_STYLE_ONE forState:UIControlStateNormal];
    [self.messageBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.messageBtn.layer.cornerRadius = 12.0f;
    [self.messageBtn addTarget:self action:@selector(messageBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.messageBtn];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(70, 40));
        make.centerY.equalTo(self.message);
        make.right.equalTo(self).offset(-50);
    }];
    self.messageBtn.hidden = true;
    
    UIView *line3 = [[UIView alloc] init];
    line3.hidden = YES;
    line3.backgroundColor = UIColor.lightGrayColor;
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 2));
        make.centerX.equalTo(self);
        make.top.equalTo(self.message.mas_bottom).offset(2);
    }];
    
    self.messageLine = line3;
    
}

- (void)loginBtnDidClicked:(id)sender {
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    [self.message resignFirstResponder];
    [self.phoneNumber resignFirstResponder];
    
    if ([self.loginBtn.titleLabel.text isEqualToString:@"登录"]) {
        if (self.userName.text.length == 0 || self.password.text == 0) {
            [SVProgressHUD showErrorWithStatus:@"手机号和密码不能为空"];
            return ;
        }
        
        if ([self.yz_delegate respondsToSelector:@selector(loginBtnDidClicked)]) {
            [self.yz_delegate loginBtnDidClicked];
        }
    }else {
        if (self.message.text.length == 0 || self.password.text == 0 || self.phoneNumber.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的注册信息"];
            return ;
        }
        
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
//            [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.size.mas_offset(CGSizeMake(180, 180));
//                make.top.equalTo(self.password.mas_bottom).offset(18);
//                make.centerX.equalTo(self);
//            }];
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

- (void)changeStatus {
    YZLog(@"change");
    if (self.userName.isHidden) {
//        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        self.stateLabel.text = @"注册";
        self.messageBtn.hidden = true;
        self.phoneNumber.hidden = true;
        self.message.hidden = true;
        self.messageLine.hidden = true;
//        self.loginBtn.layer.cornerRadius = 60;
        [self setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.3f animations:^{
            [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 50));
                make.top.equalTo(self.password.mas_bottom).offset(18);
                make.centerX.equalTo(self);
            }];
            [self layoutIfNeeded];
            
//            [self.password mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 40));
//                make.centerX.equalTo(self);
//                make.top.equalTo(self.userName.mas_bottom).offset(18);
//            }];
        }completion:^(BOOL finished) {
            self.userName.hidden = false;
            self.password.hidden = false;
            self.imageView.hidden = false;
        }];
        [self layoutIfNeeded];
    }else {
//        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        self.stateLabel.text = @"登录";
        self.userName.hidden = true;
        self.password.hidden = false;
//        self.imageView.hidden = true;
//        self.messageBtn.hidden = false;
        self.phoneNumber.hidden = false;
//        self.message.hidden = false;
//        self.messageLine.hidden = false;
//        self.loginBtn.layer.cornerRadius = 90;
        [self setNeedsUpdateConstraints];
        if (self.isRegister) {
//            self.password.hidden = false;
            [UIView animateWithDuration:0.3f animations:^{
//                [self.password mas_remakeConstraints:^(MASConstraintMaker *make) {
//                    make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 100, 40));
//                    make.centerX.equalTo(self);
//                    make.top.equalTo(self.message.mas_bottom).offset(10);
//                }];
                [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 50));
                    make.top.equalTo(self.message.mas_bottom).offset(18);
                    make.centerX.equalTo(self);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.messageBtn.hidden = false;
                self.message.hidden = false;
                self.messageLine.hidden = false;
            }];
        }else {
            [UIView animateWithDuration:0.3f animations:^{
                [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_offset(CGSizeMake(SCREEN_WIDTH - 120, 50));
                    make.top.equalTo(self.message.mas_bottom).offset(18);
                    make.centerX.equalTo(self);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.messageBtn.hidden = false;
                self.message.hidden = false;
                self.messageLine.hidden = false;
                
            }];
        }
    }
}

@end

//
//  YZLoginViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/13.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZLoginViewController.h"
#import "YZLoginView.h"
#import "UIViewController+YZNavigationBar.h"
#import <SMS_SDK/SMSSDK.h>

@interface YZLoginViewController ()<YZLoginViewDelegate>

@property(nonatomic, strong)YZLoginView *loginView;

@end

@implementation YZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationBar];
    self.yz_navigationBar.backgroundColor = BACKGROUND_COLOR_STYLE_ONE;
    self.loginView = [[YZLoginView alloc]init];
    self.loginView.yz_delegate = self;
    [self.view addSubview:self.loginView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.loginView.userName resignFirstResponder];
    [self.loginView.password resignFirstResponder];
    [self.loginView.message resignFirstResponder];
    [self.loginView.phoneNumber resignFirstResponder];
}

#pragma make - yzdelegate
- (void)loginBtnDidClicked {
    
}

- (void)registerBtnDidClicked {
    NSString *code = self.loginView.message.text;
    [SMSSDK commitVerificationCode:code phoneNumber:self.loginView.phoneNumber.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            
        }else {
            YZLog(@"%@",error);
        }
    }];
}

- (void)messageBtnDidClicked {
    NSString *phone = self.loginView.phoneNumber.text;
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phone zone:@"86" result:^(NSError *error) {
        if (error) {
            YZLog(@"%@",error);
        }
    }];
}

- (void)messageFail {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号填写有误" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:true completion:nil];
}

@end

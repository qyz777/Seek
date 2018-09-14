//
//  YZGameInterludeViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/10.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZGameInterludeViewController.h"
#import "YZGameInterludeFindView.h"
#import "User.h"
#import "WebSocketManager.h"

@interface YZGameInterludeViewController ()<WebSocketManagerDelegate>

@property (nonatomic, strong) YZGameInterludeFindView *findBackView;
@property (nonatomic, strong) UIView *findTopView;
@property (nonatomic, strong) UILabel *findLabel;
@property (nonatomic, strong) UIButton *quitBtn;

@property (nonatomic,weak)UIImageView *battleUserImg;

// webSocket
//@property (nonatomic, strong) SRWebSocket *socket;
//@property (nonatomic,strong)dispatch_queue_t socketQueue;

@end

@implementation YZGameInterludeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [WebSocketManager manager].socket_delegate = self;
    [self initView];
    
    [self.quitBtn addTarget:self action:@selector(quitBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //开始真正匹配游戏
    [self matchingStart];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)initView {
    CAGradientLayer *backLayer = [CAGradientLayer layer];
    backLayer.frame = self.view.bounds;
    [backLayer setColors:@[(id)[UIColorFromRGB(0xc24ca1) CGColor],
                           (id)[UIColorFromRGB(0xbd49d4) CGColor],
                           (id)[UIColorFromRGB(0x8a52cb) CGColor]]];
    [backLayer setLocations:@[@0.35, @0.75, @1.0]];
    [backLayer setStartPoint:CGPointMake(0, 0)];
    [backLayer setEndPoint:CGPointMake(0.4, 1)];
    [self.view.layer addSublayer:backLayer];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    effectView.frame = self.view.frame;
    [self.view addSubview:effectView];
    
    [self.view addSubview:self.findBackView];
    [self.view addSubview:self.findTopView];
    [self.findTopView addSubview:self.findLabel];
    [self.view addSubview:self.quitBtn];
    
    [self.findBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(150);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(180, 180));
    }];
    
    [self.findTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(150);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(180, 180));
    }];
    
    [self.findLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.findTopView);
    }];
    
    [self.quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-70);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(180, 44));
    }];
    
    //匹配成功头像
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_icon"]];
    imgView.frame = CGRectMake(0, 0, 50, 50);
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = 25;
    imgView.backgroundColor = [UIColor whiteColor];
    imgView.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5 + 50);
    imgView.alpha = 0;

    [self.view addSubview:imgView];
    self.battleUserImg = imgView;
    
}

- (void)quitBtnDidClicked:(id)sender {
    // 先关闭链接
    [[WebSocketManager manager] stop];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)matchingStart {
    [[WebSocketManager manager] startMatching];
}

// 匹配成功,即将开始
- (void)gameShouldBegin {
    [UIView animateWithDuration:1 animations:^{
        self.battleUserImg.alpha = 1;
    }completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.block) {
                self.block();
            }
        }];
    }];
}

#pragma mark - getter
- (YZGameInterludeFindView *)findBackView {
    if (!_findBackView) {
        _findBackView = [[YZGameInterludeFindView alloc]init];
    }
    return _findBackView;
}

- (UIView *)findTopView {
    if (!_findTopView) {
        _findTopView = [UIView new];
        _findTopView.backgroundColor = [UIColor whiteColor];
        _findTopView.layer.cornerRadius = 90;
    }
    return _findTopView;
}

- (UILabel *)findLabel {
    if (!_findLabel) {
        _findLabel = [UILabel new];
        _findLabel.text = @"匹配中...";
        _findLabel.textColor = UIColorFromRGB(0x703691);
        _findLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    }
    return _findLabel;
}

- (UIButton *)quitBtn {
    if (!_quitBtn) {
        _quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _quitBtn.layer.cornerRadius = 20.0f;
        _quitBtn.backgroundColor = [UIColor whiteColor];
        [_quitBtn setTitleColor:UIColorFromRGB(0x703691) forState:UIControlStateNormal];
        _quitBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        [_quitBtn setTitle:@"取消匹配" forState:UIControlStateNormal];
    }
    return _quitBtn;
}


@end

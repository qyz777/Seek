//
//  YZGameInterludeViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/10.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZGameInterludeViewController.h"
#import "YZGameInterludeFindView.h"

@interface YZGameInterludeViewController ()

@property (nonatomic, strong) YZGameInterludeFindView *findBackView;
@property (nonatomic, strong) UIView *findTopView;
@property (nonatomic, strong) UILabel *findLabel;
@property (nonatomic, strong) UIButton *quitBtn;

@end

@implementation YZGameInterludeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    [self.quitBtn addTarget:self action:@selector(quitBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initView {
    CAGradientLayer *backLayer = [CAGradientLayer layer];
    backLayer.frame = self.view.bounds;
    [backLayer setColors:@[(id)[UIColorFromRGB(0x703691) CGColor], (id)[UIColorFromRGB(0xaa66d1) CGColor]]];
    [backLayer setLocations:@[@0.5, @1.0]];
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
}

- (void)quitBtnDidClicked:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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

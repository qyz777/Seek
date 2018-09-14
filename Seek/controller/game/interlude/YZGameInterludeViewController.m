//
//  YZGameInterludeViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/10.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZGameInterludeViewController.h"
#import "YZGameInterludeFindView.h"
#import "ZKGameBattleViewController.h"
#import "User.h"
#import <SVProgressHUD.h>
#import "ZKGameFinishTipView.h"
#import "ZKSingleGameModel.h"
#import "WebSocketManager.h"

@interface YZGameInterludeViewController ()<WebSocketManagerDelegate>

@property (nonatomic, strong) YZGameInterludeFindView *findBackView;
@property (nonatomic, weak) ZKGameBattleViewController *battleVC;
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

/**
 * ZK 集成WebSocket 对战功能
 */
- (void)matchingStart {
    [[WebSocketManager manager] startMatching];
}

// 匹配成功,即将开始
- (void)gameShouldBegin {
    [UIView animateWithDuration:1 animations:^{
        self.battleUserImg.alpha = 1;
    }];
    
    //一秒等待时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ZKGameBattleViewController *battleVC = [[ZKGameBattleViewController alloc] init];
        self.battleVC = battleVC;

        [self presentViewController:battleVC animated:YES completion:nil];
//        NSNotification *notification = [NSNotification notificationWithName:@"beginPK" object:nil];
        
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
//        [self dismissViewControllerAnimated:NO completion:nil];
        
    });
}

//开始答题 题目和倒计时的初始化
- (void)refreshQuestionWithData:(NSDictionary *)data {
    YZLog(@"换题目");
    //开始倒计时
    [self.battleVC startCountDown];
    self.battleVC.questionID = data[@"id"];
    
    
    ZKGameBattleView *view = self.battleVC.battleView;
    //重置选中答案
    NSInteger btnIndex = self.battleVC.btnIndex;
    if ( btnIndex != 0) {
        [(UILabel *)[view viewWithTag:btnIndex] setBackgroundColor:UIColor.whiteColor];
    }
    
    view.question = data[@"title"];
    view.ansArray = [@[
                      data[@"A"],
                      data[@"B"],
                      data[@"C"],
                      data[@"D"]
                      ] mutableCopy];
    
}

// 每个题目的结果
- (void)questionAnswerWithData:(NSDictionary *)data {
    if ([data[@"uid"] integerValue] == [User sharedUser].userId) {
        if ([data[@"is_right"] integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"回答正确"];
            [self.battleVC.battleView.leftProgress updateProgress];
        }else if([data[@"is_right"] integerValue] == 0){
            [SVProgressHUD showErrorWithStatus:@"回答错误"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else{
        //对方回答
        if ([data[@"is_right"] integerValue] == 1) {
            [self.battleVC.battleView.rightProgress updateProgress];
        }
    }
}

// 答题结果
- (void)finishWithData:(NSDictionary *)data {
    NSMutableDictionary *scoreData = [data[@"data"][@"round_info"][@"titi_rounds_detail"] mutableCopy];
    
    NSInteger myScore = 0;
    NSInteger otherScore = 0;
    NSInteger score = 0;
    NSInteger userID = [User sharedUser].userId;
    
    //遍历一层字典
    NSLog(@"111");
    NSArray *keys1 = [scoreData allKeys];
    for(int i = 0;i < [keys1 count];i++){
//        score = 0;
        //二层遍历
        NSArray *detailArray = (NSArray *)[scoreData objectForKey:keys1[i]];

        for(int j = 0;j < [detailArray count];j++){
            NSDictionary *dict2 = (NSDictionary *)[detailArray objectAtIndex:j];
            score += [dict2[@"is_score"] integerValue];
        }
        if ([keys1[i] isEqualToString:[NSString stringWithFormat:@"%ld",userID]]) {
            myScore = score;
        }else{
            otherScore = score;
        }
    }
    
    if (myScore > otherScore) {
//        [SVProgressHUD showSuccessWithStatus:@"恭喜您战胜了对方 :)"];
        [ZKGameFinishTipView showWithType:ZKGameFinishTipViewTypeWin];
        [ZKSingleGameModel finishGame:@"win"];

    }else if(myScore < otherScore){
//        [SVProgressHUD showErrorWithStatus:@"失败了，继续加油！"];
        [ZKGameFinishTipView showWithType:ZKGameFinishTipViewTypeLose];
        [ZKSingleGameModel finishGame:@"lose"];

    }else{
//        [SVProgressHUD showErrorWithStatus:@"平局，加油吧！"];
        [ZKGameFinishTipView showWithType:ZKGameFinishTipViewTypePing];
        [ZKSingleGameModel finishGame:@"ping"];

    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //两秒后退出游戏
        [self.battleVC back];
    });
}

- (void)otherDidLogout {
    [SVProgressHUD showErrorWithStatus:@"对方已经退出游戏"];
}

- (void)matchingError {
    [SVProgressHUD showErrorWithStatus:@"请检查网络设置"];
}

@end

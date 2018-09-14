//
//  ZKGameBattleViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/7/23.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameBattleViewController.h"
#import "WebSocketManager.h"
#import "ZKGameFinishTipView.h"
#import "ZKSingleGameModel.h"

@interface ZKGameBattleViewController ()<WebSocketManagerDelegate>

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,assign)BOOL disabled;

@end

@implementation ZKGameBattleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [WebSocketManager manager].socket_delegate = self;
    self.disabled = false;
    
    NSMutableDictionary *playAData = [self.playData[@"data"][@"player_a"] mutableCopy];
    NSMutableDictionary *playBData = [self.playData[@"data"][@"player_b"] mutableCopy];
    playAData[@"header"] = @"default_icon";
    playBData[@"header"] = @"default_icon";
    
    ZKGameBattleView *battleView = [[ZKGameBattleView alloc] init];
    [battleView setLeftUserWithInfo:playAData andRightInfo:playBData];
    [self startCountDown];
    [battleView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:battleView];
    self.battleView = battleView;
    
    __weak typeof(self) weakSelf = self;
    [_battleView setAnswerHandle:^(NSInteger index) {
        weakSelf.btnIndex = index;
        
        UILabel *btn = (UILabel *)[weakSelf.battleView viewWithTag:index];
        btn.backgroundColor = UIColor.lightGrayColor;
        
        NSInteger newIndex = index - 1001;
        char ansCh = 'A' + newIndex;
        
        // 回答问题
        YZLog(@"回答问题!!!!!");
        NSString *data = [NSString stringWithFormat:@"{\"type\":\"answer\",\"uid\":\"%ld\",\"questions_id\":\"%@\",\"answer\":\"%c\"}",[User sharedUser].userId,weakSelf.questionID,ansCh];
        [[WebSocketManager manager] sendData:data];
    }];
    [SVProgressHUD show];
}

- (void)startCountDown {
    if(self.timer != nil){
        [self stopCountDown];
    }
    _battleView.timerLabel.text = @"20";
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerLabelChanged) userInfo:nil repeats:YES];
    self.disabled = NO;
}

- (void)stopCountDown {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timerLabelChanged {
    NSInteger index = [_battleView.timerLabel.text integerValue];
    if (index == 0) {
        return ;
    }
    _battleView.timerLabel.text = [NSString stringWithFormat:@"%ld",index - 1];
}

- (void)closeAction {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出游戏嘛" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //退出
        [self back];
    }];
    
    UIAlertAction *cancelA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertC addAction:confirmA];
    [alertC addAction:cancelA];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

//退出
- (void)back {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [[WebSocketManager manager] stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - WebSocketManagerDelegate
//开始答题 题目和倒计时的初始化
- (void)refreshQuestionWithData:(NSDictionary *)data {
    [SVProgressHUD dismiss];
    YZLog(@"换题目");
    YZLog(@"%@",data);
    //开始倒计时
    [self startCountDown];
    self.questionID = data[@"id"];
    
    self.battleView.isDisabled = NO;
    
    
    ZKGameBattleView *view = self.battleView;
    //重置选中答案
    NSInteger btnIndex = self.btnIndex;
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
            [self.battleView.leftProgress updateProgress];
        }else if([data[@"is_right"] integerValue] == 0){
            [SVProgressHUD showErrorWithStatus:@"回答错误"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else{
        //对方回答
        if ([data[@"is_right"] integerValue] == 1) {
            [self.battleView.rightProgress updateProgress];
        }
    }
}

// 答题结果
- (void)finishWithData:(NSDictionary *)data {
    NSInteger myScore = self.battleView.leftProgress.length;
    NSInteger otherScore = self.battleView.rightProgress.length;
    
    if (myScore > otherScore) {
        [ZKGameFinishTipView showWithType:ZKGameFinishTipViewTypeWin];
        [ZKSingleGameModel finishGame:@"win"];
        
    }else if(myScore < otherScore) {
        [ZKGameFinishTipView showWithType:ZKGameFinishTipViewTypeLose];
        [ZKSingleGameModel finishGame:@"lose"];
        
    }else {
        [ZKGameFinishTipView showWithType:ZKGameFinishTipViewTypePing];
        [ZKSingleGameModel finishGame:@"ping"];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //两秒后退出游戏
        [self back];
    });
}

- (void)otherDidLogout {
    [SVProgressHUD showErrorWithStatus:@"对方已经退出游戏"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self back];
    });
}

- (void)matchingError {
    [SVProgressHUD showErrorWithStatus:@"请检查网络设置"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self back];
    });
}

@end

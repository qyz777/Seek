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
    
    ZKGameBattleView *battleView = [[ZKGameBattleView alloc] init];
    [battleView setLeftUserWithInfo:[@{
                                      @"header": @"default_icon",
                                      @"name": @"戚戚戚"
                                      } mutableCopy] andRightInfo:[@{
                                                       @"header": @"default_icon",
                                                       @"name": @"李Lucky"
                                                       } mutableCopy]];
    [self startCountDown];
    [battleView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:battleView];
    self.battleView = battleView;
    
    __weak typeof(self) weakSelf = self;
    [_battleView setAnswerHandle:^(NSInteger index) {
        if (!weakSelf.disabled) {
            weakSelf.btnIndex = index;
            
            UILabel *btn = (UILabel *)[weakSelf.battleView viewWithTag:index];
            btn.backgroundColor = UIColor.lightGrayColor;
            
            NSInteger newIndex = index - 1001;
            char ansCh = 'A' + newIndex;
            
            // 回答问题
            YZLog(@"回答问题!!!!!");
            NSString *data = [NSString stringWithFormat:@"{\"type\":\"answer\",\"uid\":\"%ld\",\"questions_id\":\"%@\",\"answer\":\"%c\"}",[User sharedUser].userId,weakSelf.questionID,ansCh];
            [[WebSocketManager manager] sendData:data];
            weakSelf.disabled = YES;
        }
    }];
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
    YZLog(@"换题目");
    YZLog(@"%@",data);
    //开始倒计时
    [self startCountDown];
    self.questionID = data[@"id"];
    
    
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
//    NSMutableDictionary *scoreData = [data[@"data"][@"round_info"][@"titi_rounds_detail"] mutableCopy];
//    
//    NSInteger myScore = 0;
//    NSInteger otherScore = 0;
//    NSInteger score = 0;
//    NSInteger userID = [User sharedUser].userId;
//    
//    //遍历一层字典
//    NSLog(@"111");
//    NSArray *keys1 = [scoreData allKeys];
//    for(int i = 0;i < [keys1 count];i++){
//        //        score = 0;
//        //二层遍历
//        NSArray *detailArray = (NSArray *)[scoreData objectForKey:keys1[i]];
//        
//        for(int j = 0;j < [detailArray count];j++){
//            NSDictionary *dict2 = (NSDictionary *)[detailArray objectAtIndex:j];
//            score += [dict2[@"is_score"] integerValue];
//        }
//        if ([keys1[i] isEqualToString:[NSString stringWithFormat:@"%ld",userID]]) {
//            myScore = score;
//        }else{
//            otherScore = score;
//        }
//    }
    
    NSInteger myScore = self.battleView.leftProgress.length;
    NSInteger otherScore = self.battleView.rightProgress.length;
    
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

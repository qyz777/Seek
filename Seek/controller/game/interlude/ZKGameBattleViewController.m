//
//  ZKGameBattleViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/7/23.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameBattleViewController.h"
#import "YZGameInterludeViewController.h"

@interface ZKGameBattleViewController ()

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,weak)YZGameInterludeViewController *interludeVC;

@end

@implementation ZKGameBattleViewController

- (void)viewWillAppear:(BOOL)animated {
    self.interludeVC = (YZGameInterludeViewController *)self.presentingViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZKGameBattleView *battleView = [[ZKGameBattleView alloc] init];
    [battleView setLeftUserWithInfo:[@{
                                      @"header": @"100",
                                      @"name": @"戚戚戚"
                                      } mutableCopy] andRightInfo:[@{
                                                       @"header": @"200",
                                                       @"name": @"李Lucky"
                                                       } mutableCopy]];
    [self startCountDown];
    [battleView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:battleView];
    self.battleView = battleView;
    
    __weak typeof(self) weakSelf = self;
    
    [_battleView setAnswerHandle:^(NSInteger index) {
        
        __strong typeof(self) strongSelf = weakSelf;
        
        strongSelf.btnIndex = index;
        
        UILabel *btn = (UILabel *)[strongSelf.battleView viewWithTag:index];
        btn.backgroundColor = UIColor.lightGrayColor;
        
        NSInteger newIndex = index - 1001;
        char ansCh = 'A' + newIndex;
        
        // 回答问题
        NSString *data = [NSString stringWithFormat:@"{\"type\":\"answer\",\"uid\":\"%ld\",\"questions_id\":\"%@\",\"answer\":\"%c\"}",[User sharedUser].userId,strongSelf.questionID,ansCh];
        [strongSelf.interludeVC sendData:data];
    }];
}

- (void)startCountDown {
    if(self.timer != nil){
        [self stopCountDown];
    }
    _battleView.timerLabel.text = @"20";
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerLabelChanged) userInfo:nil repeats:YES];
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
    UIViewController *lastVC = self.presentingViewController;
    
    [self dismissViewControllerAnimated:YES completion:^{
        [lastVC dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

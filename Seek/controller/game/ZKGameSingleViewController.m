//
//  ZKGameSingleViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/5/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameSingleViewController.h"
#import "ZKGameSingleView.h"
#import "ZKSingleGameModel.h"
#import "ZKAnswerButton.h"
#import "ZKGameAnswerTipView.h"

//当前题目
 NSInteger questionIndex = 0;
//答对几道题
static NSInteger rightAns = 0;

@interface ZKGameSingleViewController ()

@property(nonatomic,strong)NSMutableArray *resArray;
@property(nonatomic,weak)ZKGameSingleView *singleView;

@end

@implementation ZKGameSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    ZKGameSingleView *singleView = [[ZKGameSingleView alloc] init];
    [self.view addSubview:singleView];
    self.singleView = singleView;
    
    [singleView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    //弱引用 防止循环引用
    __weak typeof(self) weakSelf = self;
    
    [singleView setAnswerHandle:^(NSInteger index) {
        //响应答题操作
        [weakSelf answerQuestionWithAns:index];
    }];
    
    //请求数据
    [SVProgressHUD show];
    [ZKSingleGameModel getSingleSystemWithSuccess:^(NSMutableArray *resArray) {
        [SVProgressHUD dismiss];
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.resArray = resArray;
        [strongSelf updateQuestion];
    } failure:^(NSError *error) {
        NSLog(@"请求数据失败");
        [SVProgressHUD dismiss];
        [SVProgressHUD showWithStatus:@"网络请求失败"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }];
    
}

//更新题目
- (void)updateQuestion {
    _singleView.question = [self.resArray[questionIndex][@"question"][0] copy];
    _singleView.ansArray = [self.resArray[questionIndex][@"answers"] mutableCopy];
    NSInteger trueIndex = [self.resArray[questionIndex][@"choose"] intValue];
    NSLog(@"当前答案,%ld",trueIndex);
}

//答题
- (void)answerQuestionWithAns:(NSInteger)index {
    if(questionIndex >= 4){
        //当前已经答完题目了
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"答题完成,共答对%ld道题",(long)rightAns]];
        [SVProgressHUD dismissWithDelay:2.0f];
        return ;
        return ;
    }
    
    // 获取点击的Btn
    ZKAnswerButton *answerBtn = (ZKAnswerButton *)[self.singleView viewWithTag:index];
    
    NSInteger trueIndex = [self.resArray[questionIndex][@"choose"] intValue];
    if (trueIndex + 1001 == index) {
        //回答正确
        rightAns++;
        [answerBtn rightAnimation];
        [ZKGameAnswerTipView showTipWithType:ZKGameAnswerTipViewTypeRight];
    }else{
        //回答错误
        [answerBtn wrongAnimation];
        [ZKGameAnswerTipView showTipWithType:ZKGameAnswerTipViewTypeWrong];
    }
    questionIndex++;

    // 延时换题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateQuestion];
    });
}

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

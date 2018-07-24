//
//  ZKGameBattleViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/7/23.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameBattleViewController.h"
#import "ZKGameBattleView.h"

@interface ZKGameBattleViewController ()

@end

@implementation ZKGameBattleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZKGameBattleView *battleView = [[ZKGameBattleView alloc] init];
    
    [self.view addSubview:battleView];
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

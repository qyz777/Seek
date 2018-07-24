//
//  ZKGameIndexViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/5/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameIndexViewController.h"
#import "ZKGameIndexView.h"
#import "ZKGameSingleViewController.h"
#import "ZKGameBattleViewController.h"
#import "YZGameInterludeViewController.h"

@interface ZKGameIndexViewController ()

@end

@implementation ZKGameIndexViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZKGameIndexView *indexView = [[ZKGameIndexView alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:indexView];
    
    [indexView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [indexView setTagActionHandle:^(NSInteger tag) {
        switch (tag) {
            case 1001:{
                    ZKGameSingleViewController *singleVC = [[ZKGameSingleViewController alloc] init];
                    [self presentViewController:singleVC animated:YES completion:nil];
                }
                break;
            case 1002:{
                    YZGameInterludeViewController *findVC = [[YZGameInterludeViewController alloc] init];
                    [self presentViewController:findVC animated:YES completion:nil];    
                }
                break;
            case 1003:{
                    //测试
                    ZKGameBattleViewController *battleVC = [[ZKGameBattleViewController alloc] init];
                    [self presentViewController:battleVC animated:YES completion:nil];
                
                    [SVProgressHUD showInfoWithStatus:@"此功能暂未开放"];
                    [SVProgressHUD dismissWithDelay:1.5f];
                }
                break;
            default:
                break;
        }
    }];
}

- (void)loadingTap {
    
}

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

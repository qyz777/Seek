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

@interface ZKGameIndexViewController ()

@end

@implementation ZKGameIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZKGameIndexView *indexView = [[ZKGameIndexView alloc] init];
    self.view = indexView;
    
    [indexView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [indexView setTagActionHandle:^(NSInteger tag) {
        switch (tag) {
            case 1001:{
                    ZKGameSingleViewController *singleVC = [[ZKGameSingleViewController alloc] init];
                    [self presentViewController:singleVC animated:YES completion:nil];
                }
                break;
            case 1002:
            case 1003:
                [SVProgressHUD showInfoWithStatus:@"此功能暂未开放"];
                [SVProgressHUD dismissWithDelay:1.5f];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

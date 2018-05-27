//
//  ZKSettingViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/5/26.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKSettingViewController.h"
#import "ZKSettingView.h"

@interface ZKSettingViewController ()

@end

@implementation ZKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZKSettingView *settingView = [[ZKSettingView alloc] init];
    [settingView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = settingView;
}


- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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

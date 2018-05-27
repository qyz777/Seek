//
//  ZKGameIndexViewController.m
//  Seek
//
//  Created by 徐正科 on 2018/5/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameIndexViewController.h"
#import "ZKGameIndexView.h"

@interface ZKGameIndexViewController ()

@end

@implementation ZKGameIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZKGameIndexView *indexView = [[ZKGameIndexView alloc] init];
    self.view = indexView;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

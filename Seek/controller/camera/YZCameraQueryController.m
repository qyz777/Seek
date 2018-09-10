//
//  YZCameraQueryController.m
//  Seek
//
//  Created by Q YiZhong on 2018/9/8.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZCameraQueryController.h"
#import "YZSearchTableView.h"
#import "YZWordDetailViewController.h"
#import <SVProgressHUD.h>

@interface YZCameraQueryController ()<YZSearchTableViewDelegate>

@property (nonatomic, strong) YZSearchTableView *tableView;

@end

@implementation YZCameraQueryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)initView {
    self.yz_navigationBar.navigationBarColor = BACKGROUND_COLOR_STYLE_TWO;
    [self.yz_navigationBar addCenterTitleLabelWithTitle:@"提取的单词" font:[UIFont systemFontOfSize:18] color:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
    
    [SVProgressHUD showSuccessWithStatus:@"已过滤无意义单词，请留意"];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    self.tableView.dataArray = _dataArray.copy;
    [self.tableView reloadData];
}

#pragma mark - YZSearchTableViewDelegate
- (void)cellDidSelectWithDict:(NSDictionary*)dict {
    YZWordDetailViewController *vc = [YZWordDetailViewController new];
    vc.word = dict[@"entry"];
    [self.navigationController pushViewController:vc animated:true];
}

- (YZSearchTableView *)tableView {
    if (!_tableView) {
        _tableView = [[YZSearchTableView alloc] init];
        _tableView.yz_delegate = self;
    }
    return _tableView;
}

@end

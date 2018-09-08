//
//  YZCameraQueryController.m
//  Seek
//
//  Created by Q YiZhong on 2018/9/8.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZCameraQueryController.h"
#import "YZSearchTableView.h"

@interface YZCameraQueryController ()

@property (nonatomic, strong) YZSearchTableView *tableView;

@end

@implementation YZCameraQueryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.yz_navigationBar.navigationBarColor = BACKGROUND_COLOR_STYLE_TWO;
    [self.view addSubview:self.tableView];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    self.tableView.dataArray = _dataArray.copy;
    [self.tableView reloadData];
}

- (YZSearchTableView *)tableView {
    if (!_tableView) {
        _tableView = [[YZSearchTableView alloc] init];
    }
    return _tableView;
}

@end

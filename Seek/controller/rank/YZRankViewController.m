//
//  YZRankViewController.m
//  Seek
//
//  Created by Q YiZhong on 2018/9/5.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZRankViewController.h"
#import "YZRankTableViewCell.h"

@interface YZRankViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray<NSDictionary *> *dataArray;

@end

@implementation YZRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.dataArray = [NSArray array];
    
    [self.tableView registerClass:[YZRankTableViewCell class] forCellReuseIdentifier:NSStringFromClass([YZRankTableViewCell class])];
    [self requestData];
}

- (void)initView {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.yz_navigationBar addCenterTitleLabelWithTitle:@"排行" font:[UIFont systemFontOfSize:18] color:[UIColor whiteColor]];
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight)];
    self.backView.backgroundColor = BACKGROUND_COLOR_STYLE_TWO;
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.tableView];
}

- (void)requestData {
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YZRankTableViewCell class]) forIndexPath:indexPath];
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight)];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
@end

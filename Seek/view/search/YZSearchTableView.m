//
//  YZSearchTableView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/8.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZSearchTableView.h"
#import "YZSearchTableViewCell.h"

NSNotificationName const SearchTableViewDidScrollNotification = @"SearchTableViewDidScrollNotification";

@implementation YZSearchTableView

- (instancetype)init {
    self = [super init];
    self.backgroundColor = RGB_ALPHA(0, 0, 0, 0.3);
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
    self.delegate = self;
    self.dataSource = self;
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    [self registerNib:[UINib nibWithNibName:@"YZSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"YZSearchTableViewCell"];
    
    self.clearHistoryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.clearHistoryBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
//    self.clearHistoryBtn.hidden = true;
    [self.clearHistoryBtn setTitle:@"清除所有历史记录" forState:UIControlStateNormal];
    [self.clearHistoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.clearHistoryBtn addTarget:self action:@selector(clearBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.tableFooterView = self.clearHistoryBtn;
}

- (void)clearBtnDidClicked:(id)sender {
    
}

#pragma make - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZSearchTableViewCell" forIndexPath:indexPath];
    if (self.dataArray.count > 0) {
        cell.cellStyle = YZSearchTableViewCellStyleDefault;
//        cell.dataDict = _dataArray[indexPath.row];
    }else {
        cell.cellStyle = YZSearchTableViewCellStyleHistory;
//        cell.dataDict = _dataArray[indexPath.row];
    }
    return cell;
}

#pragma make - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    Post_Notify(SearchTableViewDidScrollNotification, nil, nil);
}

@end

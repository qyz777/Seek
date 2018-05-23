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
    self.clearHistoryBtn.hidden = true;
    [self.clearHistoryBtn setTitle:@"清除所有历史记录" forState:UIControlStateNormal];
    [self.clearHistoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.clearHistoryBtn addTarget:self action:@selector(clearBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.tableFooterView = self.clearHistoryBtn;
}

- (void)clearBtnDidClicked:(id)sender {
    if ([self.yz_delegate respondsToSelector:@selector(clearSearchHistoryBtnDidTouchUpInside)]) {
        [self.yz_delegate clearSearchHistoryBtnDidTouchUpInside];
    }
}

#pragma make - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray.count > 0) {
        return _dataArray.count;
    }else {
        if (_historyDataArray.count > 0) {
            return _historyDataArray.count;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZSearchTableViewCell" forIndexPath:indexPath];
    if (self.dataArray.count > 0) {
        cell.dataDict = _dataArray[indexPath.row];
        self.clearHistoryBtn.hidden = true;
    }else {
        cell.dataDict = _historyDataArray[indexPath.row];
        self.clearHistoryBtn.hidden = false;
    }
    return cell;
}

#pragma make - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    搜索历史
    NSDictionary *shortDict = nil;
    if (_dataArray.count > 0) {
        shortDict = _dataArray[indexPath.row];
        BOOL isRepeat = false;
        for (NSDictionary *d in self.historyDataArray) {
            if (d[@"entry"] == shortDict[@"entry"]) {
                isRepeat = true;
            }
        }
        if (!isRepeat) {
            [self.historyDataArray insertObject:shortDict atIndex:0];
        }
        if (self.historyDataArray.count > 10) {
            [self.historyDataArray removeObject:self.historyDataArray.lastObject];
        }
    }else {
        shortDict = _historyDataArray[indexPath.row];
    }
    if ([self.yz_delegate respondsToSelector:@selector(cellDidSelectWithDict:)]) {
        [self.yz_delegate cellDidSelectWithDict:shortDict];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    Post_Notify(SearchTableViewDidScrollNotification, nil, nil);
}

@end

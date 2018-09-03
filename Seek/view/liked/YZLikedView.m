//
//  YZLikedView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/25.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZLikedView.h"
#import "YZSearchTableViewCell.h"

@implementation YZLikedView

- (instancetype)init {
    self = [super init];
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
    self.dataSource = self;
    self.delegate = self;
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    [self registerNib:[UINib nibWithNibName:@"YZSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"YZSearchTableViewCell"];
    self.tableFooterView = [UIView new];
}

#pragma make - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZSearchTableViewCell" forIndexPath:indexPath];
    cell.likeDataDict = _dataArray[indexPath.row];
    return cell;
}

#pragma make - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

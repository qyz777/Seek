//
//  MeView.m
//  Seek
//
//  Created by Q YiZhong on 2018/6/19.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "MeView.h"
#import "YZMeAvatarCell.h"
#import "YZMeNormalCell.h"

@implementation MeView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.backgroundColor = BACKGROUND_COLOR_STYLE_TWO;
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - TabBarHeight);
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableFooterView = [UIView new];
    
    [self registerClass:[YZMeAvatarCell class] forCellReuseIdentifier:NSStringFromClass([YZMeAvatarCell class])];
    [self registerClass:[YZMeNormalCell class] forCellReuseIdentifier:NSStringFromClass([YZMeNormalCell class])];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZMeNormalCell *cell;
//    头像
    if (indexPath.row == YZMeAvatarCellStyle) {
        YZMeAvatarCell *avatarCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YZMeAvatarCell class]) forIndexPath:indexPath];
        avatarCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return avatarCell;
    }
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YZMeNormalCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == YZMeAvatarCellStyle) {
        if ([self.yz_delegate respondsToSelector:@selector(avatarCellDidSelect)]) {
            [self.yz_delegate avatarCellDidSelect];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == YZMeAvatarCellStyle) {
        return [YZMeAvatarCell cellHeight];
    }else {
        return [YZMeNormalCell cellHeight];
    }
}

@end

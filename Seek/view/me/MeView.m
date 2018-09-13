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
    self.headerView = [[MeHeaderView alloc] init];
    self.tableHeaderView = self.headerView;
    
    [self.footerView addSubview:self.logOutBtn];
    [self.logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.footerView);
        make.bottom.equalTo(self.footerView).offset(-10);
        make.left.equalTo(self.footerView).offset(30);
        make.right.equalTo(self.footerView).offset(-30);
        make.height.mas_equalTo(35);
    }];
    self.tableFooterView = self.footerView;
    
    [self registerClass:[YZMeAvatarCell class] forCellReuseIdentifier:NSStringFromClass([YZMeAvatarCell class])];
    [self registerClass:[YZMeNormalCell class] forCellReuseIdentifier:NSStringFromClass([YZMeNormalCell class])];
    
    self.dataArray = @[@{@"icon": @"me_rank",@"text": @"排行"},
                      @{@"icon": @"me_setting",@"text": @"设置"},
                       @{@"icon": @"me_like",@"text": @"喜欢"}];
    [self reloadData];
}

- (void)logOut:(id)sender {
    if ([self.yz_delegate respondsToSelector:@selector(logOutBtnDidClicked)]) {
        [self.yz_delegate logOutBtnDidClicked];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZMeNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YZMeNormalCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == MeCellRank) {
        if ([self.yz_delegate respondsToSelector:@selector(rankCellDidSelect)]) {
            [self.yz_delegate rankCellDidSelect];
        }
    }else if (indexPath.row == MeCellSetting) {
        if ([self.yz_delegate respondsToSelector:@selector(settingCellDidSelect)]) {
            [self.yz_delegate settingCellDidSelect];
        }
    }else if (indexPath.row == MeCellLike) {
        if ([self.yz_delegate respondsToSelector:@selector(likeCellDidSelect)]) {
            [self.yz_delegate likeCellDidSelect];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YZMeNormalCell cellHeight];
}

#pragma mark - getter
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    }
    return _footerView;
}

- (UIButton *)logOutBtn {
    if (!_logOutBtn) {
        _logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logOutBtn addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
        [_logOutBtn setTitle:@"退出" forState:UIControlStateNormal];
        _logOutBtn.titleLabel.textColor = [UIColor whiteColor];
        _logOutBtn.layer.cornerRadius = 15.0f;
        _logOutBtn.backgroundColor = UIColorFromRGB(0xfa3e54);
    }
    return _logOutBtn;
}

@end

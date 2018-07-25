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

- (void)logOut:(id)sender {
    if ([self.yz_delegate respondsToSelector:@selector(logOutBtnDidClicked)]) {
        [self.yz_delegate logOutBtnDidClicked];
    }
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
    
    NSInteger index = indexPath.row;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, cell.width - 30 * 2 - 50, cell.height)];
    label.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightBold];
    label.textColor = UIColor.whiteColor;
    
    switch (index) {
        case 1:{
            //签名
            label.text = @"个性签名：让背单词变得更简单！";
            [cell.contentView addSubview:label];
            break;
        }
        case 2:{
            UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            progressView.frame = CGRectMake(55, cell.height - 4 - 15, label.width + 2, 50);
            NSLog(@"%f",progressView.height);
            CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 2.0f);
            progressView.transform = transform;
            progressView.tintColor = [UIColor colorWithRed:0 green:205 / 255.0 blue:205 / 255.0 alpha:1.0];
            progressView.layer.cornerRadius = 1.0f;
            progressView.layer.masksToBounds = YES;

//            for (UIImageView * imageview in progressView.subviews) {
//                imageview.layer.cornerRadius = 1;
//                imageview.clipsToBounds = YES;
//            }
            [UIView animateWithDuration:0.5 animations:^{
                [progressView setProgress:0.25];
            }];
            [cell.contentView addSubview:progressView];
            
            label.text = @"经验值：300/1200";
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label];
            
            break;
        }
        case 3:{
            label.text = @"当前段位: 单词少侠";
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label];
            break;
        }
        default:
            break;
    }
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOutBtn addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    [logOutBtn setTitle:@"退出" forState:UIControlStateNormal];
    logOutBtn.titleLabel.textColor = [UIColor whiteColor];
    logOutBtn.layer.cornerRadius = 15.0f;
    logOutBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    logOutBtn.layer.borderWidth = 0.5f;
    [footerView addSubview:logOutBtn];
    [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footerView);
        make.bottom.equalTo(footerView).offset(-10);
        make.left.equalTo(footerView).offset(30);
        make.right.equalTo(footerView).offset(-30);
        make.height.mas_equalTo(35);
    }];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80;
}

@end

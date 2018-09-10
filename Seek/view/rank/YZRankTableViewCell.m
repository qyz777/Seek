//
//  YZRankTableViewCell.m
//  Seek
//
//  Created by Q YiZhong on 2018/9/5.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZRankTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface YZRankTableViewCell()


// 姓名
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIView *rankView;
@property(nonatomic,weak)UIImageView *headimgView;
@property(nonatomic,weak)UILabel *expLabel;

@property(nonatomic,weak)UIView *userInfoView;


@end

@implementation YZRankTableViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self initSubviews];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    UIView *rankView = [UIView new];
//    rankView.backgroundColor = UIColor.redColor;
    [self.contentView addSubview:rankView];
    self.rankView = rankView;

    [self.rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    UIView *userInfoView = [UIView new];
    [self.contentView addSubview:userInfoView];
    self.userInfoView = userInfoView;
    
//    self.userInfoView.backgroundColor = UIColor.greenColor;


    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankView.mas_right).offset(20);
        make.right.equalTo(self.contentView).offset(-120);
        make.height.equalTo(self.rankView);
        make.centerY.equalTo(self.contentView);
    }];
    
    
    UILabel *expLabel = [UILabel new];
    [self.contentView addSubview:expLabel];
    self.expLabel = expLabel;
    self.expLabel.textColor = UIColor.grayColor;
    self.expLabel.font = [UIFont boldSystemFontOfSize:15];
    self.expLabel.textAlignment = NSTextAlignmentCenter;
    
//    self.expLabel.backgroundColor = UIColor.yellowColor;
    
    [self.expLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userInfoView.mas_right).offset(20);
        make.width.equalTo(@(100));
        make.height.equalTo(self.rankView);
        make.centerY.equalTo(self.contentView);
    }];
    
    //头像
    UIImageView *headimg = [[UIImageView alloc] init];
    [self.userInfoView addSubview:headimg];
    self.headimgView = headimg;
    self.headimgView.layer.masksToBounds = YES;
    self.headimgView.layer.cornerRadius = 50 * 0.5;
    
    [self.headimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.userInfoView.mas_height);
        make.width.equalTo(self.userInfoView.mas_height);
        make.left.equalTo(self.userInfoView);
        make.centerY.equalTo(self.userInfoView);
    }];
    
    
    
    self.headimgView.backgroundColor = UIColor.lightGrayColor;
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont boldSystemFontOfSize:15];
    nameLabel.textColor = UIColor.grayColor;
    [self.userInfoView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headimgView);
        make.left.equalTo(self.headimgView.mas_right).offset(10);
        make.right.equalTo(self.userInfoView.mas_right);
    }];

    
//    UILabel *nameLabel = [UILabel new];
//    [self.contentView addSubview:nameLabel];
//    self.nameLabel = nameLabel;
//
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.rankView.mas_right).offset(20);
//        make.right.equalTo(self.contentView).offset(-120);
//        make.height.equalTo(self.rankView);
//    }];
    
    
    
//    [self.contentView addSubview:self.nameLabel];
//    [self.contentView addSubview:self.rankLabel];
//
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(self.contentView).offset(15);
//    }];
//
//    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.nameLabel);
//        make.right.equalTo(self.contentView).offset(-15);
//    }];
}

- (void)setData:(NSDictionary *)data {
    self.rankID = data[@"rankID"];
    
    // 等级排行
    UIView *sonView = nil;
    if ([self.rankID intValue] > 3) {
        UILabel *label = [UILabel new];
        label.text = [NSString stringWithFormat:([self.rankID intValue] < 10 ? @"0%@" : @"%@"),self.rankID];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textColor = UIColor.grayColor;
        label.textAlignment = NSTextAlignmentCenter;
        sonView = label;
    }else{
        sonView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"rank_%@",self.rankID]]];
    }
    
    [self.rankView addSubview:sonView];
    [sonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.rankView).offset(-10);
        make.height.equalTo(self.rankView).offset(-10);
        make.centerX.equalTo(self.rankView);
        make.centerY.equalTo(self.rankView);
    }];
    
    // 经验值
    self.expLabel.text = [NSString stringWithFormat:@"%@ EXP",data[@"exp"]];
    
    [self.headimgView sd_setImageWithURL:[NSURL URLWithString:data[@"headimg"]] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    
    self.nameLabel.text = data[@"nickname"];
    
}


//- (UILabel *)nameLabel {
//    if (!_nameLabel) {
//        _nameLabel = [UILabel new];
//        _nameLabel.textColor = [UIColor whiteColor];
//    }
//    return _nameLabel;
//}
//
//- (UILabel *)rankLabel {
//    if (!_rankLabel) {
//        _rankLabel = [UILabel new];
//        _rankLabel.textColor = UIColorFromRGB(0xfa3e54);
//        _rankLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _rankLabel;
//}

@end

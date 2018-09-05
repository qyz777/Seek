//
//  YZRankTableViewCell.m
//  Seek
//
//  Created by Q YiZhong on 2018/9/5.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZRankTableViewCell.h"

@implementation YZRankTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.rankLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-15);
    }];
}

- (void)setData:(NSDictionary *)data {
    
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)rankLabel {
    if (!_rankLabel) {
        _rankLabel = [UILabel new];
        _rankLabel.textColor = UIColorFromRGB(0xfa3e54);
        _rankLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rankLabel;
}

@end

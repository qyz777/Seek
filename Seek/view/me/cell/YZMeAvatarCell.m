//
//  YZMeAvatarCell.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/1.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZMeAvatarCell.h"

@implementation YZMeAvatarCell

+ (CGFloat)cellHeight {
    return 100;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.center.equalTo(self);
        make.height.mas_equalTo(80);
    }];
    
    [self.backView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(10);
        make.centerY.equalTo(self.backView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.backView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(15);
        make.centerY.equalTo(self.avatarImageView);
        make.right.equalTo(self.backView).offset(-15);
    }];
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    //    TODO:qyz 设置数据
}

#pragma mark - getter
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.layer.cornerRadius = 40.0f;
        _avatarImageView.layer.masksToBounds = true;
        _avatarImageView.image = [UIImage imageNamed:@"default_icon"];
    }
    return _avatarImageView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.layer.borderColor = [UIColor whiteColor].CGColor;
        _backView.layer.borderWidth = 1.0;
        _backView.layer.cornerRadius = 30.0f;
    }
    return _backView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightRegular];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

@end

//
//  YZMeNormalCell.m
//  Seek
//
//  Created by Q YiZhong on 2018/6/19.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZMeNormalCell.h"

@implementation YZMeNormalCell

+ (CGFloat)cellHeight {
    return 80;
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
    [self.backView addSubview:self.iconImageView];
    [self.backView addSubview:self.label];
    [self.backView addSubview:self.arrowImageView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.center.equalTo(self);
        make.height.mas_equalTo(70);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView);
        make.left.equalTo(self.backView).offset(15);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView).offset(-15);
        make.centerY.equalTo(self.backView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    self.iconImageView.image = [UIImage imageNamed:_data[@"icon"]];
    self.label.text = _data[@"text"];
}

#pragma mark - getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.layer.cornerRadius = 4.0f;
        _backView.backgroundColor = RGB_ALPHA(105, 105, 105, 0.7);
    }
    return _backView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.image = [UIImage imageNamed:@"cell_arrow"];
    }
    return _arrowImageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightMedium];
    }
    return _label;
}

@end

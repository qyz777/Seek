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
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.center.equalTo(self);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.layer.borderColor = [UIColor whiteColor].CGColor;
        _backView.layer.borderWidth = 1.0;
        _backView.layer.cornerRadius = 25.0f;
    }
    return _backView;
}

@end

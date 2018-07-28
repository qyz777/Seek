//
//  MeHeaderView.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "MeHeaderView.h"

NSNotificationName const ExLayerShouldBegin = @"ExLayerShouldBegin";

@implementation MeHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 190);
        [self initSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginAnimation) name:ExLayerShouldBegin object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initSubviews {
    [self addSubview:self.avaterImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.exView];
    [self addSubview:self.rankLabel];
    [self.exView addSubview:self.exLabel];
    [self.layer addSublayer:self.shapeLayer];
    [self addSubview:self.exBottomView];
    [self.exBottomView addSubview:self.exBottomLabel];
    
    [self.avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.left.equalTo(self).offset(30);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avaterImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.avaterImageView);
    }];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.nameLabel);
    }];
    
    [self.exView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
    
    [self.exLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.exView);
    }];
    
    [self.exBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.exView);
        make.centerY.equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
    [self.exBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.exBottomView);
    }];
}

- (void)beginAnimation {
    dispatch_resume(self.timer);
}

- (void)setData:(NSDictionary *)data {
    _data = data;
}

#pragma mark - getter
- (UIImageView *)avaterImageView {
    if (!_avaterImageView) {
        _avaterImageView = [UIImageView new];
        _avaterImageView.image = [UIImage imageNamed:@"default_icon"];
        _avaterImageView.layer.cornerRadius = _avaterImageView.frame.size.width / 2;
    }
    return _avaterImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _nameLabel.text = @"测试测试";
    }
    return _nameLabel;
}

- (UIView *)exView {
    if (!_exView) {
        _exView = [UIView new];
    }
    return _exView;
}

- (UILabel *)exLabel {
    if (!_exLabel) {
        _exLabel = [UILabel new];
        _exLabel.textColor = [UIColor whiteColor];
        _exLabel.textAlignment = NSTextAlignmentCenter;
        _exLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightMedium];
        _exLabel.text = @"80%";
    }
    return _exLabel;
}

- (UILabel *)rankLabel {
    if (!_rankLabel) {
        _rankLabel = [UILabel new];
        _rankLabel.textColor = [UIColor whiteColor];
        _rankLabel.layer.cornerRadius = 10.5f;
        _rankLabel.font = [UIFont systemFontOfSize:11.0f weight:UIFontWeightRegular];
        _rankLabel.backgroundColor = UIColorFromRGB(0xf47ba6);
        _rankLabel.text = @" 单词少侠 ";
    }
    return _rankLabel;
}

- (UIView *)exBottomView {
    if (!_exBottomView) {
        _exBottomView = [UIView new];
        _exBottomView.layer.cornerRadius = 12.5f;
        _exBottomView.backgroundColor = UIColorFromRGB(0x2cafe8);
    }
    return _exBottomView;
}

- (UILabel *)exBottomLabel {
    if (!_exBottomLabel) {
        _exBottomLabel = [UILabel new];
        _exBottomLabel.text = @"经验:800/1000";
        _exBottomLabel.textAlignment = NSTextAlignmentCenter;
        _exBottomLabel.font = [UIFont systemFontOfSize:13.0f weight:UIFontWeightRegular];
        _exBottomLabel.textColor = [UIColor whiteColor];
    }
    return _exBottomLabel;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.lineWidth = 3.0f;
        _shapeLayer.strokeColor = UIColorFromRGB(0xfa3e54).CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH - 100, 80) radius:60 startAngle:3 * M_PI_2 endAngle:- M_PI_2 clockwise:NO];
        _shapeLayer.path = path.CGPath;
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 0;
    }
    return _shapeLayer;
}

- (dispatch_source_t)timer {
    if (!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        YZWeakObject(self);
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.shapeLayer.strokeEnd += 0.1;
                if (weakself.shapeLayer.strokeEnd >= 0.8) {
                    dispatch_source_cancel(weakself.timer);
                }
            });
        });
    }
    return _timer;
}

@end

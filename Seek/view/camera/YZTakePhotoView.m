//
//  YZTakePhotoView.m
//  Seek
//
//  Created by Q YiZhong on 2018/7/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZTakePhotoView.h"

@implementation YZTakePhotoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubviews];
        [self.okBtn addTarget:self action:@selector(okBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)initSubviews {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    [self addSubview:self.imageView];
    [self addSubview:self.okBtn];
    [self addSubview:self.cancelBtn];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(self);
        make.height.mas_equalTo(SCREEN_HEIGHT - 100);
    }];
    
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self.imageView.mas_bottom).offset(15);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(120);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self.imageView.mas_bottom).offset(15);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(120);
    }];
}

- (void)okBtnDidClicked:(id)sender {
    if ([self.yz_delegate respondsToSelector:@selector(okBtnDidClicked)]) {
        [self.yz_delegate okBtnDidClicked];
    }
}

- (void)cancelBtnDidClicked:(id)sender {
    if ([self.yz_delegate respondsToSelector:@selector(cancelBtnDidClicked)]) {
        [self.yz_delegate cancelBtnDidClicked];
    }
}

- (void)setImageData:(UIImage *)imageData {
    _imageData = imageData;
    self.imageView.image = _imageData;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _okBtn.layer.cornerRadius = 12;
        _okBtn.backgroundColor = UIColorFromRGB(0xfa3e54);
    }
    return _okBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelBtn.layer.cornerRadius = 12;
        _cancelBtn.backgroundColor = RGB(105, 105, 105);
    }
    return _cancelBtn;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

@end

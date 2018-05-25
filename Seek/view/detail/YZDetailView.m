//
//  YZDetailView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZDetailView.h"

@implementation YZDetailView

- (instancetype)init {
    self = [super init];
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    self.wordLabel = [UILabel new];
    self.wordLabel.textColor = [UIColor whiteColor];
    self.wordLabel.textAlignment = NSTextAlignmentCenter;
    self.wordLabel.font = [UIFont boldSystemFontOfSize:40.0f];
    [self addSubview:self.wordLabel];
    [self.wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(20);
        make.centerX.equalTo(self);
        make.height.mas_offset(40);
    }];
    
    self.leftSymLabel = [UILabel new];
    self.leftSymLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.leftSymLabel];
    [self.leftSymLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 40, 30));
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self.wordLabel.mas_bottom).offset(30);
    }];
    
    self.rightSymLabel = [UILabel new];
    self.rightSymLabel.textAlignment = NSTextAlignmentRight;
    self.rightSymLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.rightSymLabel];
    [self.rightSymLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 40, 30));
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self.wordLabel.mas_bottom).offset(30);
    }];
    
    self.translateLabel = [UILabel new];
    self.translateLabel.text = @"翻译:";
    self.translateLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    self.translateLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.translateLabel];
    [self.translateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 30));
        make.centerX.equalTo(self);
        make.top.equalTo(self.wordLabel.mas_bottom).offset(120);
    }];
    
    self.firstTranslateLabel = [UILabel new];
    self.firstTranslateLabel.font = [UIFont boldSystemFontOfSize:20.f];
    self.firstTranslateLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.firstTranslateLabel];
    [self.firstTranslateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 30));
        make.centerX.equalTo(self);
        make.top.equalTo(self.translateLabel.mas_bottom).offset(8);
    }];
    
    self.secondTranslateLabel = [UILabel new];
    self.secondTranslateLabel.font = [UIFont boldSystemFontOfSize:20.f];
    self.secondTranslateLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.secondTranslateLabel];
    [self.secondTranslateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, 30));
        make.centerX.equalTo(self);
        make.top.equalTo(self.firstTranslateLabel.mas_bottom).offset(12);
    }];
    
    self.selectLabel = [UILabel new];
    self.selectLabel.text = @"精选短句:";
    self.selectLabel.numberOfLines = 0;
    self.selectLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    self.selectLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.selectLabel];
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(80, 21));
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.secondTranslateLabel.mas_bottom).offset(18);
    }];
    
    self.enLabel = [UILabel new];
    self.enLabel.numberOfLines = 0;
    self.enLabel.font = [UIFont boldSystemFontOfSize:20.f];
    self.enLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.enLabel];
    [self.enLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.centerX.equalTo(self);
        make.top.equalTo(self.selectLabel.mas_bottom).offset(8);
    }];
    
    self.imageView = [UIImageView new];
    self.imageView.alpha = 0;
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(80, 80));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
    }];
}

- (void)setWord:(YZWord *)word {
    _word = word;
    self.wordLabel.text = word.word;
    NSString *ukStr = [@"" stringByAppendingFormat:@"英:/%@/",word.ukPhone];
    self.leftSymLabel.text = ukStr;
    NSString *usStr = [@"" stringByAppendingFormat:@"美:/%@/",word.usPhone];
    self.rightSymLabel.text = usStr;
    self.enLabel.text = word.sentence;
    int i = 0;
    for (NSString *str in word.translate) {
        if (i == 0) {
            self.firstTranslateLabel.text = str;
        }else {
            self.secondTranslateLabel.text = str;
        }
        i++;
    }
}

@end

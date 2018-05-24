//
//  YZWordDetailView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/23.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZWordDetailView.h"

@implementation YZWordDetailView

- (instancetype)init {
    self = [super init];
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    self.wordLabel = [UILabel new];
    self.wordLabel.font = [UIFont boldSystemFontOfSize:35.0f];
    [self addSubview:self.wordLabel];
    [self.wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 40));
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(15);
    }];
    
    self.ukPhoneLabel = [UILabel new];
    [self addSubview:self.ukPhoneLabel];
    [self.ukPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 21));
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.wordLabel.mas_bottom).offset(25);
    }];
    
    self.usPhoneLabel = [UILabel new];
    [self addSubview:self.usPhoneLabel];
    [self.usPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 21));
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self.ukPhoneLabel);
    }];
    
    self.senLabel = [UILabel new];
    self.senLabel.numberOfLines = 0;
    [self addSubview:self.senLabel];
    [self.senLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH - 30);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.usPhoneLabel.mas_bottom).offset(25);
    }];
    
    self.senTranLabel = [UILabel new];
    [self addSubview:self.senTranLabel];
    [self.senTranLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 21));
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.senLabel.mas_bottom).offset(25);
    }];
    
    self.firstTranLabel = [UILabel new];
    [self addSubview:self.firstTranLabel];
    [self.firstTranLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 21));
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.senTranLabel.mas_bottom).offset(25);
    }];
    
    self.secondTranLabel = [UILabel new];
    [self addSubview:self.secondTranLabel];
    [self.secondTranLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 21));
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.firstTranLabel.mas_bottom).offset(25);
    }];
    
    self.thirdTranLabel = [UILabel new];
    [self addSubview:self.thirdTranLabel];
    [self.thirdTranLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 21));
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.secondTranLabel.mas_bottom).offset(25);
    }];
}

#pragma make setter
- (void)setWordData:(YZWord *)wordData {
    _wordData = wordData;
    self.wordLabel.text = wordData.word;
    NSString *ukStr = [@"" stringByAppendingFormat:@"英:/%@/",wordData.ukPhone];
    self.ukPhoneLabel.text = ukStr;
    NSString *usStr = [@"" stringByAppendingFormat:@"美:/%@/",wordData.usPhone];
    self.usPhoneLabel.text = usStr;
    self.senLabel.text = wordData.sentence;
    self.senTranLabel.text = wordData.senTranslate;
    int i = 0;
    for (NSString *str in wordData.translate) {
        if (i == 0) {
            self.firstTranLabel.text = str;
        }else if (i == 1) {
            self.secondTranLabel.text = str;
        }else {
            self.thirdTranLabel.text = str;
        }
        i++;
    }
}

@end

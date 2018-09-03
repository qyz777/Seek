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
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    self.backImageView = [UIImageView new];
    [self addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.equalTo(self);
    }];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    effectView.alpha = 0.85f;
    effectView.frame = self.frame;
    [self.backImageView addSubview:effectView];
    
    self.cardView = [UIView new];
    self.cardView.backgroundColor = [UIColor whiteColor];
    self.cardView.layer.cornerRadius = 8;
    self.cardView.layer.shadowOffset = CGSizeMake(1, 1);
    self.cardView.layer.shadowOpacity = 0.7;
    self.cardView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.backImageView addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - 240));
        make.top.equalTo(self.backImageView).offset(140);
        make.centerX.equalTo(self);
    }];
    
    self.wordLabel = [UILabel new];
    self.wordLabel.font = [UIFont boldSystemFontOfSize:25.0f];
    self.wordLabel.textAlignment = NSTextAlignmentCenter;
    [self.cardView addSubview:self.wordLabel];
    [self.wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardView).offset(10);
        make.right.equalTo(self.cardView).offset(-10);
        make.top.equalTo(self.cardView).offset(5);
    }];
    
    self.ukPhoneLabel = [UILabel new];
    [self.cardView addSubview:self.ukPhoneLabel];
    [self.ukPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.left.equalTo(self.cardView).offset(10);
        make.top.equalTo(self.wordLabel.mas_bottom).offset(20);
    }];

    self.usPhoneLabel = [UILabel new];
    self.usPhoneLabel.textAlignment = NSTextAlignmentRight;
    [self.cardView addSubview:self.usPhoneLabel];
    [self.usPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.right.equalTo(self.cardView).offset(-10);
        make.centerY.equalTo(self.ukPhoneLabel);
    }];

    self.senLabel = [UILabel new];
    self.senLabel.numberOfLines = 0;
    [self.cardView addSubview:self.senLabel];
    [self.senLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardView).offset(10);
        make.right.equalTo(self.cardView).offset(-10);
        make.top.equalTo(self.usPhoneLabel.mas_bottom).offset(20);
    }];

    self.senTranLabel = [UILabel new];
    self.senTranLabel.numberOfLines = 0;
    [self.cardView addSubview:self.senTranLabel];
    [self.senTranLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardView).offset(10);
        make.right.equalTo(self.cardView).offset(-10);
        make.top.equalTo(self.senLabel.mas_bottom).offset(20);
    }];

    self.firstTranLabel = [UILabel new];
    self.firstTranLabel.numberOfLines = 0;
    [self.cardView addSubview:self.firstTranLabel];
    [self.firstTranLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardView).offset(10);
        make.right.equalTo(self.cardView).offset(-10);
        make.top.equalTo(self.senTranLabel.mas_bottom).offset(20);
    }];

    self.secondTranLabel = [UILabel new];
    self.secondTranLabel.numberOfLines = 0;
    [self.cardView addSubview:self.secondTranLabel];
    [self.secondTranLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardView).offset(10);
        make.right.equalTo(self.cardView).offset(-10);
        make.top.equalTo(self.firstTranLabel.mas_bottom).offset(20);
    }];

    self.thirdTranLabel = [UILabel new];
    self.thirdTranLabel.numberOfLines = 0;
    [self.cardView addSubview:self.thirdTranLabel];
    [self.thirdTranLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardView).offset(10);
        make.right.equalTo(self.cardView).offset(-10);
        make.top.equalTo(self.secondTranLabel.mas_bottom).offset(20);
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

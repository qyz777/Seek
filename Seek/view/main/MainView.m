//
//  MainView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/5.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "MainView.h"
#import <QuartzCore/QuartzCore.h>

@interface MainView()

@property(nonatomic, assign)BOOL isShow;
@property(nonatomic)CGSize wordLabelSize;

@end

@implementation MainView

- (instancetype)init {
    self = [super init];
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
    self.backgroundColor = BACKGROUND_COLOR_STYLE_ONE;
    self.isShow = false;
    [self initSubViews];
    return self;
}

- (void)initSubViews {
    self.wordLabel = [UILabel new];
    self.wordLabel.text = @"Seek";
    self.wordLabelSize =[self.wordLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:55.0f]}];
    self.wordLabel.textColor = [UIColor whiteColor];
    self.wordLabel.font = [UIFont boldSystemFontOfSize:55.0f];
    self.wordLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.wordLabel];
    [self.wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.wordLabelSize.width + 10, self.wordLabelSize.height));
        make.top.equalTo(self).offset(135);
        make.centerX.equalTo(self);
    }];
    
    self.enSentenceLabel = [UILabel new];
    self.enSentenceLabel.numberOfLines = 0;
    self.enSentenceLabel.text = @"He is forth and seek his  fortune";
    self.enSentenceLabel.textColor = [UIColor whiteColor];
    self.enSentenceLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    self.enSentenceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.enSentenceLabel];
    [self.enSentenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160);
        make.top.equalTo(self.wordLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    self.cnSentenceLabel = [UILabel new];
    self.cnSentenceLabel.numberOfLines = 0;
    self.cnSentenceLabel.text = @"他动身去寻找他的未来";
    self.cnSentenceLabel.textColor = [UIColor whiteColor];
    self.cnSentenceLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    self.cnSentenceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.cnSentenceLabel];
    [self.cnSentenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160);
        make.top.equalTo(self.enSentenceLabel.mas_bottom).offset(10);
        make.center.equalTo(self);
    }];
    
    self.arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.arrowButton addTarget:self action:@selector(clickArrowButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.arrowButton setImage:[UIImage imageNamed:@"箭头 上"] forState:UIControlStateNormal];
    [self addSubview:self.arrowButton];
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(self).offset(-40);
        make.centerX.equalTo(self);
    }];
    
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:0.7f];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self).offset(0);
        make.top.equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(350);
    }];
    
    self.leftSymLabel = [UILabel new];
    self.leftSymLabel.text = @"美:/sik/";
    self.leftSymLabel.textColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.leftSymLabel];
    [self.leftSymLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 40, 30));
        make.left.equalTo(self.bottomView).offset(30);
        make.top.equalTo(self.bottomView).offset(12);
    }];
    
    self.rightSymLabel = [UILabel new];
    self.rightSymLabel.text = @"英:/si;k/";
    self.rightSymLabel.textAlignment = NSTextAlignmentRight;
    self.rightSymLabel.textColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.rightSymLabel];
    [self.rightSymLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 40, 30));
        make.right.equalTo(self.bottomView).offset(-30);
        make.top.equalTo(self.bottomView).offset(12);
    }];
    
    self.firstTranslateLabel = [UILabel new];
    self.firstTranslateLabel.text = @"vt. 寻求;寻找;探索;搜索";
    self.firstTranslateLabel.font = [UIFont boldSystemFontOfSize:20.f];
    self.firstTranslateLabel.textColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.firstTranslateLabel];
    [self.firstTranslateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 30));
        make.centerX.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView).offset(60);
    }];
    
    self.secondTranslateLabel = [UILabel new];
    self.secondTranslateLabel.text = @"vi.寻找;探索;搜索";
    self.secondTranslateLabel.font = [UIFont boldSystemFontOfSize:20.f];
    self.secondTranslateLabel.textColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.secondTranslateLabel];
    [self.secondTranslateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 30));
        make.centerX.equalTo(self.bottomView);
        make.top.equalTo(self.firstTranslateLabel.mas_bottom).offset(10);
    }];
    
    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeButton setBackgroundImage:[UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    [self.bottomView addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(self.bottomView).offset(-40);
    }];
}

- (void)clickArrowButton:(id)sender {
    if (self.isShow) {
        self.isShow = false;
        [self setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.5f animations:^{
            self.arrowButton.transform = CGAffineTransformRotate(self.arrowButton.transform, M_PI);
            [self.arrowButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(-40);
            }];
            CGAffineTransform wordTransform = CGAffineTransformMakeScale(1, 1);
            self.wordLabel.transform = CGAffineTransformScale(wordTransform, 1, 1);
            [self.wordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(self.wordLabelSize.width + 10, self.wordLabelSize.height));
                make.top.equalTo(self).offset(135);
                make.centerX.equalTo(self);
            }];
            self.enSentenceLabel.alpha = 0;
            self.cnSentenceLabel.alpha = 0;
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.left.equalTo(self).offset(0);
                make.top.equalTo(self.mas_bottom).offset(0);
                make.height.mas_equalTo(350);
            }];
            [self layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.enSentenceLabel.textAlignment = NSTextAlignmentCenter;
            [self.enSentenceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(160);
                make.top.equalTo(self.wordLabel.mas_bottom).offset(10);
                make.centerX.equalTo(self);
            }];
            self.cnSentenceLabel.textAlignment = NSTextAlignmentCenter;
            [self.cnSentenceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(160);
                make.top.equalTo(self.enSentenceLabel.mas_bottom).offset(10);
                make.center.equalTo(self);
            }];
            [UIView animateWithDuration:0.2f animations:^{
                self.enSentenceLabel.alpha = 1;
                self.cnSentenceLabel.alpha = 1;
            }];
        }];
    }else {
        self.isShow = true;
        [self setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.5f animations:^{
            self.arrowButton.transform = CGAffineTransformRotate(self.arrowButton.transform, M_PI);
            [self.arrowButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(-400);
            }];
            CGAffineTransform wordTransform = CGAffineTransformMakeScale(0.6, 0.6);
            self.wordLabel.transform = CGAffineTransformScale(wordTransform, 1, 1);
            [self.wordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(self.wordLabelSize.width + 10, self.wordLabelSize.height));
                make.top.equalTo(self).offset(10);
                make.left.equalTo(self).offset(6);
            }];
            self.enSentenceLabel.alpha = 0;
            self.enSentenceLabel.textAlignment = NSTextAlignmentLeft;
            [self.enSentenceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 30));
                make.left.equalTo(self).offset(20);
                make.top.equalTo(self.wordLabel.mas_bottom).offset(6);
            }];
            self.cnSentenceLabel.alpha = 0;
            self.cnSentenceLabel.textAlignment = NSTextAlignmentLeft;
            [self.cnSentenceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 30));
                make.left.equalTo(self).offset(20);
                make.top.equalTo(self.enSentenceLabel.mas_bottom).offset(10);
            }];
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.left.bottom.equalTo(self).offset(0);
                make.height.mas_equalTo(350);
            }];
            [self layoutIfNeeded];
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
                self.enSentenceLabel.alpha = 1;
                self.cnSentenceLabel.alpha = 1;
            }];
        }];
    }
    if ([self.yz_delegate respondsToSelector:@selector(arrowButtonDidClicked)]) {
        [self.yz_delegate arrowButtonDidClicked];
    }
}

#pragma make - setter
- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
}

@end

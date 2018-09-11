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
@property(nonatomic, strong)UISwipeGestureRecognizer *swipe;

@end

@implementation MainView

- (instancetype)init {
    self = [super init];
    self.frame = CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
    self.backgroundColor = BACKGROUND_COLOR_STYLE_TWO;
    self.isShow = false;
    [self initSubViews];
    return self;
}

- (void)initSubViews {
    self.wordLabel = [UILabel new];
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
    self.enSentenceLabel.textColor = [UIColor whiteColor];
    self.enSentenceLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    self.enSentenceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.enSentenceLabel];
    [self.enSentenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.top.equalTo(self.wordLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    self.cnSentenceLabel = [UILabel new];
    self.cnSentenceLabel.numberOfLines = 0;
    self.cnSentenceLabel.textColor = [UIColor whiteColor];
    self.cnSentenceLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    self.cnSentenceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.cnSentenceLabel];
    [self.cnSentenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.top.equalTo(self.enSentenceLabel.mas_bottom).offset(10);
        make.center.equalTo(self);
    }];
    
    self.arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.arrowButton addTarget:self action:@selector(clickArrowButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.arrowButton setImage:[UIImage imageNamed:@"main_arrow_top"] forState:UIControlStateNormal];
    [self addSubview:self.arrowButton];
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(self).offset(-60);
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self).offset(0);
        make.top.equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(350);
    }];
    
    self.leftSymLabel = [UILabel new];
    self.leftSymLabel.textColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.leftSymLabel];
    [self.leftSymLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 40, 30));
        make.left.equalTo(self.bottomView).offset(30);
        make.top.equalTo(self.bottomView).offset(12);
    }];
    
    self.rightSymLabel = [UILabel new];
    self.rightSymLabel.textAlignment = NSTextAlignmentRight;
    self.rightSymLabel.textColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.rightSymLabel];
    [self.rightSymLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 40, 30));
        make.right.equalTo(self.bottomView).offset(-30);
        make.top.equalTo(self.bottomView).offset(12);
    }];
    
    self.firstTranslateLabel = [UILabel new];
    self.firstTranslateLabel.numberOfLines = 0;
    self.firstTranslateLabel.font = [UIFont boldSystemFontOfSize:20.f];
    self.firstTranslateLabel.textColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.firstTranslateLabel];
    [self.firstTranslateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.centerX.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView).offset(90);
    }];
    
    self.secondTranslateLabel = [UILabel new];
    self.secondTranslateLabel.numberOfLines = 0;
    self.secondTranslateLabel.font = [UIFont boldSystemFontOfSize:20.f];
    self.secondTranslateLabel.textColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.secondTranslateLabel];
    [self.secondTranslateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.centerX.equalTo(self.bottomView);
        make.top.equalTo(self.firstTranslateLabel.mas_bottom).offset(15);
    }];
    
//    [self.bottomView addSubview:self.seeBtn];
//    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.bottomView);
//        make.bottom.equalTo(self.bottomView).offset(-100);
//    }];
    
    [self.bottomView addSubview:self.collectBtn];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView).offset(-100);
//        make.right.equalTo(self.seeBtn.mas_left).offset(-80);
        make.centerX.equalTo(self.bottomView);
    }];
    
//    [self.bottomView addSubview:self.shareBtn];
//    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.seeBtn);
//        make.left.equalTo(self.seeBtn.mas_right).offset(80);
//    }];
    
    [self changeBottomViewCornerRadius];
    
    self.swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeScreen:)];
    self.swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:self.swipe];
    
    UISwipeGestureRecognizer *wordSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeWordLabel:)];
    [self addGestureRecognizer:wordSwipe];
}

- (void)swipeWordLabel:(UISwipeGestureRecognizer *)swipe {
    self.collectBtn.selected = NO;
    if (self.isShow) {
        return;
    }
    
    // 拖动动画效果
    
    
//    CGAffineTransform transform = getCGAffineTransformRotateAroundPoint(self.center_x, self.center_y, self.width * 0.5, self.height, 90);
//
//    [UIView animateWithDuration:0.25 animations:^{
//        self.transform = transform;
//    }];
    
    CATransition *animation = [CATransition animation];
    // 动画时间
    animation.duration = 0.5f;
    // 动画类型
    animation.type = @"cube";
    animation.subtype = kCATransitionFromLeft;

    // 动画缓冲|速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.layer addAnimation:animation forKey:@"animation"];
    
    if ([self.yz_delegate respondsToSelector:@selector(wordDidSwipeRight)]) {
        [self.yz_delegate wordDidSwipeRight];
    }
}

- (void)swipeScreen:(UISwipeGestureRecognizer *)swipe {
    [self clickArrowButton:nil];
}

- (void)clickArrowButton:(id)sender {
    if (self.isShow) {
        self.isShow = false;
        self.swipe.direction = UISwipeGestureRecognizerDirectionUp;
        self.enSentenceLabel.alpha = 0;
        self.cnSentenceLabel.alpha = 0;
        [self setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.5f animations:^{
            self.arrowButton.transform = CGAffineTransformRotate(self.arrowButton.transform, M_PI);
            [self.arrowButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(-60);
            }];
            CGAffineTransform wordTransform = CGAffineTransformMakeScale(1, 1);
            self.wordLabel.transform = CGAffineTransformScale(wordTransform, 1, 1);
            [self.wordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(self.wordLabelSize.width + 10, self.wordLabelSize.height));
                make.top.equalTo(self).offset(135);
                make.centerX.equalTo(self);
            }];
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.left.equalTo(self).offset(0);
                make.top.equalTo(self.mas_bottom).offset(0);
                make.height.mas_equalTo(350);
            }];
            [self layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.enSentenceLabel.textAlignment = NSTextAlignmentCenter;
            [self.enSentenceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SCREEN_WIDTH - 40);
                make.top.equalTo(self.wordLabel.mas_bottom).offset(10);
                make.centerX.equalTo(self);
            }];
            self.cnSentenceLabel.textAlignment = NSTextAlignmentCenter;
            [self.cnSentenceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SCREEN_WIDTH - 40);
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
        self.swipe.direction = UISwipeGestureRecognizerDirectionDown;
        self.enSentenceLabel.alpha = 0;
        self.cnSentenceLabel.alpha = 0;
        [self setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.5f animations:^{
            self.arrowButton.transform = CGAffineTransformRotate(self.arrowButton.transform, M_PI);
            [self.arrowButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(-360);
            }];
            CGAffineTransform wordTransform = CGAffineTransformMakeScale(0.6, 0.6);
            self.wordLabel.transform = CGAffineTransformScale(wordTransform, 1, 1);
            [self.wordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(self.wordLabelSize.width + 10, self.wordLabelSize.height));
                make.top.equalTo(self).offset(10);
            }];
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.left.bottom.equalTo(self).offset(0);
                make.height.mas_equalTo(350);
            }];
            [self layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.enSentenceLabel.textAlignment = NSTextAlignmentLeft;
            [self.enSentenceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SCREEN_WIDTH - 40);
                make.left.equalTo(self).offset(20);
                make.top.equalTo(self.wordLabel.mas_bottom).offset(6);
            }];
            self.cnSentenceLabel.textAlignment = NSTextAlignmentLeft;
            [self.cnSentenceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SCREEN_WIDTH - 40);
                make.left.equalTo(self).offset(20);
                make.top.equalTo(self.enSentenceLabel.mas_bottom).offset(10);
            }];
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

- (void)changeBottomViewCornerRadius {
    [self layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(18, 18)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bottomView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.bottomView.layer.mask = maskLayer;
}

#pragma make - setter
- (void)setWordData:(YZWord *)wordData {
    _wordData = wordData;
    self.wordLabel.text = _wordData.word;
    self.wordLabelSize =[self.wordLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:55.0f]}];
    [self.wordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.wordLabelSize.width + 10, self.wordLabelSize.height));
        make.top.equalTo(self).offset(135);
        make.centerX.equalTo(self);
    }];
    NSString *ukStr = [@"" stringByAppendingFormat:@"英:/%@/",wordData.ukPhone];
    self.leftSymLabel.text = ukStr;
    NSString *usStr = [@"" stringByAppendingFormat:@"美:/%@/",wordData.usPhone];
    self.rightSymLabel.text = usStr;
    self.enSentenceLabel.text = wordData.sentence;
    self.cnSentenceLabel.text = wordData.senTranslate;
    int i = 0;
    for (NSString *str in wordData.translate) {
        if (i == 0) {
            self.firstTranslateLabel.text = str;
        }else {
            self.secondTranslateLabel.text = str;
        }
        i++;
    }
}

#pragma make - getter
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:0.4f];
    }
    return _bottomView;
}

- (UIButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setImage:[UIImage imageNamed:@"main_collect_btn"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"main_collect_btn_s"] forState:UIControlStateSelected];
        
        [_collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

- (void)collectBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (UIButton *)seeBtn {
    if (!_seeBtn) {
        _seeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seeBtn setImage:[UIImage imageNamed:@"main_see_btn"] forState:UIControlStateNormal];
    }
    return _seeBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"main_share_btn"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

/**
 * 放射矩阵
 */


CGAffineTransform getCGAffineTransformRotateAroundPoint(float centerX, float centerY ,float x ,float y ,float angle)
{
    x = x - centerX; //计算(x,y)从(0,0)为原点的坐标系变换到(CenterX ，CenterY)为原点的坐标系下的坐标
    y = y - centerY; //(0，0)坐标系的右横轴、下竖轴是正轴,(CenterX,CenterY)坐标系的正轴也一样
    
    CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
    trans = CGAffineTransformRotate(trans,angle);
    trans = CGAffineTransformTranslate(trans,-x, -y);
    return trans;
}

@end

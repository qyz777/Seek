//
//  ZKGameBattleView.m
//  Seek
//
//  Created by 徐正科 on 2018/7/24.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameBattleView.h"

static const CGFloat kInterval = 20;

@interface ZKGameBattleView()

//题目
@property(nonatomic,weak)UILabel *questionLabel;

//当前游戏状态
@property(nonatomic,weak)UIProgressView *progressView;

@property(nonatomic,weak)UILabel *answerA;
@property(nonatomic,weak)UILabel *answerB;
@property(nonatomic,weak)UILabel *answerC;
@property(nonatomic,weak)UILabel *answerD;

// 进度条
//@property(nonatomic,weak)UIProgressView *leftProgressView;
//@property(nonatomic,weak)UIProgressView *rightProgressView;

@end

@implementation ZKGameBattleView

- (void)setQuestion:(NSString *)question {
    _question = question;
    self.questionLabel.text = question;
}

- (void)setAnsArray:(NSMutableArray *)ansArray {
    self.answerA.text = ansArray[0];
    self.answerB.text = ansArray[1];
    self.answerC.text = ansArray[2];
    self.answerD.text = ansArray[3];
    NSLog(@"setAns");
}

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(SCREEN_WIDTH - 32 - kInterval, 20 + kInterval, 32, 32);
    [self addSubview:closeBtn];
    self.closeBtn = closeBtn;
    
    //题目标题
    UIView *questionView = [[UIView alloc] initWithFrame:CGRectMake(kInterval, closeBtn.bottom + kInterval + 50, SCREEN_WIDTH - 2 * kInterval, 40)];
    questionView.layer.cornerRadius = 20;
    questionView.layer.masksToBounds = YES;
    //    questionView.backgroundColor = UIColor.whiteColor;
    [self addSubview:questionView];
    
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kInterval, 0, questionView.width - 2 * kInterval, 40)];
    questionLabel.text = @"题目";
    [questionView addSubview:questionLabel];
    questionLabel.textAlignment = NSTextAlignmentCenter;
    questionLabel.font = [UIFont boldSystemFontOfSize:20];
    questionLabel.textColor = [UIColor colorWithRed:72 / 255.0 green:197 / 355.0 blue:149 / 255.0 alpha:1.0];
    self.questionLabel = questionLabel;
    
    //添加答案
    self.answerA = [self getAnswerViewWithTitle:@"A." andY:questionView.bottom + kInterval * 2];
    self.answerA.tag = 1001;
    
    self.answerB = [self getAnswerViewWithTitle:@"B." andY:_answerA.bottom + kInterval];
    self.answerB.tag = 1002;
    
    self.answerC = [self getAnswerViewWithTitle:@"C." andY:_answerB.bottom + kInterval];
    self.answerC.tag = 1003;
    
    self.answerD = [self getAnswerViewWithTitle:@"D." andY:_answerC.bottom + kInterval];
    self.answerD.tag = 1004;
    
    UILabel *timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    timerLabel.center_x = SCREEN_WIDTH * 0.5;
    timerLabel.y = self.closeBtn.y + 2 * kInterval;
    timerLabel.textAlignment = NSTextAlignmentCenter;
    timerLabel.font = [UIFont boldSystemFontOfSize:30];
    timerLabel.textColor = [UIColor colorWithRed:54 / 255.0 green:54 / 255.0 blue:54 / 255.0 alpha:1.0];
    timerLabel.text = @"20";
    
    [self addSubview:timerLabel];
    
    self.timerLabel = timerLabel;
    
    
    // 初始化进度条
    ZKGameProgressView *leftView = [[ZKGameProgressView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 20, 0, 0)];
    leftView.type = ZKGameProgressViewTypeLeft;
    
    [self addSubview:leftView];
    self.leftProgress = leftView;
    
    ZKGameProgressView *rightView = [[ZKGameProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT - 20, 0, 0 )];
    rightView.type = ZKGameProgressViewTypeRight;
    [self addSubview:rightView];
    self.rightProgress = rightView;
    
}

- (void)setLeftUserWithInfo:(NSMutableDictionary *)left andRightInfo:(NSMutableDictionary *)right {
    UIView *leftUser = [self getHeaderViewWithImg:left[@"header"] andName:left[@"name"]];
    leftUser.x = kInterval;
    leftUser.y = self.answerD.bottom + kInterval;
    
    [self addSubview:leftUser];
    
    UIView *rightUser = [self getHeaderViewWithImg:right[@"header"] andName:right[@"name"]];
    rightUser.x = SCREEN_WIDTH - kInterval - rightUser.width;
    rightUser.y = self.answerD.bottom + kInterval;
    
    [self addSubview:rightUser];
}


//初始化答题区域
- (UILabel *)getAnswerViewWithTitle:(NSString *)title andY:(CGFloat)y{
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kInterval, y, SCREEN_WIDTH - 2 * kInterval, 50)];
    //    view.layer.cornerRadius = 5;
    //    view.layer.masksToBounds = YES;
    //    view.backgroundColor = UIColor.whiteColor;
    
    UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(kInterval, y, SCREEN_WIDTH - 2 * kInterval, 50)];
    answerLabel.text = title;
    answerLabel.textAlignment = NSTextAlignmentCenter;
    //    answerLabel.font = [UIFont boldSystemFontOfSize:20];
    answerLabel.textColor = [UIColor colorWithRed:72 / 255.0 green:197 / 355.0 blue:149 / 255.0 alpha:1.0];
    answerLabel.layer.cornerRadius = 5;
    answerLabel.layer.masksToBounds = YES;
    answerLabel.backgroundColor = UIColor.whiteColor;
    //    [view addSubview:answerLabel];
    [self addSubview:answerLabel];
    
    //添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [answerLabel addGestureRecognizer:tapGesture];
    answerLabel.userInteractionEnabled = YES;
    
    return answerLabel;
}

// 头像区
- (UIView *)getHeaderViewWithImg:(NSString *)imgName andName:(NSString *)name {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 80)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    imgView.frame = CGRectMake(0, 0, 50, 50);
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = imgView.height * 0.5;
    imgView.backgroundColor = UIColor.whiteColor;
    [view addSubview:imgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 50, 20)];
    nameLabel.text = name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.numberOfLines = 0;
    nameLabel.font = [UIFont systemFontOfSize:10];
    
    CGSize size = [nameLabel sizeThatFits:CGSizeMake(nameLabel.width, MAXFLOAT)];
    nameLabel.height = size.height;
    view.height = imgView.height + size.height;
    
    [view addSubview:nameLabel];
    
    return view;
}


//手势响应事件
- (void)tapAction:(UITapGestureRecognizer *)sender {
    
    UIView *view = (UIView *)sender.view;
    self.answerHandle(view.tag);
    NSLog(@"view点击:%zd",view.tag);
}

@end

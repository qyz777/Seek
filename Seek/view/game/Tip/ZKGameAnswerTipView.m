//
//  ZKGameAnswerTipView.m
//  Seek
//
//  Created by 徐正科 on 2018/8/24.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKGameAnswerTipView.h"

#define kRightBgColor UIColorFromRGB(0x5FB878)
#define kWrongBgColor UIColorFromRGB(0xFF5722)

@interface ZKGameAnswerTipView()

// 显示类型
@property(nonatomic,assign)ZKGameAnswerTipViewType viewType;

// 贝塞尔曲线
@property(nonatomic,strong)CAShapeLayer *imageShape;
@property(nonatomic,strong)CAShapeLayer *circleShape;
@property(nonatomic,strong)CAShapeLayer *circleMask;

@property(nonatomic,strong)NSMutableArray *lines;

// 关键帧
@property(nonatomic,strong)CAKeyframeAnimation *circleTransform;
@property(nonatomic,strong)CAKeyframeAnimation *circleMaskTransform;
@property(nonatomic,strong)CAKeyframeAnimation *lineStrokeStart;
@property(nonatomic,strong)CAKeyframeAnimation *lineStrokeEnd;
@property(nonatomic,strong)CAKeyframeAnimation *lineOpacity;
@property(nonatomic,strong)CAKeyframeAnimation *imageTransform;

// 颜色
@property(nonatomic,strong)UIColor *circleColor;

//图层Frame
@property(nonatomic,assign)CGRect btnFrame;
@property(nonatomic,assign)CGPoint btnCenterPoint;
@property(nonatomic,assign)CGRect lineFrame;

@end

@implementation ZKGameAnswerTipView

+ (void)showTipWithType:(ZKGameAnswerTipViewType)type {
    ZKGameAnswerTipView *view = [[ZKGameAnswerTipView alloc] initWithType:type];
    
    view.center_x = SCREEN_WIDTH * 0.5;
    view.y = SCREEN_HEIGHT * 2/3;
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view rightAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
}

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
        [self setup];
        [self createLayers];
        [self createTransforms];
    }
    
    return self;
}

- (instancetype)initWithType:(ZKGameAnswerTipViewType)type {
    if (self = [super init]) {
        self.viewType = type;
        
        self.circleColor = (self.viewType == ZKGameAnswerTipViewTypeRight ? kRightBgColor : kWrongBgColor);
        
        [self initView];
        [self setup];
        [self createLayers];
        [self createTransforms];
    }
    
    return self;
}

- (void)initView {
    CGFloat kWidht = SCREEN_WIDTH * 1/3;
    
    self.frame = CGRectMake(0, 0, kWidht,kWidht);
}

- (void)rightAnimation {
    [self select];
}

/**
 * 动画属性初始化
 */

- (void)setup {
    self.circleTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    self.circleMaskTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    self.lineStrokeStart = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    self.lineStrokeEnd = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    self.lineOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    self.imageTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
}

/**
 * 创建layer
 */

- (void)createLayers {
    self.layer.sublayers = nil;
    
    CGRect btnFrame = CGRectMake(self.width * 0.25, self.height * 0.25, self.width * 0.5, self.height * 0.5);
    YZLog(@"%@",NSStringFromCGRect(btnFrame));
    CGPoint btnCenterPoint = CGPointMake(CGRectGetMidX(btnFrame), CGRectGetMidY(btnFrame));
    CGRect lineFrame = CGRectMake(btnFrame.origin.x - btnFrame.size.width / 4, btnFrame.origin.y - btnFrame.size.height / 4, btnFrame.size.width * 1.5, btnFrame.size.height * 1.5);
    
    self.btnFrame = btnFrame;
    self.btnCenterPoint = btnCenterPoint;
    self.lineFrame = lineFrame;
    
    //=============
    // circle layer
    //=============
    
    self.circleShape = ({
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.bounds = btnFrame;
        shapeLayer.position = btnCenterPoint;
        shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:btnFrame].CGPath;
        shapeLayer.fillColor = self.circleColor.CGColor;
        shapeLayer.transform = CATransform3DMakeScale(0.0, 0.0, 1.0);
        
        shapeLayer;
    });
    
    [self.layer addSublayer:self.circleShape];
    
    //=================
    // circleMask layer
    //=================
    
    self.circleMask = ({
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.bounds = btnFrame;
        shapeLayer.position = btnCenterPoint;
        shapeLayer.fillRule = kCAFillRuleEvenOdd;   // 交集空心圆
        self.circleShape.mask = shapeLayer;
        
    
#warning 贝塞尔曲线 不理解
        // ????
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:btnFrame];
        [maskPath addArcWithCenter:btnCenterPoint radius:0.1 startAngle:0.0 endAngle:(M_PI * 2) clockwise:YES];
        shapeLayer.path = maskPath.CGPath;
        
        shapeLayer;
    });
    
    //=============
    // lines layer
    //=============
    
    // 好难，废弃
    
    self.lines = [[NSMutableArray alloc] init];
    for (int i=0; i<5; i++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        CGRect lineFrame = btnFrame;
        line.bounds = lineFrame;
        line.position = btnCenterPoint;
        line.masksToBounds = true;
        line.actions = [NSDictionary dictionaryWithObjectsAndKeys:@"strokeStart", @"", @"strokeEnd", @"", nil];
        line.strokeColor = self.circleColor.CGColor;
        line.lineWidth = 1.25;
        line.miterLimit = 1.25;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, CGRectGetMidX(lineFrame), CGRectGetMidY(lineFrame));
        CGPathAddLineToPoint(path, nil, lineFrame.origin.x + lineFrame.size.width / 2, lineFrame.origin.y);
        line.path = path;
        line.lineCap = kCALineCapRound;
        line.lineJoin = kCALineJoinRound;
        line.strokeStart = 0.f;
        line.strokeEnd = 0.f;
        line.opacity = 0.f;
        line.transform = CATransform3DMakeRotation(M_PI / 5 * (i * 2 + 1), 0.0, 0.0, 1.0);
        [self.layer addSublayer: line];
        [self.lines addObject:line];
        CGPathRelease(path);
    }
    
    //==========
    // img layer
    //==========
    
    self.imageShape =({
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.bounds = btnFrame;
        shapeLayer.position = btnCenterPoint;
        shapeLayer.path = [UIBezierPath bezierPathWithRect:btnFrame].CGPath;
        shapeLayer.fillColor = self.circleColor.CGColor;
        
        shapeLayer;
    });
    
    [self.layer addSublayer:self.imageShape];
    
    self.imageShape.mask = [CALayer layer];
    self.imageShape.mask.contents = (id)[UIImage imageNamed:(self.viewType == ZKGameAnswerTipViewTypeRight ? @"right" : @"wrong")].CGImage;
    self.imageShape.mask.position = btnCenterPoint;
    self.imageShape.mask.bounds = btnFrame;
    
}

/**
 * 创建Transforms
 */

- (void)createTransforms {
    //=================
    // circle transform
    //=================
    
    self.circleTransform.values = @[
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0, 0.0, 1.0)],   // 0/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.5, 0.5, 1.0)],   // 1/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)],   // 2/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)],   // 3/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.3, 1.3, 1.0)],   // 4/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.37, 1.37, 1.0)],   // 5/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.4, 1.4, 1.0)],   // 6/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.4, 1.4, 1.0)],   // 10/10
                                    ];
    
    self.circleTransform.keyTimes = @[
                                      @0.0,
                                      @0.1,
                                      @0.2,
                                      @0.3,
                                      @0.4,
                                      @0.5,
                                      @0.6,
                                      @1.0
                                      ];
    
    //=====================
    // circleMask Transform
    //=====================
    
    self.circleMaskTransform.values = @[
                                        [NSValue valueWithCATransform3D: CATransform3DIdentity],    //  0/10
                                        [NSValue valueWithCATransform3D: CATransform3DIdentity],    //  2/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(self.btnFrame.size.width * 1.25,  self.btnFrame.size.height * 1.25,  1.0)],    //  3/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(self.btnFrame.size.width * 2.688, self.btnFrame.size.height * 2.688, 1.0)],    //  4/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(self.btnFrame.size.width * 3.923, self.btnFrame.size.height * 3.923, 1.0)],    //  5/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(self.btnFrame.size.width * 4.375, self.btnFrame.size.height * 4.375, 1.0)],    //  6/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(self.btnFrame.size.width * 4.731, self.btnFrame.size.height * 4.731, 1.0)],    //  7/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(self.btnFrame.size.width * 5.0,   self.btnFrame.size.height * 5.0,   1.0)],    // 9/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(self.btnFrame.size.width * 5.0,   self.btnFrame.size.height * 5.0,   1.0)],    // 10/10
                                        ];
    self.circleMaskTransform.keyTimes = @[
                                          [NSNumber numberWithFloat:0.0],    //  0/10
                                          [NSNumber numberWithFloat:0.2],    //  2/10
                                          [NSNumber numberWithFloat:0.3],    //  3/10
                                          [NSNumber numberWithFloat:0.4],    //  4/10
                                          [NSNumber numberWithFloat:0.5],    //  5/10
                                          [NSNumber numberWithFloat:0.6],    //  6/10
                                          [NSNumber numberWithFloat:0.7],    //  7/10
                                          [NSNumber numberWithFloat:0.9],    //  9/10
                                          [NSNumber numberWithFloat:1.0]     // 10/10
                                          ];
    
    //================
    // image Transform
    //================
    
    self.imageTransform.values = @[
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0,   0.0,   1.0)],  //  0/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0,   0.0,   1.0)],  //  3/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.2,   1.2,   1.0)],  //  9/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.25,  1.25,  1.0)],  // 10/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.2,   1.2,   1.0)],  // 11/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.9,   0.9,   1.0)],  // 14/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.875, 0.875, 1.0)],  // 15/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.875, 0.875, 1.0)],  // 16/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.9,   0.9,   1.0)],  // 17/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.013, 1.013, 1.0)],  // 20/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.025, 1.025, 1.0)],  // 21/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.013, 1.013, 1.0)],  // 22/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.96,  0.96,  1.0)],  // 25/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.95,  0.95,  1.0)],  // 26/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.96,  0.96,  1.0)],  // 27/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.99,  0.99,  1.0)],  // 29/30
                                   [NSValue valueWithCATransform3D: CATransform3DIdentity]                       // 30/30
                                   ];
    self.imageTransform.keyTimes = @[
                                     [NSNumber numberWithFloat:0.0],    //  0/30
                                     [NSNumber numberWithFloat:0.1],    //  3/30
                                     [NSNumber numberWithFloat:0.3],    //  9/30
                                     [NSNumber numberWithFloat:0.333],  // 10/30
                                     [NSNumber numberWithFloat:0.367],  // 11/30
                                     [NSNumber numberWithFloat:0.467],  // 14/30
                                     [NSNumber numberWithFloat:0.5],    // 15/30
                                     [NSNumber numberWithFloat:0.533],  // 16/30
                                     [NSNumber numberWithFloat:0.567],  // 17/30
                                     [NSNumber numberWithFloat:0.667],  // 20/30
                                     [NSNumber numberWithFloat:0.7],    // 21/30
                                     [NSNumber numberWithFloat:0.733],  // 22/30
                                     [NSNumber numberWithFloat:0.833],  // 25/30
                                     [NSNumber numberWithFloat:0.867],  // 26/30
                                     [NSNumber numberWithFloat:0.9],    // 27/30
                                     [NSNumber numberWithFloat:0.967],  // 29/30
                                     [NSNumber numberWithFloat:1.0]     // 30/30
                                     ];
    
    //==============================
    // line stroke animation
    //==============================
    self.lineStrokeStart.values = @[
                                    [NSNumber numberWithFloat:0.0],    //  0/18
                                    [NSNumber numberWithFloat:0.0],    //  1/18
                                    [NSNumber numberWithFloat:0.18],   //  2/18
                                    [NSNumber numberWithFloat:0.2],    //  3/18
                                    [NSNumber numberWithFloat:0.26],   //  4/18
                                    [NSNumber numberWithFloat:0.32],   //  5/18
                                    [NSNumber numberWithFloat:0.4],    //  6/18
                                    [NSNumber numberWithFloat:0.6],    //  7/18
                                    [NSNumber numberWithFloat:0.71],   //  8/18
                                    [NSNumber numberWithFloat:0.89],   // 17/18
                                    [NSNumber numberWithFloat:0.92]    // 18/18
                                    ];
    self.lineStrokeStart.keyTimes = @[
                                      [NSNumber numberWithFloat:0.0],    //  0/18
                                      [NSNumber numberWithFloat:0.056],  //  1/18
                                      [NSNumber numberWithFloat:0.111],  //  2/18
                                      [NSNumber numberWithFloat:0.167],  //  3/18
                                      [NSNumber numberWithFloat:0.222],  //  4/18
                                      [NSNumber numberWithFloat:0.278],  //  5/18
                                      [NSNumber numberWithFloat:0.333],  //  6/18
                                      [NSNumber numberWithFloat:0.389],  //  7/18
                                      [NSNumber numberWithFloat:0.444],  //  8/18
                                      [NSNumber numberWithFloat:0.944],  // 17/18
                                      [NSNumber numberWithFloat:1.0],    // 18/18
                                      ];
    
    self.lineStrokeEnd.values = @[
                                  [NSNumber numberWithFloat:0.0],    //  0/18
                                  [NSNumber numberWithFloat:0.0],    //  1/18
                                  [NSNumber numberWithFloat:0.32],   //  2/18
                                  [NSNumber numberWithFloat:0.48],   //  3/18
                                  [NSNumber numberWithFloat:0.64],   //  4/18
                                  [NSNumber numberWithFloat:0.68],   //  5/18
                                  [NSNumber numberWithFloat:0.92],   // 17/18
                                  [NSNumber numberWithFloat:1.92]    // 18/18
                                  ];
    self.lineStrokeEnd.keyTimes = @[
                                    [NSNumber numberWithFloat:0.0],    //  0/18
                                    [NSNumber numberWithFloat:0.056],  //  1/18
                                    [NSNumber numberWithFloat:0.111],  //  2/18
                                    [NSNumber numberWithFloat:0.167],  //  3/18
                                    [NSNumber numberWithFloat:0.222],  //  4/18
                                    [NSNumber numberWithFloat:0.278],  //  5/18
                                    [NSNumber numberWithFloat:0.944],  // 17/18
                                    [NSNumber numberWithFloat:1.0],    // 18/18
                                    ];
    
    self.lineOpacity.values = @[
                                [NSNumber numberWithFloat:1.0],    //  0/30
                                [NSNumber numberWithFloat:1.0],    // 12/30
                                [NSNumber numberWithFloat:0.0]     // 17/30
                                ];
    self.lineOpacity.keyTimes = @[
                                  [NSNumber numberWithFloat:0.0],    //  0/30
                                  [NSNumber numberWithFloat:0.40],    // 12/30
                                  [NSNumber numberWithFloat:0.567]   // 17/30
                                  ];
}

- (void)select {
    // 动画期间禁止点击
    self.userInteractionEnabled = NO;
    [CATransaction setCompletionBlock:^{
        self.userInteractionEnabled = YES;
    }];
    
    // 动画开启
    [CATransaction begin];
    
    [CATransaction setAnimationDuration:0.5];
    
    YZLog(@"动画");
    [self.circleShape addAnimation:self.circleTransform forKey:@"transform"];
    [self.circleMask addAnimation:self.circleMaskTransform forKey:@"transform"];
    [self.imageShape addAnimation:self.imageTransform forKey:@"transform"];
    for (int i=0; i<5; i++) {
        [self.lines[i] addAnimation:self.lineStrokeStart forKey:@"strokeStart"];
        [self.lines[i] addAnimation:self.lineStrokeEnd forKey:@"strokeEnd"];
        [self.lines[i] addAnimation:self.lineOpacity forKey:@"opacity"];
    }
    
    [CATransaction commit];
}


@end

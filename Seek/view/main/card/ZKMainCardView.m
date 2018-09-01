//
//  ZKMainCardView.m
//  Seek
//
//  Created by 徐正科 on 2018/8/27.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "ZKMainCardView.h"
#import "ZKMainCardViewCell.h"
#import "ZKGameAnswerTipView.h"

@interface ZKMainCardView()

// 复用池
@property(nonatomic,strong)NSMutableSet *dequePool;
// 可视池
@property(nonatomic,strong)NSMutableArray *visiablePool;

// 角度
@property(nonatomic,assign)CGFloat angle;

@end

@implementation ZKMainCardView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
        [self initView];
    }
    
    return self;
}

- (void)setup {
    self.dequePool = [NSMutableSet new];
    self.visiablePool = [NSMutableArray new];
}

- (void)initView {
    self.frame = [UIScreen mainScreen].bounds;
//    self.backgroundColor = UIColor.orangeColor;
    
    // 初始化cell
    for(int i = 0;i < 2;i++){
        ZKMainCardViewCell *cell = [self dequeCardViewCell];
        [self addSubview:cell];
    }
    
}

/**
 * 复用机制
 */

- (ZKMainCardViewCell *)dequeCardViewCell {
    ZKMainCardViewCell *cell = [self.dequePool anyObject];  //随机获取可重用cell
    
    YZLog(@"当前可用数量:%zd",[self.dequePool count]);
    
    if (cell == nil) {
        cell = [ZKMainCardViewCell new];
//        cell.userInteractionEnabled = YES;
        // 增加拖拽手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        
        [cell addGestureRecognizer:panGesture];
    }else{
        // 使用该cell 从可用池中取出
        [self.dequePool removeObject:cell];
        
        // 初始化cell的frame
        [cell initView];
    }
    
    [self.visiablePool addObject:cell];
    YZLog(@"%@",cell);
    return cell;
}

/**
 * 拖拽
 */

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture {
    UIView *view = (UIView *)gesture.view;
    CGPoint point = [gesture translationInView:self];
    
    //是否自动过度动画
    BOOL isAuto = NO;
    //cell是否要从当前页面移出
    BOOL isFinish = NO;
    
    CGFloat angle = 0;
    int p_m = ((point.x / view.width) > 0 ? 1 : -1);
    if (gesture.state == UIGestureRecognizerStateEnded) {
        // 判断上一个angle
        if (fabs(_angle) < 30 * M_PI/ 180) {
            angle = 0;
        }else{
            angle = 90 * p_m;
            // 即将移出
            isFinish = YES;
        }
        isAuto = YES;
    }else{
        angle = (point.x / view.width) * 90 * M_PI / 180;
    }
    
    self.angle = angle;
    CGAffineTransform transform = getCGAffineTransformRotateAroundPoint(view.center_x, view.center_y, view.width * 0.5, view.height, angle);
    
    // 旋转
//    view.transform = CGAffineTransformIdentity;
    if (isAuto) {
        // 自动完成动画
        [UIView animateWithDuration:0.3 animations:^{
            view.transform = transform;
            if (isFinish) {
                // 滚动的同时
                view.center_x += SCREEN_WIDTH * p_m;
                view.center_y += SCREEN_HEIGHT * 0.5;
                view.userInteractionEnabled = NO;

            }
        } completion:^(BOOL finished) {
//            view.userInteractionEnabled = YES;
            
            if (isFinish) {
                //如果右划，收藏
                if (point.x > 0) {
                    YZLog(@"收藏");
                    [ZKGameAnswerTipView showTipWithType:ZKGameAnswerTipViewTypeLike];
                }
                
                self.angle = 0;
                view.transform = CGAffineTransformIdentity;
                [view removeFromSuperview];
                // 移入复用池
                [self.dequePool addObject:view];
                // 移出可视层
                [self.visiablePool removeObject:view];
                
                YZLog(@"获取新的cell");
                ZKMainCardViewCell *cell = [self dequeCardViewCell];
                [self insertSubview:cell atIndex:0];
                //添加到可视层
                [self.visiablePool addObject:cell];
                
                [self setFirstCellEnabled];
            }
        }];
    }else{
        view.transform = transform;
    }
}

/**
 * 可见控件可操作
 */

- (void)setFirstCellEnabled {
    ZKMainCardViewCell *cell = [self.visiablePool firstObject];
    cell.userInteractionEnabled = YES;
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

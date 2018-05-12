//
//  YZFindLayoutAttributes.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZFindLayoutAttributes.h"

@implementation YZFindLayoutAttributes

- (instancetype)init {
    if (self = [super init]) {
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.angle = 0;
    }
    return self;
}

- (void)setAngle:(CGFloat)angle {
    _angle = angle;
    self.zIndex = angle * 1000000;
    self.transform = CGAffineTransformMakeRotation(angle);
}

- (id)copyWithZone:(NSZone *)zone {
    YZFindLayoutAttributes *copyAttributes = (YZFindLayoutAttributes *)[super copyWithZone:zone];
    copyAttributes.anchorPoint = self.anchorPoint;
    copyAttributes.angle = self.angle;
    return copyAttributes;
}


@end

//
//  UIView+ZKCategory.m
//  Seek
//
//  Created by 徐正科 on 2018/5/26.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "UIView+ZKCategory.h"

@implementation UIView (ZKCategory)

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    return self.height + self.y;
}

- (void)setCenter_x:(CGFloat)center_x {
    CGPoint point = self.center;
    point.x = center_x;
    self.center = point;
}

- (CGFloat)center_x {
    return self.center.x;
}

- (void)setCenter_y:(CGFloat)center_y {
    CGPoint point = self.center;
    point.y = center_y;
    self.center = point;
}

- (CGFloat)center_y {
    return self.center.y;
}

@end

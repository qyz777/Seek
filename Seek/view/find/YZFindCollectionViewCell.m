//
//  YZFindCollectionViewCell.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZFindCollectionViewCell.h"
#import "YZFindLayoutAttributes.h"

@implementation YZFindCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    YZFindLayoutAttributes *yzLayoutAttributes = (YZFindLayoutAttributes *)layoutAttributes;
    self.layer.anchorPoint = yzLayoutAttributes.anchorPoint;
    CGPoint center = self.center;
    center.y += (yzLayoutAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds);
    self.center = center;
}

@end

//
//  YZFindLayout.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZFindLayout.h"
#import "YZFindLayoutAttributes.h"

#define ItemWidth 80
#define RightMargin 5

@interface YZFindLayout()
/**
 *   半径
 */
@property(nonatomic, assign)CGFloat radius;
/**
 *  大小
 */
@property(nonatomic, assign)CGSize itemSize;
/**
 *  单位夹角
 */
@property(nonatomic, assign)CGFloat anglePerItem;
/**
 *  布局属性数组
 */
@property(nonatomic, copy)NSArray <YZFindLayoutAttributes *> *attributesList;
/**
 *  单位偏移角度
 */
@property(nonatomic, assign)CGFloat angle;
/**
 *  总偏移角度
 */
@property(nonatomic, assign)CGFloat angleAtExtreme;
@property(nonatomic, assign)NSInteger startIndex;
@property(nonatomic, assign)NSInteger endIndex;

@end


@implementation YZFindLayout

- (instancetype)init {
    if (self = [super init]) {
        [self initial];
    }
    return self;
}

- (void)initial {
    self.itemSize = CGSizeMake(ItemWidth, ItemWidth);
    self.radius = (CGRectGetWidth([UIScreen mainScreen].bounds))* 0.5f - ItemWidth - RightMargin;
    self.anglePerItem = M_PI_2 / 2;
    self.startIndex = 0;
    self.endIndex = 8;
}

+ (Class)layoutAttributesClass {
    return [YZFindLayoutAttributes class];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

- (void)prepareLayout{
    [super prepareLayout];
    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds) * 0.5f;
    NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
    CGFloat anchorPointY =  -(self.radius) / self.itemSize.height;
    
    self.startIndex = 0;
    self.endIndex = [self.collectionView numberOfItemsInSection:0] - 1;
    
    NSMutableArray *mAttributesList = [NSMutableArray arrayWithCapacity:numberOfItem];
    self.endIndex = self.startIndex + 7;
    for (NSInteger index = self.startIndex; index < self.endIndex; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        YZFindLayoutAttributes *attributes = [YZFindLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.size = self.itemSize;
        attributes.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds) + self.radius);
        attributes.anchorPoint = CGPointMake(0.5, anchorPointY);
        attributes.angle = self.anglePerItem * index + self.angle;
        if (attributes.angle <= -(M_PI * 2) / 3) {
            self.endIndex++;
            CGFloat alpha = (((M_PI * 2) / 3 + M_PI / 8.0) + attributes.angle)/(M_PI/8.0);
            attributes.alpha = alpha;
            
            if (self.endIndex >= numberOfItem) {
                self.endIndex = numberOfItem;
                
            }
        } else if (attributes.angle > (M_PI_2) + M_PI_2 * 0.5) {
            CGFloat alpha = (M_PI - attributes.angle) / M_PI_4;
            attributes.alpha = alpha;
        }
        [mAttributesList addObject:attributes];
    }
    self.attributesList = [mAttributesList copy];
}

- (CGSize)collectionViewContentSize {
    NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(numberOfItem * ItemWidth , self.collectionView.bounds.size.height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.attributesList[indexPath.row];
}

// // -M_PI_2的原因是使每个 Item向右偏移 90 度角
- (CGFloat)angle {
    return self.angleAtExtreme * self.collectionView.contentOffset.x / ([self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds)) - M_PI_2;
}

- (CGFloat)angleAtExtreme {
    return [self.collectionView numberOfItemsInSection:0] > 0 ?
    -([self.collectionView numberOfItemsInSection:0] - 5) * self.anglePerItem : 0;
}

@end

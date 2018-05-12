//
//  YZFindView.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZFindView.h"
#import "YZFindLayout.h"
#import "YZFindCollectionViewCell.h"

static NSString *identifier = @"cell";

@implementation YZFindView

- (instancetype)initWithFrame:(CGRect)frame {
    YZFindLayout *layout = [[YZFindLayout alloc]init];
    self = [super initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight) collectionViewLayout:layout];
    self.delegate = self;
    self.dataSource = self;
    [self initSubviews];
    return self;
}

- (void)initSubviews {
    self.backgroundColor = [UIColor blackColor];
    self.showsVerticalScrollIndicator = false;
    self.showsHorizontalScrollIndicator = false;
    [self registerClass:[YZFindCollectionViewCell class] forCellWithReuseIdentifier:identifier];
}

#pragma make - dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YZFindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = RGB(arc4random() % 255, arc4random() % 255, arc4random() % 255);
    cell.layer.cornerRadius = 40;
    return cell;
}

#pragma make - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    YZFindCollectionViewCell *cell = (YZFindCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self.yz_delegate respondsToSelector:@selector(cellDidSelectedWithDict:color:)]) {
        [self.yz_delegate cellDidSelectedWithDict:nil color:cell.backgroundColor];
    }
}

@end

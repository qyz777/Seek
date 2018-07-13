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
#import <AudioToolbox/AudioToolbox.h>

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
    self.backgroundColor = BACKGROUND_COLOR_STYLE_TWO;
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
    YZFindCollectionViewCell *cell = (YZFindCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self.yz_delegate respondsToSelector:@selector(cellDidSelectedWithWord:color:)]) {
        [self.yz_delegate cellDidSelectedWithWord:_dataArray[indexPath.row] color:cell.backgroundColor];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat distanceFromLeft = scrollView.contentSize.width - offset;
    if (distanceFromLeft <= width) {
        [self.yz_delegate viewWillRefreshWithHeight:width - distanceFromLeft];
    }
    if (offset <= 0) {
        [self.yz_delegate viewWillRefreshWithHeight:fabs(offset)];
    }
    if (offset > 0 && distanceFromLeft > width) {
        [self.yz_delegate viewNotShowRefresh];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat width = scrollView.frame.size.width;
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat distanceFromLeft = scrollView.contentSize.width - offset;
    if (distanceFromLeft <= width - 75) {
//        到最左侧刷新
        [self.yz_delegate viewDidEndRefresh];
        AudioServicesPlaySystemSound(1519);
    }
    if (offset < -75) {
//        到最右侧刷新
        [self.yz_delegate viewDidEndRefresh];
        AudioServicesPlaySystemSound(1519);
    }
}

@end

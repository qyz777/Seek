//
//  YZFindView.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZFindViewDelegate <NSObject>

- (void)cellDidSelectedWithWord:(NSString *)word color:(UIColor *)vcolor;

@required
- (void)viewWillRefreshWithHeight:(CGFloat)height;
- (void)viewDidEndRefresh;
- (void)viewNotShowRefresh;

@end

@interface YZFindView : UICollectionView
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak)id<YZFindViewDelegate> yz_delegate;

@property(nonatomic, copy)NSArray *dataArray;


@end

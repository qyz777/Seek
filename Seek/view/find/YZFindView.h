//
//  YZFindView.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZFindViewDelegate <NSObject>

- (void)cellDidSelectedWithDict:(NSDictionary *)dict color:(UIColor *)color;

@end

@interface YZFindView : UICollectionView
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak)id<YZFindViewDelegate> yz_delegate;

@end

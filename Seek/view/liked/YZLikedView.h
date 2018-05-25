//
//  YZLikedView.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/25.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZLikedViewDelegate <NSObject>

- (void)cellDidSelectWithWord:(NSString *)word;

@end

@interface YZLikedView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, copy)NSArray *dataArray;

@end

//
//  YZSearchTableView.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/8.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSNotificationName const SearchTableViewDidScrollNotification;

@protocol YZSearchTableViewDelegate <NSObject>

- (void)cellDidSelectWithDict:(NSDictionary*)dict;
- (void)cellDidSelectWithSearchHistoryArray:(NSArray*)array;
- (void)clearSearchHistoryBtnDidTouchUpInside;

@end


@interface YZSearchTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UIButton *clearHistoryBtn;

@property(nonatomic, copy)NSArray<NSDictionary *> *dataArray;
@property(nonatomic, copy)NSArray<NSDictionary *> *historyDataArray;

@property(weak,nonatomic)id<YZSearchTableViewDelegate> yz_delegate;

@end

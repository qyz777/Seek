//
//  MeView.h
//  Seek
//
//  Created by Q YiZhong on 2018/6/19.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeHeaderView.h"


typedef NS_ENUM(NSInteger, MeCell) {
    MeCellRank = 0,
    MeCellSetting
};

@protocol MeViewDelegate <NSObject>

- (void)avatarImageDidSelect;
- (void)rankCellDidSelect;
- (void)settingCellDidSelect;
- (void)logOutBtnDidClicked;

@end

@interface MeView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *logOutBtn;
@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, weak) id<MeViewDelegate> yz_delegate;

@end

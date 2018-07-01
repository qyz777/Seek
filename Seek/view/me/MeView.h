//
//  MeView.h
//  Seek
//
//  Created by Q YiZhong on 2018/6/19.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, YZMeCellStyle) {
    YZMeAvatarCellStyle = 0,
    YZMeNormalCellStyle
};

@protocol MeViewDelegate <NSObject>

- (void)avatarCellDidSelect;

@end

@interface MeView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, weak) id<MeViewDelegate> yz_delegate;

@end

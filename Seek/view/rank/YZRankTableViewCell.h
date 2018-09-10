//
//  YZRankTableViewCell.h
//  Seek
//
//  Created by Q YiZhong on 2018/9/5.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZRankTableViewCell : UITableViewCell

//@property (nonatomic, strong) UILabel *nameLabel;
//@property (nonatomic, strong) UILabel *rankLabel;

// 排行ID
@property(nonatomic,copy)NSString *rankID;
@property(nonatomic,copy)NSString *exp;
@property(nonatomic,copy)NSString *headimg;

@property (nonatomic, strong) NSDictionary *data;

@end

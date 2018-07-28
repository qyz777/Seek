//
//  YZMeNormalCell.h
//  Seek
//
//  Created by Q YiZhong on 2018/6/19.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZMeNormalCell : UITableViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, copy) NSDictionary *data;

+ (CGFloat)cellHeight;

@end

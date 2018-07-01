//
//  YZMeAvatarCell.h
//  Seek
//
//  Created by Q YiZhong on 2018/7/1.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZMeAvatarCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, copy) NSDictionary *dataDict;

+ (CGFloat)cellHeight;

@end

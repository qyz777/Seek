//
//  MeHeaderView.h
//  Seek
//
//  Created by Q YiZhong on 2018/7/28.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeHeaderView : UIView

@property (nonatomic, strong) UIImageView *avaterImageView;
@property (nonatomic, strong) UIView *exView;
@property (nonatomic, strong) UIView *exBottomView;
@property (nonatomic, strong) UILabel *exLabel;
@property (nonatomic, strong) UILabel *exBottomLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) dispatch_source_t timer;

- (void)refreshUserData;

@end

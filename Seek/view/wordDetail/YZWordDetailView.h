//
//  YZWordDetailView.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/23.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZWord.h"

@interface YZWordDetailView : UIView

@property(nonatomic, strong)UILabel *wordLabel;
@property(nonatomic, strong)UILabel *senLabel;
@property(nonatomic, strong)UILabel *senTranLabel;
@property(nonatomic, strong)UILabel *ukPhoneLabel;
@property(nonatomic, strong)UILabel *usPhoneLabel;
@property(nonatomic, strong)UILabel *firstTranLabel;
@property(nonatomic, strong)UILabel *secondTranLabel;
@property(nonatomic, strong)UILabel *thirdTranLabel;

@property(nonatomic, strong)UIView *cardView;
@property(nonatomic, strong)UIImageView *headerImageView;

@property(nonatomic, copy)YZWord *wordData;

@end

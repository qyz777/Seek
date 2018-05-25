//
//  YZDetailView.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/12.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZWord.h"

@interface YZDetailView : UIView

@property(nonatomic, strong)UILabel *wordLabel;
@property(nonatomic, strong)UILabel *cnLabel;
@property(nonatomic, strong)UILabel *leftSymLabel;
@property(nonatomic, strong)UILabel *rightSymLabel;
@property(nonatomic, strong)UILabel *translateLabel;
@property(nonatomic, strong)UILabel *firstTranslateLabel;
@property(nonatomic, strong)UILabel *secondTranslateLabel;
@property(nonatomic, strong)UILabel *selectLabel;
@property(nonatomic, strong)UILabel *enLabel;
@property(nonatomic, strong)UIImageView *imageView;


@property(nonatomic, copy)YZWord *word;

@end

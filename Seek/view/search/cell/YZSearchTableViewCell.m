//
//  YZSearchTableViewCell.m
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import "YZSearchTableViewCell.h"

@implementation YZSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)initView {
    self.backgroundColor = [UIColor clearColor];
    self.wordLabel.textColor = [UIColor whiteColor];
    self.cnLabel.textColor = [UIColor whiteColor];
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    self.wordLabel.text = _dataDict[@"entry"];
    self.cnLabel.text = _dataDict[@"explain"];
}

- (void)setLikeDataDict:(NSDictionary *)likeDataDict {
    _likeDataDict = likeDataDict;
    self.wordLabel.text = _likeDataDict[@"word"];
    self.cnLabel.text = _likeDataDict[@"trans"];
    self.wordLabel.textColor = [UIColor blackColor];
    self.cnLabel.textColor = [UIColor blackColor];
}

@end

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
    self.wordLabel.text = @"seek";
    self.wordLabel.textColor = [UIColor whiteColor];
    self.cnLabel.text = @"vt. 寻求;寻找;探索;搜索";
    self.cnLabel.textColor = [UIColor whiteColor];
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
}

@end

//
//  YZSearchTableViewCell.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/9.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZSearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *cnLabel;

@property(nonatomic, copy)NSDictionary *dataDict;

@end

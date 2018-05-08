//
//  NSString+Custom.h
//  Masquerade-iOS
//
//  Created by Q YiZhong on 2018/4/18.
//  Copyright © 2018年 bistu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Custom)

// MD5
- (NSString*)MD5;

// 字符串反转
- (NSString*)reversal;

// 时间戳
+ (NSString*)timestape;

// 字符串Size
- (CGSize)sizeWithFont:(UIFont*)font;

@end

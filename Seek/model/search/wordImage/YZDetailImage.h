//
//  YZDetailImage.h
//  Seek
//
//  Created by Q YiZhong on 2018/5/25.
//  Copyright © 2018年 QYiZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZDetailImage : NSObject

// 获得单词详情页面的图片
+ (void)wordDetailImageSuccess:(void(^)(NSURL *imageUrl))success
                       failure:(void(^)(NSError *error))failure;

@end

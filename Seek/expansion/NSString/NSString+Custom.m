//
//  NSString+Custom.m
//  Masquerade-iOS
//
//  Created by Q YiZhong on 2018/4/18.
//  Copyright © 2018年 bistu. All rights reserved.
//

#import "NSString+Custom.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Custom)

// MD5加密
- (NSString*)MD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    unsigned int x=(int)strlen(cStr) ;
    CC_MD5(cStr, x, digest);
    NSMutableString *md5 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [md5 appendFormat:@"%02x", digest[i]];
    }
    return md5.copy;
}

// 字符串反转
- (NSString*)reversal {
    NSMutableString *s = [NSMutableString string];
    for (NSInteger i=self.length; i>0; i--) {
        unichar c = [self characterAtIndex:i];
        [s appendString:[NSString stringWithFormat:@"%c",c]];
    }
    return s.copy;
}

// 时间戳
+ (NSString*)timestape {
    NSDate *datenow = [NSDate date];
    NSInteger finishDate = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]]integerValue];
    finishDate = finishDate / 300;
    NSString *timeStape = [NSString stringWithFormat:@"%ld",(long)finishDate];
    return timeStape;
}

- (CGSize)sizeWithFont:(UIFont*)font {
    if (!self) {
        return CGSizeZero;
    }
    CGSize handleSize;
    handleSize = [self boundingRectWithSize:CGSizeZero
                                   options:NSStringDrawingUsesFontLeading
                                attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]
                                   context:nil].size;
    return handleSize;
    
}

@end

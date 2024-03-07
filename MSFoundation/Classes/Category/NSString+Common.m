//
//  NSString+Common.m
//  Coding_iOS
//
//  Created by 闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "NSString+Common.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"


@implementation NSString (Common)

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        resultSize = [self boundingRectWithSize:size
                                        options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                     attributes:@{NSFontAttributeName: font}
                                        context:nil].size;
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
#endif
    }
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    //    if ([self containsEmoji]) {
    //        resultSize.height += 10;
    //    }
    return resultSize;
}

- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}

- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}
//根据字符串的字体和size(此处size设置为字符串宽和MAXFLOAT)返回多行显示时的字符串size
- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size {
    
    CGSize resultSize;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        //段落样式
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        
        //字体大小，换行模式
        NSDictionary *attributes = @{NSFontAttributeName : font , NSParagraphStyleAttributeName : style};
        resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    } else {
        //计算正文的高度
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    return resultSize;
}

/**
 判断是否有表情
 */
- (BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                if (!(9312 <= hs && hs <= 9327)) { // 9312代表①   表示①至⑯
                    isEomji = YES;
                }
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

//限制第三方键盘（
- (BOOL)hasEmoji:(NSString*)string;
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}


- (NSString *)stringRemoveAllEmoji{
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([self isContainsEmoji:substring ] || [self hasEmoji:substring])?(@""): substring];
                          }];
    
    return buffer;
}
@end

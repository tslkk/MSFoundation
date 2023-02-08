//
//  CHDStringLimitInput.m
//  Pods
//
//  Created by WangLuyuan on 17/4/5.
//
//

#import "CHDStringLimitInput.h"

@implementation CHDStringLimitInput

+ (BOOL)exist_LimitChar:(NSString *)text
{
    // \\u0061-\\u007a 小写字母
    // \\u0041-\\u005a 大写字母
    // \\u0030-\\u0039 数字
    // \\u4E00-\\u9FFF 汉字
    
    //只能输入汉字，字母，数字，标点符号和一些特殊符号，其余的一律不能输入
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0061-\\u007a\\u0030-\\u0039\\u0020-\\u0022\u0024\\u0026-\\u0029\\u002e\\u002c-\\u002f\\u003a\\u003b\\u003f\\u3001\\u3002\\uff01\\uff08\\uff09\\uff0c\\uff1a\\uff1b\\uff1f\\u201c\\u201d\\u0040\\u4e00-\\u9fa5\\u0041-\\u005a]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    
    if (firstMatch) {

        return YES;
    }
    return NO;
}

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] && [string isEqualToString:@"(null)"]){
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [string isEqualToString:@"null"]){
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [string isEqualToString:@"<null>"]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    // non surrogate
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        // 区分九宫格输入 U+278b u'➋' -  U+2792 u'➒'
                                        if (0x278b <= hs && hs <= 0x2792) {
                                            returnValue = NO;
                                            // 九宫格键盘上 “^-^” 键所对应的为符号 ☻
                                        } else if (0x263b == hs) {
                                            returnValue = NO;
                                        } else {
                                            returnValue = YES;
                                        }
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

@end

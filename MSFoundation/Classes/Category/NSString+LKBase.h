//
//  NSString+LKBase.h
//  UnicornApp
//
//  Created by LeKe on 2019/7/6.
//  Copyright © 2019 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+TRStringWidth.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSString (LKBase)

// 日期字符串转时间戳
+ (NSTimeInterval)dateStringTransInterval:(NSString *)dateString;

+ (NSString *)currentDateString;

+ (NSString *)transIntervalTransFromatString:(NSTimeInterval)timeInterval;

+ (NSString *)transIntervalTransFromatString:(NSTimeInterval)timeInterval formatter:(NSString *)formatter;

//获取当前时间戳有方法(以秒为单位)
+ (NSString *)getNowTimeTimestamp;

// 时间戳转换为会话时间样式
+ (NSString *)timeIntervalTransConversationStyle:(NSTimeInterval)timeInterval;

// 时间戳转换为评论时间样式
+ (NSString *)timeIntervalTransCommentStyle:(NSTimeInterval)timeInterval;
// 时间戳转换为直播时间样式
+ (NSString *)timeIntervalTransLiveStyle:(NSTimeInterval)timeInterval;
// 日期转换为时分秒
+ (NSString *)timeIntervalTransCourseStyle:(NSTimeInterval)timeInterval;

+ (NSString *)lk_containSpecialChar:(NSString *)charString;

+ (NSString *)lk_containBigBracketParams:(NSDictionary *)params;

+ (NSString *)lk_dictionaryTransformGetParams:(NSDictionary *)params;

+ (NSString *)lk_md5String:(NSString *)sourceString isUpper:(BOOL)isUpper;

+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;

+ (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key;

// 字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;

// 手机号是否符号1开头11位
+ (BOOL)isMobileNumber:(NSString *)mobileNumber;

// 字符串Encoding
+ (NSString *)urlEncoding:(NSString *)string;

//ascii算一个 中文算2个 emoji算2个(不标准的做法，根据substringRange可以计算出准确的字节长度)
+ (NSString *)limitedStringForMaxBytesLength:(NSUInteger)maxLength content:(NSString *)content;

// 将数组字典转换为字符串
+ (NSString *)willJsonArrayTransformString:(NSMutableArray *)array;

// 字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dictionary;

// 字符串转字典对象
+ (NSDictionary *)stringTransfromDictionary:(NSString *)needTranStr;

//判断是否含有Emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

// 字符串是否是整数
- (BOOL)isPureInt:(NSString*)string;

// 将二进制字符串转换为数组存储
- (NSMutableArray *)intergerValueSeparated:(BOOL)isReverse;
//正则匹配
- (BOOL)isMatchesRegularExp:(NSString *)regex;
//检测中文
- (BOOL)validateChinese:(NSString *)string;

//检测中文或者中文符号
- (BOOL)validateChineseChar:(NSString *)string;

// 是否是链接
- (BOOL)isLinkUrl;
- (BOOL)checkStringIsLinkUrl:(NSString *)url;

// 字符串编码
- (NSString *)urlEncodeString;

// 反URL编码
- (NSString *)decodeFromPercentEscapeString;

// 获取字符长度
- (NSInteger)getStringLenthOfBytes;
// 截取子字符串
- (NSString *)subBytesOfstringToIndex:(NSInteger)index;

- (NSMutableAttributedString *)changeSubStringTextColor:(UIColor *)textColor
                                               textFont:(UIFont *)textFont
                                              subString:(NSString *)subString
                                                content:(NSString *)content;

- (CGSize)labelAutoCalculateRectWithLineSpace:(CGFloat)lineSpace Font:(UIFont *)font MaxSize:(CGSize)maxSize;

/**
 手机号脱敏操作
 */
- (NSString *)phoneMiddleHide:(NSInteger)middleNumber
                   startIndex:(NSInteger)startIndex;

/**
 手机号分割
 */
- (NSString *)divisionPhone:(NSString *)text;

/**
 银行卡隐藏操作
 */
- (NSString *)bankCardHideMiddleCharacter:(NSInteger)middleStarNum;

/*
 银行卡截取后几位
 **/
- (NSString *)bankCardGetSubStringBySplitNumber:(NSInteger)number;

/**
 *  将阿拉伯数字转换为中文数字
 */
- (NSString *)translationArabicNum:(NSInteger)arabicNum;

/**
 *  将阿拉伯数字转换为英文24个字母
 */
- (NSString *)translationEnglishNum:(NSInteger)englishNum;


/**
 * 浮点数千位数增加逗号分隔
 **/
- (NSString *)floatNumberFormat:(NSString *)floatNum;

/**
 将数字转成以万为单位
 */
- (NSString *)convertToTenThousandWithUnit:(NSString * _Nullable)unit formatter:(NSString * _Nullable)formatter;

/**
 将数字转换成以千为单位
 */
- (NSString *)convertToThousandWithUnit:(NSString * _Nullable)unit formatter:(NSString * _Nullable)formatter;
/**
 获取url中的参数并返回
 @param urlString 带参数的url
 @return @[NSString:无参数url, NSDictionary:参数字典]
 */
+ (NSArray*)getParamsWithUrlString:(NSString*)urlString;
@end


NS_ASSUME_NONNULL_END

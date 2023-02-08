//
//  NSString+LKBase.m
//  UnicornApp
//
//  Created by LeKe on 2019/7/6.
//  Copyright © 2019 LeKe. All rights reserved.
//

#import "NSString+LKBase.h"

#define LocalStr_None   @""

@implementation NSString (LKBase)

+ (NSTimeInterval)dateStringTransInterval:(NSString *)dateString {
    if (dateString.length <= 0) {
        return 0;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [date timeIntervalSince1970];
}

+ (NSString *)transIntervalTransFromatString:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)transIntervalTransFromatString:(NSTimeInterval)timeInterval formatter:(NSString *)formatter {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)currentDateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd/HH:mm:ss"]; //----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:[NSDate date]];
}

//获取当前时间戳有方法(以秒为单位)
+ (NSString *)getNowTimeTimestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}

+ (NSString *)timeIntervalTransConversationStyle:(NSTimeInterval)timeInterval {
    //时间显示内容
    NSTimeInterval seconds = timeInterval;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init];
    
    //2. 指定日历对象,要去取日期对象的那些部分.
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:myDate];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy/MM/dd";
    } else {
        if (nowCmps.day==myCmps.day) {
            /*dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"HH:mm";
            dateFmt.dateFormat = @"aaa hh:mm";*/
            dateFmt.dateFormat = @"HH:mm";
        } else if((nowCmps.day-myCmps.day) == 1) {
            dateFmt.dateFormat = @"昨天";
        } else if((nowCmps.day-myCmps.day) == 2) {
            dateFmt.dateFormat = @"前天";
        }
        else {
            if ((nowCmps.day-myCmps.day) >= 3) {
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"MM-dd hh:mm";
            }
        }
    }
    return [dateFmt stringFromDate:myDate];
}

// 时间戳转换为评论时间样式
+ (NSString *)timeIntervalTransCommentStyle:(NSTimeInterval)timeInterval {
    NSTimeInterval seconds = timeInterval;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init];
    
    //2. 指定日历对象,要去取日期对象的那些部分.
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:myDate];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy/MM/dd";
    } else {
        if (nowCmps.day==myCmps.day) {
            NSInteger hourDiff = nowCmps.hour - myCmps.hour;
            if ((hourDiff) > 1) {
                dateFmt.dateFormat = [NSString stringWithFormat:@"%ld小时前", hourDiff];
            }
            else {
                NSInteger minuteDiff = nowCmps.minute + (hourDiff*60) - myCmps.minute;
                if (minuteDiff > 1) {
                    dateFmt.dateFormat = [NSString stringWithFormat:@"%ld分钟前", minuteDiff];
                }
                else {
                    dateFmt.dateFormat = @"刚刚";
                }
            }
        } else if((nowCmps.day-myCmps.day) == 1) {
            dateFmt.dateFormat = @"昨天";
        } else if((nowCmps.day-myCmps.day) == 2) {
            dateFmt.dateFormat = @"前天";
        }
        else {
            if ((nowCmps.day-myCmps.day) >= 3 && (nowCmps.day-myCmps.day < 7)) {
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"MM-dd hh:mm";
            }
        }
    }
    return [dateFmt stringFromDate:myDate];
}

+ (NSString *)timeIntervalTransLiveStyle:(NSTimeInterval)timeInterval {
    NSTimeInterval seconds = timeInterval;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init];
    if (nowCmps.year == myCmps.year && nowCmps.month == myCmps.month && nowCmps.day == myCmps.day) {
        dateFmt.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"今日 %@", [dateFmt stringFromDate:myDate]];
    } else if (nowCmps.year == myCmps.year && nowCmps.month == myCmps.month && nowCmps.day + 1 == myCmps.day) {
        dateFmt.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"明日 %@", [dateFmt stringFromDate:myDate]];
    } else {
        dateFmt.dateFormat = @"MM月dd日 HH:mm";
        return [dateFmt stringFromDate:myDate];
    }
}

// 日期转换为时分秒
+ (NSString *)timeIntervalTransCourseStyle:(NSTimeInterval)timeInterval {
    NSInteger second = (NSInteger)timeInterval;
    
    NSString *minute = [NSString stringWithFormat:@"%02ld",(second%3600)/60];
    NSString *diffSecond = [NSString stringWithFormat:@"%02ld", second%60];
    if ([minute integerValue]>0) {
        return [NSString stringWithFormat:@"%@分%@秒",minute, diffSecond];
    }
    else {
        return [NSString stringWithFormat:@"%@秒", diffSecond];
    }
}

+ (NSString *)lk_containSpecialChar:(NSString *)charString {
    return [charString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSString *)lk_containBigBracketParams:(NSDictionary *)params {
    NSString *content = [NSString new];
    NSInteger count = [params.allKeys count];
    if (count > 0) {
        if ([params objectForKey:@"courseID"]) {
            content = [NSString stringWithFormat:@"%@",[params objectForKey:@"courseID"]];
        }
    }
    return content;
}

+ (NSString *)lk_dictionaryTransformGetParams:(NSMutableDictionary *)params {
    NSString *content = @"?";
    NSInteger count  = [params.allKeys count];
    for (int i = 0; i < count; i ++) {
        NSString *key = [params.allKeys objectAtIndex:i];
        NSString *value = [params objectForKey:key];
        content = [content stringByAppendingString:[NSString stringWithFormat:@"%@=%@", key, value]];
        if (i != count - 1) {
            content = [content stringByAppendingString:@"&"];
        }
    }
    return content;
}

+ (NSString *)lk_md5String:(NSString *)sourceString isUpper:(BOOL)isUpper {
    if(!sourceString){
        return nil;//判断sourceString如果为空则直接返回nil。
    }
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = sourceString.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    //将加密完成的字符拼接起来使用（16进制的）。
    //声明一个可变字符串类型，用来拼接转换好的字符
    NSMutableString *resultString = [[NSMutableString alloc]init];
    //遍历所有的result数组，取出所有的字符来拼接
    for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
        if (isUpper) {
            [resultString  appendFormat:@"%02X",result[i]];
        }
        else {
            [resultString  appendFormat:@"%02x",result[i]];
        }
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
    }
    //打印最终需要的字符
    return resultString;
}

//加密
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    
    char * keyChar =(char*)[key UTF8String];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          keyChar, kCCKeySizeDES,
                                          keyChar,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [self convertDataToHexStr:data];
        ciphertext = [ciphertext uppercaseString];
    }
    return ciphertext;
}

//解密
+ (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key
{
    NSData* cipherData =[self convertHexStrToData:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
   
    char * keyChar =(char*)[key UTF8String];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          keyChar,
                                          kCCKeySizeDES,
                                          keyChar,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}


//将NSData转成16进制
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

//将16进制字符串转成NSData
+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

+ (BOOL)isBlankString:(NSString *)string {
    if (!string) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!string.length) {
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
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [string stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

// 手机号是否符号1开头11位
+ (BOOL)isMobileNumber:(NSString *)mobileNumber {
    NSString *mobile = @"^1\\d{10}$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    if ([regextest evaluateWithObject:mobileNumber] == YES) {
        return YES;
    }
    return NO;
}

//判断是否含有Emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}

+ (NSString *)urlEncoding:(NSString *)string {
    NSString *urlStr = [string stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "] invertedSet]];
    return urlStr;
}

+ (NSString *)willJsonArrayTransformString:(NSMutableArray *)array {
    if (!array && array.count <= 0) {
        return nil;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:0
                                                     error:nil];
    if (data)
    {
        return [[NSString alloc] initWithData:data
                                              encoding:NSUTF8StringEncoding];
    }
    return nil;
}

// 字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dictionary
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// 字符串转字典对象
+ (NSDictionary *)stringTransfromDictionary:(NSString *)needTranStr {
    if (![NSString isBlankString:needTranStr]) {
        NSError *err = nil;
        NSData *jsonData = [needTranStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(err) {
            //解析失败
            return nil;
        }
        else {
            return dictionary;
        }
    }
    return nil;
}

// 字符串转字典对象
+ (NSDictionary *)stringToJosnDictionary:(NSString *)needTranStr {
    if (![NSString isBlankString:needTranStr]) {
        NSError *err = nil;
        NSData *jsonData = [needTranStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(err) {
            //解析失败
            return nil;
        }
        else {
            return dictionary;
        }
    }
    return nil;
}

- (BOOL)isPureInt:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

// 将二进制字符串转换为数组存储
- (NSMutableArray *)intergerValueSeparated:(BOOL)isReverse {
    NSMutableArray *tempValues = [NSMutableArray array];
    if ([NSString isBlankString:self]) {
        return nil;
    }
    NSInteger showValue = [self integerValue];
    for (int i = 0; i < self.length; i ++) {
        NSInteger divisorValue = showValue/10;
        NSInteger remainderValue = showValue%10;
        [tempValues addObject:@(remainderValue)];
        showValue = divisorValue;
    }
    if (isReverse) {
        return [[[tempValues reverseObjectEnumerator] allObjects] mutableCopy];
    }
    else {
        return tempValues;
    }
}

//检测中文或者中文符号
- (BOOL)validateChineseChar:(NSString *)string {
    NSString *nameRegEx = @"[\\u0391-\\uFFE5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

//检测中文
- (BOOL)validateChinese:(NSString *)string {
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

//正则匹配
- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (NSInteger)getStringLenthOfBytes {
    NSInteger length = 0;
    for (int i = 0; i < [self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s]) {
            length += 2;
        } else {
            length += 1;
        }
    }
    return length;
}

- (NSString *)subBytesOfstringToIndex:(NSInteger)index {
    NSInteger length = 0;
    
    NSInteger chineseNum = 0;
    NSInteger zifuNum = 0;
    
    for (int i = 0; i < [self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s]) {
            if (length + 2 > index) {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            
            length += 2;
            chineseNum += 1;
        } else {
            if (length + 1 > index) {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            length += 1;
            zifuNum += 1;
        }
    }
    return [self substringToIndex:index];
}

//ascii算一个 中文算2个 emoji算2个(不标准的做法，根据substringRange可以计算出准确的字节长度)
+ (NSString *)limitedStringForMaxBytesLength:(NSUInteger)maxLength content:(NSString *)content {
    __block NSUInteger asciiLength = 0;
    __block NSUInteger subStringRangeLen = 0;
    [content enumerateSubstringsInRange:NSMakeRange(0, content.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                              unichar uc = [substring characterAtIndex:0];
                              //英文和汉字length都是1
                              if (substringRange.length == 1) {
                                  //这里还有个坑， 有些空格是(uc == 0x2006)，不会被 isblank和 isspace命中
                                  //如果不允许出现空格，建议先取出string中的空格
                                  if (isblank(uc) || isspace(uc) || (uc == 0x2006)) {
                                      asciiLength += 1;
                                  }
                                  else if (isascii(uc)) {
                                      asciiLength += 1;
                                  }
                                  else {
                                      //汉字这里
                                      asciiLength += 2;
                                  }
                              }
                              else {
                                  //表情符号这里
                                  asciiLength += 2;
                              }
        
                              if (asciiLength <= maxLength) {
                                  subStringRangeLen = substringRange.location + substringRange.length;
                              }
                          }];
    return [content substringWithRange:NSMakeRange(0, subStringRangeLen)];
}

- (BOOL)isLinkUrl {
    if(self == nil) {
        return NO;
    }
    NSString *url;
    if (self.length > 4 && [[self substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    }
    else {
        url = self;
    }
    NSString *urlRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}

- (BOOL)checkStringIsLinkUrl:(NSString *)url {
    NSString *reg = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [urlPredicate evaluateWithObject:url];
}

// 字符串编码
- (NSString *)urlEncodeString {
    NSCharacterSet *encodeSet = [NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
}

// 反URL编码
- (NSString *)decodeFromPercentEscapeString {
    return [self stringByRemovingPercentEncoding];//解码
}


- (NSMutableArray*)calculateSubStringCount:(NSString *)content subString:(NSString *)subString {
    NSMutableArray *locationArr = [NSMutableArray new];
    NSRange range = [content rangeOfString:subString];
    if (range.location == NSNotFound){
        return locationArr;
    }
    NSInteger point = 0;
    //声明一个临时字符串,记录截取之后的字符串
    NSString * subStr = content;
    while (range.location != NSNotFound) {
        if (locationArr.count > 0) {
            point = range.location + locationArr.count * subString.length;
        } else {
            point = range.location;
        }
        //记录位置
        [locationArr addObject:@(point)];
        
        //每次记录之后,把找到的字串截取掉
        subStr = [subStr substringFromIndex:range.location + range.length];
        range = [subStr rangeOfString:subString];
    }
    return locationArr;
}

- (NSMutableAttributedString *)changeSubStringTextColor:(UIColor *)textColor textFont:(UIFont *)textFont subString:(NSString *)subString content:(NSString *)content {
    NSMutableArray *locationArray = [self calculateSubStringCount:content subString:subString];
    NSMutableAttributedString *tempAttribute = [[NSMutableAttributedString alloc] initWithString:content];
    for (int i = 0; i < locationArray.count; i ++) {
        [tempAttribute addAttributes:@{ NSFontAttributeName : textFont, NSForegroundColorAttributeName : textColor} range:NSMakeRange([[locationArray objectAtIndex:i] integerValue], subString.length)];
    }
    return tempAttribute;
}

- (CGSize)labelAutoCalculateRectWithLineSpace:(CGFloat)lineSpace Font:(UIFont *)font MaxSize:(CGSize)maxSize {
    if (!self.length) {
        return CGSizeZero;
    }
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    paragraphStyle.lineSpacing = lineSpace;
    
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    
    labelSize.height = ceil(labelSize.height);
    
    labelSize.width = ceil(labelSize.width);
    
    return labelSize;
}

/**
 手机号脱敏操作
 */
- (NSString *)phoneMiddleHide:(NSInteger)middleNumber startIndex:(NSInteger)startIndex {
    NSString *middle = @"";
    if (self.length < 4) {
        return  @"";
    }
    NSInteger length = startIndex + middleNumber;
    NSString *start = [self substringWithRange:NSMakeRange(0, startIndex)];
    NSString *end = [self substringWithRange:NSMakeRange(length, self.length - length)];
    for (int i = 0; i < middleNumber; i ++) {
        middle = [middle stringByAppendingString:@"*"];
    }
    return [NSString stringWithFormat:@"%@%@%@",start, middle, end];
}

/**
 手机号分割
 */

- (NSString *)divisionPhone:(NSString *)text {
    NSString * str = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString * phone = [NSMutableString stringWithString:str];
    if (phone.length <= 3) {
        
    }
    else if (phone.length <= 7) {
        [phone insertString:@" " atIndex:3];
    }
    else if (phone.length <= 11) {
        [phone insertString:@" " atIndex:7];
        [phone insertString:@" " atIndex:3];
    }
    return phone;
}


/**
 银行卡隐藏操作
 */
- (NSString *)bankCardHideMiddleCharacter:(NSInteger)middleStarNum {
    NSString *middle = @"";
    if (self.length < 4) {
        return  @"";
    }
    NSString *start = [self substringWithRange:NSMakeRange(0, 4)];
    NSString *end = [self substringWithRange:NSMakeRange(self.length - 4, 4)];
    for (int i = 0; i < middleStarNum; i ++) {
        middle = [middle stringByAppendingString:@"*"];
    }
    return [NSString stringWithFormat:@"%@%@%@",start, middle, end];
}


/**
 * 浮点数千位数增加逗号分隔
 **/
- (NSString *)floatNumberFormat:(NSString *)floatNum {
    NSString *floatStr = floatNum;
    
    NSArray *splitArray = [floatStr componentsSeparatedByString:@"."];
    NSString *firstObj = [splitArray firstObject];
    NSString *secondObj = [splitArray lastObject];
    if (firstObj.length < 3) {
        return floatStr;
    }
    else {
        NSString *content = @"";
        NSInteger row = firstObj.length / 3;
        NSInteger clow = firstObj.length % 3;
        if (clow == 0) {
            for (int i = 0; i < row; i ++) {
                NSString *text = [firstObj substringWithRange:NSMakeRange(0+i*3, 3)];
                content = [content stringByAppendingString:text];
                if (i < row - 1) {
                    content = [content stringByAppendingString:@","];
                }
            }
            return [NSString stringWithFormat:@"%@.%@", content, secondObj];
        }
        else {
            NSString *start = [firstObj substringWithRange:NSMakeRange(0, clow)];
            for (int i = 0; i < row; i ++) {
                NSString *text = [firstObj substringWithRange:NSMakeRange(clow+i*3, 3)];
                content = [content stringByAppendingString:text];
                if (i < row - 1) {
                    content = [content stringByAppendingString:@","];
                }
            }
            return [NSString stringWithFormat:@"%@,%@.%@",start, content, secondObj];
        }
    }
}



/*
 银行卡截取后几位
 **/
- (NSString *)bankCardGetSubStringBySplitNumber:(NSInteger)number {
    if (self.length < number) {
        return  @"";
    }
    return [self substringFromIndex:self.length - number];
}

/**
 *  将阿拉伯数字转换为中文数字
 */
- (NSString *)translationArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

/**
 *  将阿拉伯数字转换为英文24个字母
 */
- (NSString *)translationEnglishNum:(NSInteger)englishNum {
    NSArray *list = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    if (englishNum < list.count) {
        return [list objectAtIndex:englishNum];
    }
    return @"";
}

/**
 将数字转成以万为单位
 */
- (NSString *)convertToTenThousandWithUnit:(NSString *)unit formatter:(NSString *)formatter {
    NSInteger show = [self integerValue];
    NSString *result;
    if (show < 10000) {
        result = [NSString stringWithFormat:@"%@%@", self, formatter?:@""];
    } else {
        float showD = show / 10000.0;
        if ((int)(showD * 10) == (int)showD * 10) {
            result = [NSString stringWithFormat:@"%d%@%@", (int)showD, unit?:@"万", formatter?:@""];
        } else {
            result = [NSString stringWithFormat:@"%.1f%@%@", roundf(showD * 10) / 10, unit?:@"万", formatter?:@""];
        }
    }
    return result;
}

- (NSString *)convertToThousandWithUnit:(NSString *)unit formatter:(NSString *)formatter {
    NSInteger show = [self integerValue];
    NSString *result;
    if (show < 1000) {
        result = [NSString stringWithFormat:@"%@%@", self, formatter?:@""];
    } else {
        float showD = show / 1000.0;
        if ((int)(showD * 10) == (int)showD * 10) {
            result = [NSString stringWithFormat:@"%d%@%@", (int)showD, unit?:@"k", formatter?:@""];
        } else {
            result = [NSString stringWithFormat:@"%.1f%@%@", roundf(showD * 10) / 10, unit?:@"k", formatter?:@""];
        }
    }
    return result;
}


/**
 获取url中的参数并返回
 @param urlString 带参数的url
 @return @[NSString:无参数url, NSDictionary:参数字典]
 */
+ (NSArray *)getParamsWithUrlString:(NSString *)urlString {
    if(urlString.length==0) {
        NSLog(@"链接为空！");
        return @[@"",@{}];
    }
    //先截取问号
    NSArray * allElements = [urlString componentsSeparatedByString:@"?"];
    //待set的参数字典
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if(allElements.count == 2) {
        //有参数或者?后面为空
        NSString * myUrlString = allElements[0];
        NSString * paramsString = allElements[1];
        //获取参数对
        NSArray * paramsArray = [paramsString componentsSeparatedByString:@"&"];
        if(paramsArray.count >= 2) {
            for(NSInteger i =0; i < paramsArray.count; i++) {
                NSString * singleParamString = paramsArray[i];
                NSArray * singleParamSet = [singleParamString componentsSeparatedByString:@"="];
                if(singleParamSet.count==2) {
                    NSString * key = singleParamSet[0];
                    NSString * value = singleParamSet[1];
                    if(key.length > 0 || value.length > 0) {
                        [params setObject:value.length > 0 ? value:@""forKey:key.length > 0 ? key:@""];
                    }
                }
            }
        }else if(paramsArray.count==1) {
            //无 &。url只有?后一个参数
            NSString * singleParamString = paramsArray[0];
            NSArray * singleParamSet = [singleParamString componentsSeparatedByString:@"="];
            if(singleParamSet.count==2) {
                NSString * key = singleParamSet[0];
                NSString * value = singleParamSet[1];
                if(key.length > 0 || value.length > 0) {
                    [params setObject:value.length > 0? value:@""forKey:key.length > 0 ? key:@""];
                }
            }else{
                //问号后面啥也没有 xxxx?  无需处理
            }
        }
        //整合url及参数
        return @[myUrlString,params];
    }else if(allElements.count > 2) {
        NSLog(@"链接不合法！链接包含多个\"?\"");
        return @[@"",@{}];
    }else{
        NSLog(@"链接不包含参数！");
        return @[urlString,@{}];
    }
}

@end


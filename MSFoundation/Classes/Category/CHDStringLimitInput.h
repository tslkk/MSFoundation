//
//  CHDStringLimitInput.h
//  Pods
//
//  Created by WangLuyuan on 17/4/5.
//
//

#import <Foundation/Foundation.h>

@interface CHDStringLimitInput : NSObject

/*!
 *  @author WangLuyuan
 *
 *  @brief  判断是否存在限制输入的字符, 汉字，字母，数字，标点符号和一些特殊符号，其余的一律不能输入
 */
+ (BOOL)exist_LimitChar:(NSString *)text;
/*!
 *  @author WangLuyuan
 *
 *  @brief  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;

+ (BOOL)stringContainsEmoji:(NSString *)string;
@end

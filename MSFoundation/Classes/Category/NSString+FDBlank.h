//
//  NSString+FDBlank.h
//  BuildGuard
//
//  Created by 飞渡 on 2019/8/12.
//  Copyright © 2019 com.ddg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FDBlank)
/**
 判断字符串是否为空字符的方法

 @param string 字符串
 @return 是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;


/**
 判断字符串是否为空字符的方法
 
 @return 是否为空
 */
- (BOOL)stringIsBlank;


/**
 在字符串最前面添加一个空格符

 @return 字符串
 */
- (NSString *)addBlankAtFront;


/**
 在字符串最前面添加N个空格符

 @param blankCount 空格数量
 @return 字符串
 */
- (NSString *)addBlankAtFrontWithBlankCount:(NSInteger)blankCount;


/**
 在字符串最后面添加一个空格符

 @return 字符串
 */
- (NSString *)addBlankAtLast;


/**
 在字符串最后面添加N个空格符
 
 @return 字符串
 */
- (NSString *)addBlankAtLastWithBlankCount:(NSInteger)blankCount;


/**
 在字符串某一个位置添加空格符

 @param index 下标
 @return 字符串
 */
- (NSString *)addBlankAtIndex:(NSInteger)index;


/**
 在字符串某一个位置添加N个空格符

 @param index 下标
 @param blankCount 空格数量
 @return 字符串
 */
- (NSString *)addBlankAtIndex:(NSInteger)index blankCount:(NSInteger)blankCount;


/**
 在字符串两边添加空格

 @return 字符串
 */
- (NSString *)addBlankAtSides;


/**
 在字符串两边添加N个空格
 
 @return 字符串
 */
- (NSString *)addBlankAtSidesWithBlankCount:(NSInteger)blankCount;

@end

NS_ASSUME_NONNULL_END

//
//  NSString+TRStringWidth.h
//  YomoProject
//
//  Created by Tracky on 2018/4/26.
//  Copyright © 2018年 Tracky. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+TRStringWidth.h"

@interface NSString (TRStringWidth)

/*!
 *  @author Tracky,
 *
 *  @brief 宽度固定，计算字符串高度
 *
 *  @param width 固定的宽度
 *  @param font  字体
 *  @param text  字符串
 *
 *  @return 返回的大小
 */
+ (CGSize)stringSizeWithFixedWidth:(CGFloat)width
                              font:(UIFont *)font
                              text:(NSString *)text;

/*!
 *  @author Tracky,
 *
 *  @brief 高度固定，计算字符串宽度
 *
 *  @param height 固定的高度
 *  @param font   字体
 *  @param text   字符串
 *
 *  @return 返回的大小
 */
+ (CGSize)stringSizeWithFixedHeight:(CGFloat)height
                               font:(UIFont *)font
                               text:(NSString *)text;

/**
 获取字符串size

 @param font 字体
 @param size 字体范围
 @param paragraphStyle 段落样式
 @return 字符串size
 */
- (CGSize)fd_sizeWithFont:(UIFont *)font
                     size:(CGSize)size
           paragraphStyle:(NSParagraphStyle *)paragraphStyle;

/**
 获取字符串的高度

 @param font 字体
 @param width 宽度
 @return 字符串高度
 */
- (CGFloat)fd_heightWithFont:(UIFont *)font
                       width:(CGFloat)width;

/**
 获取字符串的高度

 @param font 字体
 @param width 宽度
 @param linespace 行间距
 @param lineBrekMode 分行模式
 @return 字符串高度
 */
- (CGFloat)fd_heightWithFont:(UIFont *)font
                       width:(CGFloat)width
                   linespace:(CGFloat)linespace
                        mode:(NSLineBreakMode)lineBrekMode;

/**
 获取字符串的宽度

 @param font 字体
 @param height 高度
 @return 字符串宽度
 */
- (CGFloat)fd_widthWithFont:(UIFont *)font
                     height:(CGFloat)height;

/**
 获取字符串的宽度

 @param font 字体
 @param height 高度
 @param linespace 行间距
 @param lineBrekMode 分行模式
 @return 字符串宽度
 */
- (CGFloat)fd_widthWithFont:(UIFont *)font
                     height:(CGFloat)height
                  linespace:(CGFloat)linespace
                       mode:(NSLineBreakMode)lineBrekMode;

@end

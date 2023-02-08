//
//  LKTheme.h
//  UnicornApp
//
//  Created by LeKe on 2019/6/29.
//  Copyright © 2019 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKTheme : NSObject

#pragma mark - Color
+ (UIColor *)lk_color:(int)colorValue;
+ (UIColor *)lk_color:(int)colorValue alpha:(float)alpha;

+ (UIColor *)lk_lineColor;
+ (UIColor *)lk_clearColor;

+ (UIColor *)lk_orangeRedColor;
+ (UIColor *)lk_deepGreyColor;

+ (UIColor *)lk_blackColor;
+ (UIColor *)lk_blackMediumColor;
+ (UIColor *)lk_lightBlackColor;

+ (UIColor *)lk_systemlightGrey;
+ (UIColor *)lk_systemGrey;
+ (UIColor *)lk_lightGreyColor;

+ (UIColor *)lk_whiteColor;
+ (UIColor *)lk_whiteGreyColor;
+ (UIColor *)lk_greyColorF2;
+ (UIColor *)lk_whiteGrey3Color;

+ (UIColor *)lk_lightBlueColor;
+ (UIColor *)lk_themeBlueColor;

+ (UIColor *)lk_orangeColor;

#pragma mark - font

+ (UIFont *)lk_pingRegular:(CGFloat)fontSize;
+ (UIFont *)lk_pingMedium:(CGFloat)fontSize;
+ (UIFont *)lk_pingSemiBold:(CGFloat)fontSize;

+ (UIFont *)lk_pingMedium12;
+ (UIFont *)lk_pingMedium14;
+ (UIFont *)lk_pingMedium15;
+ (UIFont *)lk_pingMedium16;
+ (UIFont *)lk_pingMedium18;
+ (UIFont *)lk_pingMedium20;
+ (UIFont *)lk_pingMedium22;
+ (UIFont *)lk_pingMedium24;

+ (UIFont *)lk_pingRegular10;
+ (UIFont *)lk_pingRegular11;
+ (UIFont *)lk_pingRegular12;
+ (UIFont *)lk_pingRegular13;
+ (UIFont *)lk_pingRegular14;
+ (UIFont *)lk_pingRegular15;
+ (UIFont *)lk_pingRegular16;
+ (UIFont *)lk_pingRegular18;
+ (UIFont *)lk_pingRegular24;

#pragma mark - size

+ (CGFloat)lk_scale;

+ (CGSize)lk_scrrenSize;

+ (CGFloat)lk_screenWidth;

+ (CGFloat)lk_screenHeight;

+ (CGFloat)lk_statuHeight;

+ (CGFloat)lk_safeBottomHeight;

+ (CGFloat)lk_fixBottomHeight;

+ (CGFloat)lk_TabbarHeight;

+ (CGFloat)lk_NavigationHeight;

+ (CGFloat)lk_scaleValue:(CGFloat)scaleValue;

#pragma mark - other

+ (BOOL)lk_isPhoneX;

+ (BOOL)lk_isPortrait;

@end

NS_ASSUME_NONNULL_END

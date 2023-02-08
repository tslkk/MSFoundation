//
//  LKTheme.m
//  UnicornApp
//
//  Created by LeKe on 2019/6/29.
//  Copyright © 2019 LeKe. All rights reserved.
//

#import "LKTheme.h"
#import "MacroConstant.h"
// 判断是否时iPhone X, 鉴于iPhone X/XS/XR/XS Max底部都会有安全距离，所以可以利用safeAreaInsets.bottom > 0.0
static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}

@implementation LKTheme


#pragma mark - Color
+ (UIColor *)lk_color:(int)colorValue {
    return HexRGB(colorValue);
}

+ (UIColor *)lk_color:(int)colorValue alpha:(float)alpha {
    return HexRGBALPHA(colorValue, alpha);
}

+ (UIColor *)lk_clearColor {
    return [UIColor clearColor];
}

+ (UIColor *)lk_lineColor {
    return [self lk_color:0xe5e5e5];
}

+ (UIColor *)lk_orangeRedColor {
    return [self lk_color:0xff4800];
}

+ (UIColor *)lk_deepGreyColor {
    return [self lk_color:0x4E4F63];
}

+ (UIColor *)lk_blackColor {
    return [self lk_color:0x333333];
}

+ (UIColor *)lk_blackMediumColor {
    return [self lk_color:0x666666];
}

+ (UIColor *)lk_lightBlackColor {
    return [self lk_color:0x999999];
}

+ (UIColor *)lk_systemlightGrey {
    return [UIColor lightGrayColor];
}

+ (UIColor *)lk_systemGrey {
    return [UIColor grayColor];
}

+ (UIColor *)lk_lightGreyColor {
    return [self lk_color:0xcccccc];
}

+ (UIColor *)lk_whiteColor {
    return [self lk_color:0xffffff];
}

+ (UIColor *)lk_whiteGreyColor {
    return [self lk_color:0xf5f5f5];
}

+ (UIColor *)lk_themeBlueColor {
    return [self lk_color:0x0174FF];
}

+ (UIColor *)lk_lightBlueColor {
    return [self lk_color:0x326DF1];
}

+ (UIColor *)lk_orangeColor {
    return [self lk_color:0xFFA400];
}

+ (UIColor *)lk_whiteGrey3Color{
    return [self lk_color:0xF8F9FA];
}

+ (UIColor *)lk_greyColorF2 {
    return [self lk_color:0xf2f2f2];
}
#pragma mark - font

+ (UIFont *)lk_pingRegular:(CGFloat)fontSize {
    fontSize = [self lk_scale] * fontSize;
    return [UIFont fontWithName:@"PingFangSC-Regular" size: fontSize];
}

+ (UIFont *)lk_pingMedium:(CGFloat)fontSize {
    fontSize = [self lk_scale] * fontSize;
    return [UIFont fontWithName:@"PingFangSC-Medium" size: fontSize];
}

+ (UIFont *)lk_pingSemiBold:(CGFloat)fontSize {
    fontSize = [self lk_scale] * fontSize;
    return [UIFont fontWithName:@"PingFangSC-Semibold" size: fontSize];
}

+ (UIFont *)lk_pingMedium12 {
    return [self lk_pingMedium:12];
}

+ (UIFont *)lk_pingMedium14 {
    return [self lk_pingMedium:14];
}

+ (UIFont *)lk_pingMedium15 {
    return [self lk_pingMedium:15];
}

+ (UIFont *)lk_pingMedium16 {
    return [self lk_pingMedium:16];
}

+ (UIFont *)lk_pingMedium18 {
    return [self lk_pingMedium:18];
}

+ (UIFont *)lk_pingMedium20 {
    return [self lk_pingMedium:20];
}

+ (UIFont *)lk_pingMedium22 {
    return [self lk_pingMedium:22];
}

+ (UIFont *)lk_pingMedium24 {
    return [self lk_pingMedium:24];
}

+ (UIFont *)lk_pingRegular10 {
    return [self lk_pingRegular:10];
}

+ (UIFont *)lk_pingRegular11 {
    return [self lk_pingRegular:11];
}

+ (UIFont *)lk_pingRegular12 {
    return [self lk_pingRegular:12];
}

+ (UIFont *)lk_pingRegular13 {
    return [self lk_pingRegular:13];
}

+ (UIFont *)lk_pingRegular14 {
    return [self lk_pingRegular:14];
}

+ (UIFont *)lk_pingRegular15 {
    return [self lk_pingRegular:15];
}

+ (UIFont *)lk_pingRegular16 {
    return [self lk_pingRegular:16];
}

+ (UIFont *)lk_pingRegular18 {
    return [self lk_pingRegular:18];
}

+ (UIFont *)lk_pingRegular24 {
    return [self lk_pingRegular:24];
}
#pragma mark - size

+ (CGFloat)lk_scale {
    if ([LKTheme lk_isPortrait]) {
        return [self lk_screenWidth]/375.0;
    }
    else
    return [self lk_screenHeight]/375.0;
}

+ (CGSize)lk_scrrenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (CGFloat)lk_screenWidth {
    return [self lk_scrrenSize].width;
}

+ (CGFloat)lk_screenHeight {
    return [self lk_scrrenSize].height;
}

+ (CGFloat)lk_statuHeight {
    return (isIPhoneXSeries() ? 44.0 : 20.0);
}

+ (CGFloat)lk_safeBottomHeight {
    return (isIPhoneXSeries() ? 34.0 : 0.0);
}

+ (CGFloat)lk_TabbarHeight {
    return (isIPhoneXSeries() ? (49.0 + 34.0) : 49.0);
}

+ (CGFloat)lk_NavigationHeight {
    return (isIPhoneXSeries() ? (44.0 + 44.0) : 64.0);
}

+ (CGFloat)lk_fixBottomHeight {
    return (isIPhoneXSeries() ? 34.0 : 16.0);
}

+ (CGFloat)lk_scaleValue:(CGFloat)scaleValue {
    if ([LKTheme lk_isPortrait]) {
        scaleValue = scaleValue * [self lk_screenWidth]/375.0;
    }
    else {
        scaleValue = scaleValue * [self lk_screenHeight]/375.0;
    }
    return scaleValue;
}

#pragma mark - other

+ (BOOL)lk_isPhoneX {
    return isIPhoneXSeries();
}

+ (BOOL)lk_isPortrait {
    CGFloat width = [LKTheme lk_screenWidth];
    CGFloat height = [LKTheme lk_screenHeight];
    if (height > width) {
        return YES;
    }
    else {
        return NO;
    }
}

@end

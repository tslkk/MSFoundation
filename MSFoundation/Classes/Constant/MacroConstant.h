//
//  MacroConstant.h
//  UnicornApp
//
//  Created by LeKe on 2019/6/27.
//  Copyright © 2019 LeKe. All rights reserved.
//

#ifndef MacroConstant_h
#define MacroConstant_h

#import "NSString+FDBlank.h"
#import "LKTheme.h"

//获取app信息
#define kAPPBundle       [[NSBundle mainBundle] infoDictionary]
#define kAppBundleId     [kAPPBundle objectForKey:@"CFBundleIdentifier"]
#define kAPPName         [kAPPBundle objectForKey:@"CFBundleDisplayName"]
#define kAPPVersion      [kAPPBundle objectForKey:@"CFBundleShortVersionString"]

#define kSystemName      [[UIDevice currentDevice] systemName]
#define kSystemVersions  [[UIDevice currentDevice] systemVersion]

#define kAppWindow       [[UIApplication sharedApplication] keyWindow]
/**颜色**/
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HexRGBALPHA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define  kLineHeight  ((1 / [UIScreen mainScreen].scale))

#define  kStandardUserDefault         [NSUserDefaults standardUserDefaults]
#define  kNotificationManager         [NSNotificationCenter defaultCenter]

#define  strFromCls(x)                NSStringFromClass(x)
#define  registerClass(obj,cls)       [obj registerClass:cls forCellReuseIdentifier:strFromCls(cls)]
#define  registerHeaderClass(obj,cls) [obj registerClass:cls forHeaderFooterViewReuseIdentifier:strFromCls(cls)]

/**单例**/
#define LKSingletonH(name) + (instancetype)shared##name;
// .m文件
#define LKSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

/* ------处理各种赋值为空的问题------*///
#define FixNull(param, default) (([NSString isBlankString:param]) ? default : param)



/* ------UI------*/
/**
 * View 圆角和加边框
 */
#define KViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/**
 * View 圆角
 */
#define KViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


#define KSCAL(value) [LKTheme lk_scaleValue:value]
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define kPlayerViewTag 100

/**
 *  @brief 随机色
 *  @since v0.1.0
 */
#define RGBCOLORRandom ([UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1])

/**
 * MSLog
 */
#ifdef DEBUG

#define MSLog(fmt, ...) NSLog((@"[路径:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String], __FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#define MSLog(fmt,...) NSLog(@"" fmt);

#endif


#endif /* MacroConstant_h */

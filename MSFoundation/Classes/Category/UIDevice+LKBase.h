//
//  UIDevice+LKBase.h
//  LekeUnicornApp
//
//  Created by LeKe on 2019/10/31.
//  Copyright © 2019 LeKe. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IPhoneDevice) {
    IPhone4 = 0,
    IPhone5N,
    IPhone6N,
    IPhonePlus,
    IPhonexNs,
    IPhonexrNmax,
    IPhoneUnknow
};

@interface UIDevice (LKBase)

+ (IPhoneDevice)currentLKDevice;

- (NSString *)getIPType;     //获取IP类型

- (NSString *)getIPAddress;    //获取IP地址

- (NSString *)platform;

- (NSString *)platformString;

//iPhone设备
- (NSString *)iPhonePlatform:(NSString *)platform;

+ (void)switchReachPortrait:(BOOL)isPortrait;
@end

NS_ASSUME_NONNULL_END

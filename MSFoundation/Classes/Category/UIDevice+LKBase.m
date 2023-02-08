//
//  UIDevice+LKBase.m
//  LekeUnicornApp
//
//  Created by LeKe on 2019/10/31.
//  Copyright © 2019 LeKe. All rights reserved.
//

#import "UIDevice+LKBase.h"
#import <sys/utsname.h>
//需要导入的头文件
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>


#define IOS_CELLULAR    @"pdp_ip0" //未知
#define IOS_WIFI        @"en0"     //wifi
#define IOS_4_3G        @"en2"     //移动网络
#define IOS_VPN         @"utun0"   //vpn


#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


@implementation UIDevice (LKBase)

/***
 #define IsiPhone11 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
 #define IsiPhone11Pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
 #define IsiPhone11ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
 // 6， 7， 8  375 * 667
 // plus 414 * 736
 // x，xs  375 * 812
 // xr  xs max  414 * 896
 // 5 320 * 568
 // 4 320 * 480
 */
+ (IPhoneDevice)currentLKDevice {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (CGSizeEqualToSize(CGSizeMake(320, 480), screenSize)) {
        return IPhone4;
    }
    else if (CGSizeEqualToSize(CGSizeMake(320, 568), screenSize)) {
        return IPhone5N;
    }
    else if (CGSizeEqualToSize(CGSizeMake(375, 667), screenSize)) {
        return IPhone6N;
    }
    else if (CGSizeEqualToSize(CGSizeMake(414, 736), screenSize)) {
        return IPhonePlus;
    }
    else if (CGSizeEqualToSize(CGSizeMake(375, 812), screenSize)) {
        return IPhonexNs;
    }
    else if (CGSizeEqualToSize(CGSizeMake(414, 896), screenSize)) {
        return IPhonexrNmax;
    }
    return IPhoneUnknow;
}

- (NSString *)platform {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    return deviceString;
}


- (NSString *)platformString {
    
    NSString *platform = [self platform];
    
    if([platform rangeOfString:@"iPhone"].location != NSNotFound){
        return [self iPhonePlatform:platform];
    }
    if([platform rangeOfString:@"iPad"].location != NSNotFound){
        return [self iPadPlatform:platform];
    }
    if([platform rangeOfString:@"iPod"].location != NSNotFound){
        return [self iPodPlatform:platform];
    }

    if ([platform isEqualToString:@"i386"])             return @"Simulator";//模拟器
    if ([platform isEqualToString:@"x86_64"])        return @"Simulator";//模拟器
    
    return @"Unknown iOS Device";
}

//iPhone设备
- (NSString *)iPhonePlatform:(NSString *)platform{
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
   //2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
    if ([platform isEqualToString:@"iPhone10,1"])  return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])  return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])  return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])  return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])  return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])  return @"iPhone X";
    //2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
    if ([platform isEqualToString:@"iPhone11,8"])  return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"])  return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])  return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])  return @"iPhone XS Max";
    //2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
    if ([platform isEqualToString:@"iPhone12,1"])  return  @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])  return  @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])  return  @"iPhone 11 Pro Max";
    
    return @"Unknown iPhone";
}

//iPad设备
- (NSString *)iPadPlatform:(NSString *)platform{
    
    if([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if([platform isEqualToString:@"iPad1,2"])   return @"iPad 3G";
    if([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (WiFi)";
    if([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (CDMA)";
    if([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini (WiFi)";
    if([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini";
    if([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini (GSM+CDMA)";
    if([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (WiFi)";
    if([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (GSM+CDMA)";
    if([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (WiFi)";
    if([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (GSM+CDMA)";
    if([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (WiFi)";
    if([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (Cellular)";
    if([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2 (WiFi)";
    if([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2 (Cellular)";
    if([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2";
    if([platform isEqualToString:@"iPad4,7"])   return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,8"])   return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,9"])   return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad5,1"])   return @"iPad Mini 4 (WiFi)";
    if([platform isEqualToString:@"iPad5,2"])   return @"iPad Mini 4 (LTE)";
    if([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,11"])  return @"iPad 5 (WiFi)";
    if([platform isEqualToString:@"iPad6,12"])  return @"iPad 5 (Cellular)";
    if([platform isEqualToString:@"iPad7,1"])   return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if([platform isEqualToString:@"iPad7,2"])   return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if([platform isEqualToString:@"iPad7,3"])   return @"iPad Pro 10.5 inch (WiFi)";
    if([platform isEqualToString:@"iPad7,4"])   return @"iPad Pro 10.5 inch (Cellular)";
    //2019年3月发布，更新二种机型：iPad mini、iPad Air
    if ([platform isEqualToString:@"iPad11,1"])   return @"iPad mini (5th generation)";
    if ([platform isEqualToString:@"iPad11,2"])   return @"iPad mini (5th generation)";
    if ([platform isEqualToString:@"iPad11,3"])   return @"iPad Air (3rd generation)";
    if ([platform isEqualToString:@"iPad11,4"])   return @"iPad Air (3rd generation)";
    
    return @"Unknown iPad";
}

//iPod设备
- (NSString *)iPodPlatform:(NSString *)platform{
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod touch (6th generation)";
    //2019年5月发布，更新一种机型：iPod touch (7th generation)
    if ([platform isEqualToString:@"iPod9,1"])      return @"iPod touch (7th generation)";

    return @"Unknown iPod";
}

//获取IP地址
- (NSString *)getIPAddress
{
//依照这些key，去取出相对应的IP地址
    NSArray *searchArray =
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_4_3G @"/" IP_ADDR_IPv4, IOS_4_3G @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6];
    
    __block NSDictionary *addresses = [self getIPAddressArray];
    //NSLog(@"获取到的整个IP信息addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
    {
         address = addresses[key];
         if ([key rangeOfString:@"ipv6"].length > 0  && ![[NSString stringWithFormat:@"%@",addresses[key]] hasPrefix:@"(null)"] ) {
             if ( ![addresses[key] hasPrefix:@"fe80"]) {
                 //     isIpv6 = YES;
                 //NSLog(@"是ivp6，退出循环，打印当前IP:%@",address);
                 *stop = YES;
              }
         }else{
             if([self isValidatIP:address]) {
                 //NSLog(@"是ivp4，退出循环，打印当前IP:%@",address);
                 *stop = YES;
             }
         }
     } ];
    return address ? address : @"";
}



//获取IP地址的类型
- (NSString *)getIPType{
    NSString *ipAddress = [self getIPAddress];
    if ([self isValidatIP:ipAddress]) {
        return @"04";//ipv4
    }else{
        return @"06";//ipv6
    }
}


//获取IP相关信息
-(NSDictionary *)getIPAddressArray
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}



//判断当前网络IP是否是Ipv4,如果是YES  否则NO
- (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            /*NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);*/
            return YES;
        }
    }
    return NO;
}

+ (void)switchReachPortrait:(BOOL)isPortrait {
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    NSNumber *orientationTarget = [NSNumber numberWithInt:(isPortrait ? UIInterfaceOrientationPortrait : UIInterfaceOrientationLandscapeRight)];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
    [UIViewController attemptRotationToDeviceOrientation];
}

@end

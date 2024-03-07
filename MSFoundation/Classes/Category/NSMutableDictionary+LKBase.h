//
//  NSMutableDictionary+LKBase.h
//  LekeUnicornApp
//
//  Created by LeKe on 2020/4/9.
//  Copyright © 2020 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (LKBase)

/**
 获取url的所有参数
 @param url 需要提取参数的url
 @return NSDictionary
 */
+ (NSMutableDictionary *)parameterWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END

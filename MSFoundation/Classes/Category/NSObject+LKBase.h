//
//  NSObject+LKBase.h
//  LekeUnicornApp
//
//  Created by LeKe on 2020/1/10.
//  Copyright © 2020 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LKBase)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector swizzling:(SEL)swizzlingSelector;

+ (void)methodSwizzling:(Class)currentCls OriginalSelector:(SEL)originalSelector swizzling:(SEL)swizzlingSelector;

@end

NS_ASSUME_NONNULL_END

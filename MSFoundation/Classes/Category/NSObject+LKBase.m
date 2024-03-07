//
//  NSObject+LKBase.m
//  LekeUnicornApp
//
//  Created by LeKe on 2020/1/10.
//  Copyright © 2020 LeKe. All rights reserved.
//

#import "NSObject+LKBase.h"
#import <objc/runtime.h>

@implementation NSObject (LKBase)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector swizzling:(SEL)swizzlingSelector {
    Class class = [self class];
    [NSObject methodSwizzling:class OriginalSelector:originalSelector swizzling:swizzlingSelector];
}

+ (void)methodSwizzling:(Class)currentCls OriginalSelector:(SEL)originalSelector swizzling:(SEL)swizzlingSelector {
    if (!currentCls) {
        currentCls = [self class];
    }
    Method originalMethod = class_getInstanceMethod(currentCls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(currentCls, swizzlingSelector);
    // 尝试给SEL 添加IMP，为了防止原来的SEL，没有实现IMP 的情况
    BOOL success = class_addMethod(currentCls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        // 添加成功，说明原来的SEL没有实现IMP,将原来的SEL的IMP 替换成交换的IMP.
        class_replaceMethod(currentCls, swizzlingSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        // 添加失败，说明原来的SEL已经有IMP,直接交换即可。
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end

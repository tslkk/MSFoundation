//
//  NSMutableDictionary+LKBase.m
//  LekeUnicornApp
//
//  Created by LeKe on 2020/4/9.
//  Copyright © 2020 LeKe. All rights reserved.
//

#import "NSMutableDictionary+LKBase.h"

@implementation NSMutableDictionary (LKBase)
/**
 获取url的所有参数
 @param url 需要提取参数的url
 @return NSDictionary
 */
+ (NSMutableDictionary *)parameterWithURL:(NSURL *)url {
 
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    return parm;
}

@end

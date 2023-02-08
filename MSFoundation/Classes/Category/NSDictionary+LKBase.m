//
//  NSDictionary+LKBase.m
//  LekeUnicornApp
//
//  Created by LeKe on 2021/7/22.
//  Copyright © 2021 LeKe. All rights reserved.
//

#import "NSDictionary+LKBase.h"

@implementation NSDictionary (LKBase)

- (NSDictionary *)jsonData2Dictionary:(NSData *)jsonData {
    if (jsonData == nil) {
        return nil;
    }
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        return nil;
    }
    return dic;
}


/**

获取url的所有参数

@param url 需要提取参数的url

@return NSDictionary

*/

- (NSDictionary *)paramerWithURL:(NSURL *)url {
    NSMutableDictionary *paramer = [[NSMutableDictionary alloc]init];

    //创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];

    //遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        [paramer setObject:obj.value forKey:obj.name];

    }];

    return paramer;
}


@end

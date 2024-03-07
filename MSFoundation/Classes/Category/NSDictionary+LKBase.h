//
//  NSDictionary+LKBase.h
//  LekeUnicornApp
//
//  Created by LeKe on 2021/7/22.
//  Copyright © 2021 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (LKBase)

- (NSDictionary *)jsonData2Dictionary:(NSData *)jsonData;

/**

获取url的所有参数

@param url 需要提取参数的url

@return NSDictionary

*/

- (NSDictionary *)paramerWithURL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END

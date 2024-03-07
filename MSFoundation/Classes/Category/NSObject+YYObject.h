//
//  NSObject+YYObject.h
//  LekeUnicornApp
//
//  Created by leke on 2021/8/12.
//  Copyright © 2021 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YYObject)

+ (instancetype)modelWithJSON:(id)json;

+ (NSArray *)modelArrayWithClass:(Class)cls json:(id)json;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;


- (NSData *)modelToJSONData;

- (id)modelToJSONObject;

- (NSString *)modelToJSONString;

@end

NS_ASSUME_NONNULL_END

//
//  NSObject+YYObject.m
//  LekeUnicornApp
//
//  Created by leke on 2021/8/12.
//  Copyright © 2021 LeKe. All rights reserved.
//

#import "NSObject+YYObject.h"
#import <YYModel/YYModel.h>

@implementation NSObject (YYObject)

+ (instancetype)modelWithJSON:(id)json {
    return [self yy_modelWithJSON:json];
}

+ (NSArray *)modelArrayWithClass:(Class)cls json:(id)json {
    return [[self class] yy_modelArrayWithClass:cls json:json];
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary {
    return [[self class] yy_modelWithDictionary:dictionary];
}


- (NSData *)modelToJSONData {
    return [self yy_modelToJSONData];
}


- (id)modelToJSONObject {
    return [self yy_modelToJSONObject];
}

- (NSString *)modelToJSONString {
    return [self yy_modelToJSONString];
}
@end

//
//  LKKeyChainStore.h
//  LekeUnicornApp
//
//  Created by 李伟杰 on 2020/8/5.
//  Copyright © 2020 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKKeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

+ (NSString *)uniqueUUID;

@end

NS_ASSUME_NONNULL_END

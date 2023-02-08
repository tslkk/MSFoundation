//
//  WKSubject.h
//  UnicornApp
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKSubject : NSObject

+ (WKSubject *)subject;

- (void)send:(_Nullable id)value;

- (void)sendComplete;

- (NSString *)subscribeNoRepeat:(void(^)(id value))block;

- (NSString *)subscribe:(void(^)(_Nullable id value))block;

- (BOOL)disposeByToken:(NSString *)token;

@end

NS_ASSUME_NONNULL_END

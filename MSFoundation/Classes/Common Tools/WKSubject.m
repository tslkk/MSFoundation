//
//  WKSubject.m
//  UnicornApp
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 LeKe. All rights reserved.
//

#import "WKSubject.h"

@implementation WKSubject {
    NSMutableDictionary *_observers; // 保存一个唯一的key， 和block
    id _lastValue;
    int _fromKey;
}

+ (WKSubject *)subject {
    WKSubject *subject = [[self alloc] init];
    subject->_observers = [[NSMutableDictionary alloc] init];
    return subject;
}

- (void)send:(id)value {
    // 发送通知
    NSArray *allkeys = _observers.allKeys;
    for (NSString *key in allkeys) {
        void (^ block)(id) = _observers[key];
        if (block) {
            block(value);
        }
    }
    _lastValue = value;
}

- (void)sendComplete {
    _lastValue = nil;
    [_observers removeAllObjects];
}

- (NSString *)subscribeNoRepeat:(void (^)(id _Nonnull))block {
    NSString *token = [self randomToken];
    // 将block 回调 和 唯一的key 存入 观察者对象里。
    [_observers setObject:[block copy] forKey:token];
    return token;
}

- (NSString *)subscribe:(void (^)(id _Nullable))block {
    block(_lastValue);
    NSString *token = [self randomToken];
    [_observers setObject:[block copy] forKey:token];
    return token;
}

- (BOOL)disposeByToken:(NSString *)token {
    // 移除观察者
    if (!token.length) return YES;
    [_observers removeObjectForKey:token];
    return YES;
}

- (NSString *)randomToken {
    NSString *tokenStr = [NSString stringWithFormat:@"wksubject-%d", _fromKey];
    _fromKey += 1;
    return tokenStr;
}

@end

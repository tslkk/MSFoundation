//
//  LKCommonFunction.m
//  LekeUnicornApp
//
//  Created by leke on 2022/2/28.
//  Copyright © 2022 LeKe. All rights reserved.
//

#import "LKCommonFunction.h"

@implementation LKCommonFunction

dispatch_semaphore_t createSemaphore(long value) {
    static dispatch_semaphore_t semaphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphore = dispatch_semaphore_create(value);
    });
    return semaphore;
}


void signalSemaphore(long value) {
    dispatch_semaphore_signal(createSemaphore(value));
}


long waitSemaphore(long value, dispatch_time_t timeout) {
    return dispatch_semaphore_wait(createSemaphore(value), timeout);
}

@end

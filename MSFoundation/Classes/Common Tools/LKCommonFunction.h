//
//  LKCommonFunction.h
//  LekeUnicornApp
//
//  Created by leke on 2022/2/28.
//  Copyright © 2022 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKCommonFunction : NSObject

FOUNDATION_EXTERN dispatch_semaphore_t createSemaphore(long value);

FOUNDATION_EXTERN void signalSemaphore(long value);

FOUNDATION_EXTERN long waitSemaphore(long value, dispatch_time_t timeout);

@end

NS_ASSUME_NONNULL_END

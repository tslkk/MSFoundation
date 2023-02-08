
#import <Foundation/Foundation.h>


@interface NSObject (DeallocNotification)

- (void)setDeallocNotificationInBlock:(dispatch_block_t)block;

- (void)removeDeallocNotification;

- (void)setDeallocNotificationWithKey:(const char *)key andBlock:(dispatch_block_t)block;

- (void)removeDeallocNotificationForKey:(const char *)key;

@end

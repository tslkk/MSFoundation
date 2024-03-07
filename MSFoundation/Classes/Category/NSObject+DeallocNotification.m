
#import "NSObject+DeallocNotification.h"
#import <objc/runtime.h>


/**
 * DeallocCallbackObject notify in deallocCallback block when dealloced
 */
@interface DeallocCallbackObject : NSObject

- (id)initWithDeallocCallback:(dispatch_block_t)deallocCallback;

- (void)removeCallback;

@end

@implementation DeallocCallbackObject
{
    dispatch_block_t callback;
}

- (id)initWithDeallocCallback:(dispatch_block_t)deallocCallback
{
    NSParameterAssert(deallocCallback);
    self = [super init];
    if (self) {
        callback = [deallocCallback copy];
    }
    return self;
}

- (void)removeCallback
{
    callback = nil;
}

- (void)dealloc
{
    if (callback) {
        callback();
    }
}

@end

/////////////////////////////// DeallocNotifier ///////////////////////////////////////////////////////////////

@implementation NSObject (DeallocNotifier)

static const char *kWBIOCDefaultDeallocNotifierKey = "kWBIOCDefaultDeallocNotifierKey";

- (void)setDeallocNotificationInBlock:(dispatch_block_t)block
{
    [self setDeallocNotificationWithKey:kWBIOCDefaultDeallocNotifierKey andBlock:block];
}

- (void)removeDeallocNotification
{
    [self removeDeallocNotificationForKey:kWBIOCDefaultDeallocNotifierKey];
}

- (void)setDeallocNotificationWithKey:(const char *)key andBlock:(dispatch_block_t)block
{
    DeallocCallbackObject *deallocNotifier = [[DeallocCallbackObject alloc] initWithDeallocCallback:block];
    objc_setAssociatedObject(self, key, deallocNotifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeDeallocNotificationForKey:(const char *)key
{
    DeallocCallbackObject *deallocNotifier = objc_getAssociatedObject(self, key);
    [deallocNotifier removeCallback];
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

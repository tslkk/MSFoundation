//
//  LKGCDTimer.m
//  LekeUnicornApp
//
//  Created by LeKe on 2022/3/8.
//  Copyright © 2022 LeKe. All rights reserved.
//

#import "LKGCDTimer.h"
@interface LKGCDTimer ()

@end

@implementation LKGCDTimer

//只初始化一次
static NSMutableDictionary *timers_; //保存定时器的字典
dispatch_semaphore_t semaphore_;  //信号量
+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}

/**
 封装GCD定时器
 
 @param task 任务block
 @param start 开始
 @param interval 间隔
 @param repeats 是否重复
 @param async 是否异步
 @return 返回定时器唯一标识
 */
+ (NSString *)execTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async
{
    if (!task || start < 0 || (interval <= 0 && repeats)) return nil;
    
    // 队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置时间
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC),
                              interval * NSEC_PER_SEC, 0);
    
    //对字典读写，加信号量锁，保证创建任务和取消任务同时只有一个在做
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    // 定时器的唯一标识
    NSString *name = [NSString stringWithFormat:@"%zd", timers_.count];
    // 存放到字典中
    timers_[name] = timer;
    dispatch_semaphore_signal(semaphore_);
    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        
        if (!repeats) { // 不重复的任务
            [self cancelTask:name];
        }
    });
    
    // 启动定时器
    dispatch_resume(timer);
    
    return name;
}

/**
 封装GCD定时器
 
 @param target 消息发送者
 @param selector 消息
 @param interval 间隔
 @param repeats 是否重复
 @param async 是否异步
 @return 返回定时器唯一标识
 */
+ (NSString *)execTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async
{
    if (!target || !selector) return nil;
    
    return [self execTask:^{
        if ([target respondsToSelector:selector]) {
//强制消除Xcode警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
#pragma clang diagnostic pop
        }
    } start:start interval:interval repeats:repeats async:async];
}

/**
 取消任务
 
 @param name 根据唯一标识取消任务
 */
+ (void)cancelTask:(NSString *)name
{
    if (name.length == 0) return;
    
    //对字典读写，加信号量锁，保证创建任务和取消任务同时只有一个在做
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    
    //从字典中移除定时器
    dispatch_source_t timer = timers_[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [timers_ removeObjectForKey:name];
    }

    dispatch_semaphore_signal(semaphore_);
}
@end

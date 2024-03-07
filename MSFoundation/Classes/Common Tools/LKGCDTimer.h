//
//  LKGCDTimer.h
//  LekeUnicornApp
//
//  Created by LeKe on 2022/3/8.
//  Copyright © 2022 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKGCDTimer : NSObject


+ (void)initialize;

/**
 封装GCD定时器
 
 @param task 任务block
 @param start 开始
 @param interval 间隔
 @param repeats 是否重复
 @param async 是否异步
 @return 返回定时器唯一标识
 */
+ (NSString *)execTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async;

/**
 封装GCD定时器
 
 @param target 消息发送者
 @param selector 消息
 @param interval 间隔
 @param repeats 是否重复
 @param async 是否异步
 @return 返回定时器唯一标识
 */
+ (NSString *)execTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async;

/**
 取消任务
 @param name 根据唯一标识取消任务
 */
+ (void)cancelTask:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

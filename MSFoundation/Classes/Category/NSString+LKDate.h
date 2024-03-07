//
//  NSString+LKDate.h
//  LekeUnicornApp
//
//  Created by LeKe on 2021/7/20.
//  Copyright © 2021 LeKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LKDate)

// 时间戳转换为IM消息时间样式
+ (NSString *)timeIntervalTransConversationStyle:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END

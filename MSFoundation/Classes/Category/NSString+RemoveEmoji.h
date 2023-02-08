//
//  NSString+RemoveEmoji.h
//  CHDCommodityMgrModule
//
//  Created by Tracky on 16/9/26.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHDStringLimitInput.h"

@interface NSString (RemoveEmoji)

- (BOOL)isIncludingEmoji;

- (instancetype)stringByRemovingEmoji;

- (instancetype)removedEmojiString __attribute__((deprecated));

@end

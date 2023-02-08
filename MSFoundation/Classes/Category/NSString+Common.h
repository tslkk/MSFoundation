//
//  NSString+Common.h
//  Coding_iOS
//
//  Created by 闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Common)

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size;

/**
 判断是否有表情
 */
- (BOOL)isContainsEmoji:(NSString *)string;

//限制第三方键盘（
- (BOOL)hasEmoji:(NSString*)string;
//移除所有的表情
- (NSString *)stringRemoveAllEmoji;

@end

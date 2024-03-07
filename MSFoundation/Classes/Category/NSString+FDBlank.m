//
//  NSString+FDBlank.m
//  BuildGuard
//
//  Created by 飞渡 on 2019/8/12.
//  Copyright © 2019 com.ddg. All rights reserved.
//

#import "NSString+FDBlank.h"

@implementation NSString (FDBlank)
/**
 判断字符串是否为空字符的方法
 
 @param string 字符串
 @return 是否为空
 */
+ (BOOL)isBlankString:(NSString *)string {
    
    if (!string){
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [string isEqualToString:@"(null)"]){
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [string isEqualToString:@"null"]){
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [string isEqualToString:@"<null>"]){
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull  class]] || [string isEqualToString:@""] || [string isEqual:nil]){
        return YES;
    }
        
    if ([string isKindOfClass:[NSString class]] && [string length]==0){
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        return YES;
    }
    
    return NO;
    
}

/**
 判断字符串是否为空字符的方法
 
 @return 是否为空
 */
- (BOOL)stringIsBlank{
    
    return [NSString isBlankString:self];
}

/**
 在字符串最前面添加一个空格符
 
 @return 字符串
 */
- (NSString *)addBlankAtFront{

    return [self addBlankAtIndex:0 blankCount:1];
}

/**
 在字符串最前面添加N个空格符
 
 @param blankCount 空格数量
 @return 字符串
 */
- (NSString *)addBlankAtFrontWithBlankCount:(NSInteger)blankCount{
    
    return [self addBlankAtIndex:0 blankCount:blankCount];
}

/**
 在字符串最后面添加一个空格符
 
 @return 字符串
 */
- (NSString *)addBlankAtLast{
    
    return [self addBlankAtIndex:self.length blankCount:1];
}

/**
 在字符串最后面添加N个空格符
 
 @return 字符串
 */
- (NSString *)addBlankAtLastWithBlankCount:(NSInteger)blankCount{
    
    return [self addBlankAtIndex:self.length blankCount:blankCount];
}

/**
 在字符串某一个位置添加空格符
 
 @param index 下标
 @return 字符串
 */
- (NSString *)addBlankAtIndex:(NSInteger)index{
    
    return [self addBlankAtIndex:index blankCount:1];
}


/**
 在字符串某一个位置添加N个空格符
 
 @param index 下标
 @param blankCount 空格数量
 @return 字符串
 */
- (NSString *)addBlankAtIndex:(NSInteger)index blankCount:(NSInteger)blankCount{
    if (self.length == 0) {
        return self;
    }
    if (blankCount < 1) {
        return self;
    }
    NSInteger blankIndex = index;
    if (self.length < index) {
         blankIndex = self.length;
    }
    NSMutableString *newValue = [[NSMutableString alloc] initWithString:self];
    NSMutableString *blankStr = [NSMutableString new];
    for (NSInteger i = 0; i < blankCount; i++) {
        [blankStr appendString:@" "];
    }
    [newValue insertString:blankStr atIndex:blankIndex];
    return newValue;
}

/**
 在字符串两边添加空格
 
 @return 字符串
 */
- (NSString *)addBlankAtSides{
    NSString *newStr = [self addBlankAtFront];
    newStr = [newStr addBlankAtLast];
    return newStr;
}

/**
 在字符串两边添加空格
 
 @return 字符串
 */
- (NSString *)addBlankAtSidesWithBlankCount:(NSInteger)blankCount{
    NSString *newStr = [self addBlankAtFrontWithBlankCount:blankCount];
    newStr = [newStr addBlankAtLastWithBlankCount:blankCount];
    return newStr;
}

@end

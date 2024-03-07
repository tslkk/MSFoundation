//
//  NSString+LKDate.m
//  LekeUnicornApp
//
//  Created by LeKe on 2021/7/20.
//  Copyright © 2021 LeKe. All rights reserved.
//

#import "NSString+LKDate.h"

@implementation NSString (LKDate)

// 时间戳转换为IM消息时间样式
+ (NSString *)timeIntervalTransConversationStyle:(NSTimeInterval)timeInterval {
    NSTimeInterval seconds = timeInterval;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init];
    
    //2. 指定日历对象,要去取日期对象的那些部分.
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:myDate];
    
    if (nowCmps.year != myCmps.year) {
        return [NSString stringWithFormat:@"%ld年%ld月%ld日",comp.year, comp.month, comp.day];
        //dateFmt.dateFormat = @"yyyy/MM/dd";
    }
    else {
        if (nowCmps.day == myCmps.day) {
            NSInteger hourDiff = nowCmps.hour - myCmps.hour;
            if ((hourDiff) > 1) {
                dateFmt.dateFormat = [NSString stringWithFormat:@"%ld小时前", hourDiff];
            }
            else {
                NSInteger minuteDiff = nowCmps.minute + (hourDiff*60) - myCmps.minute;
                if (minuteDiff > 1) {
                    dateFmt.dateFormat = [NSString stringWithFormat:@"%ld分钟前", minuteDiff];
                }
                else {
                    dateFmt.dateFormat = @"刚刚";
                }
            }
            return [dateFmt stringFromDate:myDate];
        }
        else {
            //dateFmt.dateFormat = @"MM-dd hh:mm";
            return [NSString stringWithFormat:@"%ld月%ld日 %ld:%ld", comp.month, comp.day, comp.hour, comp.minute];
        }
    }
}

@end

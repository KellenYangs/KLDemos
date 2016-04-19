//
//  NSData+kl_Extensionkl.m
//  KL-百思不得姐
//
//  Created by bcmac3 on 16/3/18.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "NSDate+kl_Extensionkl.h"

@implementation NSDate (kl_Extensionkl)
/**
 *  NSDate -> String
 */
- (NSString *)stringDate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc] init];
    // 大写的H日期格式将默认为24小时制，小写的h日期格式将默认为12小时
    [formatter setDateFormat:@"yyyy-MM-dd EEEE HH:mm:ss a"];
    // 2016-04-13 Wednesday 15:35:27 PM
    NSString *locationString=[formatter stringFromDate:self];
    return locationString;
}

/**
 *  String -> NSDate
 */
+ (NSDate *)dateByString:(NSString *)string dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:dateFormat];
    
    return [fmt dateFromString:string];
}

+ (NSDate *)dateByString:(NSString *)string
{
    return [NSDate dateByString:string dateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

/**
 *  从from 到 self 的间隔时长
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}


- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday
{
    // 2014-12-31 23:59:59 -> 2014-12-31
    // 2015-01-01 00:00:01 -> 2015-01-01
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

@end
